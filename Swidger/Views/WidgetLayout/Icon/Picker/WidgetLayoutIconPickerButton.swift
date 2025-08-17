import SwiftUI

struct WidgetLayoutIconPickerButton: View {
    @Binding private var icon: WidgetLayoutIcon
    @Binding private var color: WidgetLayoutColor

    @State private var isPopoverPresented = false

    init(
        icon: Binding<WidgetLayoutIcon>,
        color: Binding<WidgetLayoutColor>
    ) {
        self._icon = icon
        self._color = color
    }

    var body: some View {
        Button(action: presentPopover) {
            WidgetLayoutIconView(
                icon: icon,
                color: color.color
            )
        }
        .buttonStyle(.borderless)
        .popover(isPresented: $isPopoverPresented) {
            WidgetLayoutIconPicker(
                icon: $icon,
                color: $color
            )
        }
    }

    private func presentPopover() {
        isPopoverPresented = true
    }
}

private struct WidgetLayoutIconPickerButtonPreview: View {
    @State private var icon = WidgetLayoutIcon.square
    @State private var color = WidgetLayoutColor.blue

    var body: some View {
        WidgetLayoutIconPickerButton(
            icon: $icon,
            color: $color
        )
    }
}

#Preview {
    WidgetLayoutIconPickerButtonPreview()
        .padding()
}
