import SwiftUI

struct DashboardMetricOrderSheet: View {
    @Bindable var viewModel: DashboardViewModel

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(
                    viewModel.metricOrder,
                    id: \.self
                ) { metricKind in
                    MetricRow(
                        metricKind: metricKind
                    )
                }
                .onMove { offsets, destination in
                    viewModel.moveMetric(
                        fromOffsets: offsets,
                        toOffset: destination
                    )
                }
            }
            .accessibilityIdentifier(
                DashboardAccessibilityIdentifiers.metricOrderList
            )
            .environment(
                \.editMode,
                .constant(.active)
            )
            .navigationTitle("Reorder Metrics")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(
                    placement: .topBarTrailing
                ) {
                    Button("Done") {
                        dismiss()
                    }
                    .accessibilityIdentifier(
                        DashboardAccessibilityIdentifiers.metricOrderSheetDoneButton
                    )
                }
            }
        }
    }
}
