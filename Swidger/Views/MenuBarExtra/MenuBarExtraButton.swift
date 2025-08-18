import SwiftUI

struct MenuBarExtraButton<Label: View>: View {
    @Environment(\.dismiss)
    private var dismiss

    private let action: () -> Void
    private let label: () -> Label

    @State private var isHovered = false

    init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.action = action
        self.label = label
    }

    var body: some View {
        Button(
            action: {
                dismiss()
                action()
            },
            label: {
                label()
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
        )
        .buttonStyle(.borderless)
        .onHover(perform: { isHovered = $0 })
    }
}

#Preview {
    MenuBarExtraButton(
        action: {},
        label: {
            Text("Hello, world!")
        }
    )
    .padding()
}
