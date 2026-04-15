import Foundation

protocol MonitoringAPIService {
    func fetchSnapshot(
        demoModeEnabled: Bool,
        forceOffline: Bool
    ) async throws -> MonitoringSnapshot
}

enum MonitoringAPIError: Error {
    case offline
}

final class MockMonitoringAPIService: MonitoringAPIService {
    private struct HistoryWindow {
        let range: MetricRange
        let points: Int
        let interval: TimeInterval
    }

    private struct HistoryContext {
        let now: Date
        let baseValue: Double
        let amplitude: Double
        let metricKind: MetricKind
        let demoModeEnabled: Bool
    }

    private static let historyWindows: [HistoryWindow] = [
        HistoryWindow(
            range: .day24,
            points: 24,
            interval: 60 * 60
        ),
        HistoryWindow(
            range: .day7,
            points: 28,
            interval: 6 * 60 * 60
        ),
        HistoryWindow(
            range: .day30,
            points: 30,
            interval: 24 * 60 * 60
        )
    ]

    private static let baseValuesByMetric: [MetricKind: [SystemHealthState: Double]] = [
        .ph: [
            .stable: 6.2,
            .warning: 5.7,
            .critical: 5.1
        ],
        .ec: [
            .stable: 1.9,
            .warning: 2.5,
            .critical: 3.1
        ],
        .waterTemperature: [
            .stable: 21.8,
            .warning: 24.1,
            .critical: 27.3
        ],
        .waterLevel: [
            .stable: 84,
            .warning: 56,
            .critical: 28
        ]
    ]

    func fetchSnapshot(
        demoModeEnabled: Bool,
        forceOffline: Bool
    ) async throws -> MonitoringSnapshot {
        try await Task.sleep(
            for: .milliseconds(280)
        )

        if forceOffline {
            throw MonitoringAPIError.offline
        }

        let now = Date.now
        let systemState = resolvedSystemState(
            date: now,
            demoModeEnabled: demoModeEnabled
        )

        let metrics = MetricKind.allCases.map {
            metricReading(
                for: $0,
                date: now,
                state: systemState,
                demoModeEnabled: demoModeEnabled
            )
        }

        return MonitoringSnapshot(
            generatedAt: now,
            systemState: systemState,
            metrics: metrics,
            insights: insights(
                for: systemState,
                date: now
            ),
            alerts: alerts(
                for: systemState,
                date: now
            )
        )
    }

    private func resolvedSystemState(
        date: Date,
        demoModeEnabled: Bool
    ) -> SystemHealthState {
        if demoModeEnabled {
            return SystemHealthState.allCases.randomElement() ?? .stable
        }

        let hour = Calendar.current.component(
            .hour,
            from: date
        )

        switch hour % 3 {
        case 0:
            return .stable
        case 1:
            return .warning
        default:
            return .critical
        }
    }

    private func metricReading(
        for metricKind: MetricKind,
        date: Date,
        state: SystemHealthState,
        demoModeEnabled: Bool
    ) -> MetricReading {
        let context = HistoryContext(
            now: date,
            baseValue: baseValueForMetric(
                metricKind,
                state: state
            ),
            amplitude: amplitudeForMetric(
                metricKind
            ),
            metricKind: metricKind,
            demoModeEnabled: demoModeEnabled
        )

        let historyByRange = historyByRange(
            context: context
        )
        let currentValue = historyByRange[.day24]?.last?.value ?? context.baseValue

        return MetricReading(
            kind: metricKind,
            value: currentValue,
            historyByRange: historyByRange
        )
    }

    private func baseValueForMetric(
        _ metricKind: MetricKind,
        state: SystemHealthState
    ) -> Double {
        Self.baseValuesByMetric[metricKind]?[state] ?? 0
    }

    private func amplitudeForMetric(
        _ metricKind: MetricKind
    ) -> Double {
        switch metricKind {
        case .ph:
            return 0.15
        case .ec:
            return 0.30
        case .waterTemperature:
            return 0.90
        case .waterLevel:
            return 4.4
        }
    }

