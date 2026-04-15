import Foundation
import Observation

@MainActor
@Observable
final class SettingsStore {
    private enum Keys {
        static let temperatureUnit = "settings.temperatureUnit"
        static let conductivityUnit = "settings.conductivityUnit"
        static let metricOrder = "settings.metricOrder"
    }

    private let userDefaults: UserDefaults

    var temperatureUnit: TemperatureUnit {
        didSet {
            userDefaults.set(
                temperatureUnit.rawValue,
                forKey: Keys.temperatureUnit
            )
        }
    }

    var conductivityUnit: ConductivityUnit {
        didSet {
            userDefaults.set(
                conductivityUnit.rawValue,
                forKey: Keys.conductivityUnit
            )
        }
    }

    var metricOrder: [MetricKind] {
        didSet {
            let rawValues = metricOrder.map(\.rawValue)
            userDefaults.set(
                rawValues,
                forKey: Keys.metricOrder
            )
        }
    }

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults

        let savedTemperature = userDefaults.string(
            forKey: Keys.temperatureUnit
        )
        temperatureUnit = TemperatureUnit(
            rawValue: savedTemperature ?? ""
        ) ?? .celsius

        let savedConductivity = userDefaults.string(
            forKey: Keys.conductivityUnit
        )
        conductivityUnit = ConductivityUnit(
            rawValue: savedConductivity ?? ""
        ) ?? .milliSiemens

        let savedOrder = userDefaults.array(
            forKey: Keys.metricOrder
        ) as? [String] ?? []
        let decodedOrder = savedOrder.compactMap(
            MetricKind.init(rawValue:)
        )

        if decodedOrder.count == MetricKind.allCases.count {
            metricOrder = decodedOrder
        } else {
            metricOrder = MetricKind.allCases
        }
    }

    func moveMetric(
        fromOffsets: IndexSet,
        toOffset: Int
    ) {
        var mutableOrder = metricOrder
        let movingValues = fromOffsets.map(
            { mutableOrder[$0] }
        )

        for index in fromOffsets.sorted(by: >) {
            mutableOrder.remove(
                at: index
            )
        }

        let safeOffset = min(
            toOffset,
            mutableOrder.count
        )
        mutableOrder.insert(
            contentsOf: movingValues,
            at: safeOffset
        )

        metricOrder = mutableOrder
    }

    func displayUnit(
        for metricKind: MetricKind
    ) -> String {
        switch metricKind {
        case .ph:
            return ""
        case .ec:
            return conductivityUnit.title
        case .waterTemperature:
            return temperatureUnit == .celsius ? "°C" : "°F"
        case .waterLevel:
            return "%"
        }
    }

    func convertedValue(
        for metricKind: MetricKind,
        rawValue: Double
    ) -> Double {
        switch metricKind {
        case .ph:
            return rawValue
        case .ec:
            if conductivityUnit == .microSiemens {
                return rawValue * 1_000
            }
            return rawValue
        case .waterTemperature:
            if temperatureUnit == .fahrenheit {
                return (rawValue * 9 / 5) + 32
            }
            return rawValue
        case .waterLevel:
            return rawValue
        }
    }

    func displayValue(
        for metricKind: MetricKind,
        rawValue: Double
    ) -> String {
        let convertedValue = convertedValue(
            for: metricKind,
            rawValue: rawValue
        )

        switch metricKind {
        case .ph:
            return String(
                format: "%.2f",
                convertedValue
            )
        case .ec:
            if conductivityUnit == .microSiemens {
                return String(
                    format: "%.0f",
                    convertedValue
                )
            }
            return String(
                format: "%.2f",
                convertedValue
            )
        case .waterTemperature:
            return String(
                format: "%.1f",
                convertedValue
            )
        case .waterLevel:
            return String(
                format: "%.0f",
                convertedValue
            )
        }
    }
}
