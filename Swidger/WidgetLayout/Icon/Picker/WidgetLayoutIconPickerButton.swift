import SwiftUI

struct WidgetLayoutIconPickerButton: View {
    @Binding private var selection: WidgetLayoutIcon

    @State private var isPopoverPresented = false

    init(selection: Binding<WidgetLayoutIcon>) {
        self._selection = selection
    }

    var body: some View {
        Button(action: presentPopover) {
            WidgetLayoutIconView(selection)
        }
        .buttonStyle(.borderless)
        .popover(isPresented: $isPopoverPresented) {
            WidgetLayoutIconPicker(selection: $selection)
        }
    }

    private func presentPopover() {
        isPopoverPresented = true
    }
}

private struct WidgetLayoutIconPickerButtonPreview: View {
    @State private var selection = WidgetLayoutIcon.square

    var body: some View {
        WidgetLayoutIconPickerButton(selection: $selection)
    }
}

#Preview {
    WidgetLayoutIconPickerButtonPreview()
}
