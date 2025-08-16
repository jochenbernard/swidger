import SwiftUI
import SwiftUICommon

struct WidgetLayoutIconPicker: View {
    @Environment(\.dismiss)
    private var dismiss

    @Binding private var selection: WidgetLayoutIcon

    init(selection: Binding<WidgetLayoutIcon>) {
        self._selection = selection
    }

    var body: some View {
        LazyVGrid(
            columnCount: 6,
            spacing: 8.0,
        ) {
            ForEach(
                WidgetLayoutIcon.allCases,
                id: \.rawValue
            ) { icon in
                Button(
                    action: { select(icon) },
                    label: { WidgetLayoutIconView(icon) }
                )
                .tint(
                    selection == icon
                    ? .accentColor
                    : .primary
                )
            }
        }
        .buttonStyle(.borderless)
        .padding(8.0)
        .fixedSize()
    }

    private func select(_ icon: WidgetLayoutIcon) {
        dismiss()
        selection = icon
    }
}

private struct WidgetLayoutIconPickerPreview: View {
    @State private var selection = WidgetLayoutIcon.square

    var body: some View {
        WidgetLayoutIconPicker(selection: $selection)
    }
}

#Preview {
    WidgetLayoutIconPickerPreview()
}