    private func historyByRange(
        context: HistoryContext
    ) -> [MetricRange: [MetricSample]] {
        Dictionary(
            uniqueKeysWithValues: Self.historyWindows.map { window in
                (
                    window.range,
                    makeHistory(
                        context: context,
                        window: window
                    )
                )
            }
        )
    }

    private func makeHistory(
        context: HistoryContext,
        window: HistoryWindow
    ) -> [MetricSample] {
        let seed = context.metricKind.rawValue.hashValue.magnitude

        return (0..<window.points).map { index in
            let timelineIndex = window.points - index
            let phase = Double(
                timelineIndex + Int(seed % 17)
            ) * 0.36
            let wave = sin(phase)
            let drift = cos(phase * 0.45) * context.amplitude * 0.24
            let jitter: Double

            if context.demoModeEnabled {
                jitter = Double.random(
                    in: -context.amplitude * 0.08 ... context.amplitude * 0.08
                )
            } else {
                jitter = sin(phase * 0.73) * context.amplitude * 0.05
            }

            let value = max(
                0,
                context.baseValue + (wave * context.amplitude) + drift + jitter
            )
            let timestamp = context.now.addingTimeInterval(
                -Double(window.points - 1 - index) * window.interval
            )

            return MetricSample(
                timestamp: timestamp,
                value: value
            )
        }
    }

    private func insights(
        for state: SystemHealthState,
        date: Date
    ) -> [InsightItem] {
        let stateInsight: InsightItem

        switch state {
        case .stable:
            stateInsight = InsightItem(
                title: "System is operating within expected thresholds",
                message: "Core metrics are balanced. Continue normal monitoring cadence.",
                timestamp: date,
                relatedState: state
            )
        case .warning:
            stateInsight = InsightItem(
                title: "Nutrient profile is drifting",
                message: "EC and water temperature suggest increased stress risk.",
                timestamp: date,
                relatedState: state
            )
        case .critical:
            stateInsight = InsightItem(
                title: "Immediate intervention recommended",
                message: "Multiple metrics are outside safe operating envelope.",
                timestamp: date,
                relatedState: state
            )
        }

        return [
            stateInsight,
            InsightItem(
                title: "Water level trend remains directional",
                message: "30-day view indicates a steady decline with sharper dips in the last week.",
                timestamp: date.addingTimeInterval(-45 * 60),
                relatedState: state
            ),
            InsightItem(
                title: "Sensor coherence check passed",
                message: "No sensor divergence anomalies detected in current read set.",
                timestamp: date.addingTimeInterval(-2 * 60 * 60),
                relatedState: .stable
            )
        ]
    }

    private func alerts(
        for state: SystemHealthState,
        date: Date
    ) -> [AlertItem] {
        let unreadCount: Int

        switch state {
        case .stable:
            unreadCount = 1
        case .warning:
            unreadCount = 2
        case .critical:
            unreadCount = 3
        }

        let baseAlerts = [
            AlertItem(
                title: "Reservoir check recommended",
                message: "Water level moved beyond expected short-window variance.",
                timestamp: date,
                isUnread: unreadCount >= 1,
                relatedState: state
            ),
            AlertItem(
                title: "Conductivity review pending",
                message: "EC trend suggests calibration review in the next cycle.",
                timestamp: date.addingTimeInterval(-70 * 60),
                isUnread: unreadCount >= 2,
                relatedState: state
            ),
            AlertItem(
                title: "Temperature threshold escalation",
                message: "Thermal behavior crossed warning threshold for consecutive windows.",
                timestamp: date.addingTimeInterval(-3 * 60 * 60),
                isUnread: unreadCount >= 3,
                relatedState: .critical
            ),
            AlertItem(
                title: "Previous cycle acknowledged",
                message: "Earlier warning was reviewed and resolved.",
                timestamp: date.addingTimeInterval(-20 * 60 * 60),
                isUnread: false,
                relatedState: .stable
            )
        ]

        return baseAlerts
    }
}
