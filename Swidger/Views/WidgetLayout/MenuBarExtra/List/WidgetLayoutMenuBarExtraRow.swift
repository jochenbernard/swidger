import SwiftUI
import SwiftUICommon

struct WidgetLayoutMenuBarExtraRow: View {
    private let layout: WidgetLayout
    @Bindable private var viewModel: WidgetLayoutListViewModel

    @State private var isHovered = false

    init(
        _ layout: WidgetLayout,
        viewModel: WidgetLayoutListViewModel
    ) {
        self.layout = layout
        self.viewModel = viewModel
    }

    var body: some View {
        Button(action: apply) {
            HStack(spacing: 4.0) {
                Image(systemName: layout.icon.systemImage)
                    .accessibilityLabel(layout.icon.systemImage)
                    .frame(size: 24.0)

                Text(layout.name)
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(4.0)
            .background {
                if isHovered {
                    Rectangle()
                        .fill(.fill.secondary)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
            .animation(
                .default.speed(4.0),
                value: isHovered
            )
        }
        .buttonStyle(.borderless)
        .onHover(perform: { isHovered = $0 })
    }

    private func apply() {
        viewModel.apply(layout)
    }
}

#Preview {
    WidgetLayoutMenuBarExtraRow(
        .mock,
        viewModel: WidgetLayoutListViewModel(
            store: WidgetLayoutStore(
                manager: .mock
            )
        )
    )
}
