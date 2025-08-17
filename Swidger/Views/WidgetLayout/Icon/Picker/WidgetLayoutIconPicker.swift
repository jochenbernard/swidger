import SwiftUI
import SwiftUICommon

struct WidgetLayoutIconPicker: View {
    @Binding private var icon: WidgetLayoutIcon
    @Binding private var color: WidgetLayoutColor

    private let spacing = 8.0

    init(
        icon: Binding<WidgetLayoutIcon>,
        color: Binding<WidgetLayoutColor>
    ) {
        self._icon = icon
        self._color = color
    }

    var body: some View {
        ScrollView {
            LazyVGrid(
                columnCount: 5,
                spacing: spacing,
            ) {
                colorPicker

                iconPicker
            }
            .buttonStyle(.borderless)
            .padding(spacing)
            .fixedSize()
        }
    }

    private var colorPicker: some View {
        ForEach(
            WidgetLayoutColor.allCases,
            id: \.rawValue
        ) { color in
            Button(
                action: { select(color) },
                label: {
                    Circle()
                        .fill(color.color)
                        .frame(size: 40.0)
                        .overlay {
                            if color == self.color {
                                Circle()
                                    .fill(.white)
                                    .frame(size: 10.0)
                            }
                        }
                }
            )
        }
    }

    private var iconPicker: some View {
        ForEach(
            WidgetLayoutIcon.allCases,
            id: \.rawValue
        ) { icon in
            Button(
                action: { select(icon) },
                label: {
                    WidgetLayoutIconView(
                        icon: icon,
                        color: (
                            icon == self.icon
                            ? .accentColor
                            : .primary
                        )
                    )
                }
            )
        }
    }

    private func select(_ color: WidgetLayoutColor) {
        self.color = color
    }

    private func select(_ icon: WidgetLayoutIcon) {
        self.icon = icon
    }
}

private struct WidgetLayoutIconPickerPreview: View {
    @State private var icon = WidgetLayoutIcon.square
    @State private var color = WidgetLayoutColor.blue

    var body: some View {
        WidgetLayoutIconPicker(
            icon: $icon,
            color: $color
        )
    }
}

#Preview {
    WidgetLayoutIconPickerPreview()
}
