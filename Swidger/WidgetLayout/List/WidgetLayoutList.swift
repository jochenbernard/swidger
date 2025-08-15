import SwiftUI

struct WidgetLayoutList: View {
    private let viewModel: WidgetLayoutListViewModel

    init(viewModel: WidgetLayoutListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if let layouts = viewModel.layouts {
            if !layouts.isEmpty {
                List(
                    layouts,
                    rowContent: WidgetLayoutRow.init
                )
            } else {
                ContentUnavailableView(
                    "No Widget Layouts",
                    systemImage: "widget.extralarge"
                )
            }
        } else {
            ProgressView()
        }
    }
}

#Preview {
    WidgetLayoutList(
        viewModel: WidgetLayoutListViewModel(
            store: .mock
        )
    )
}
