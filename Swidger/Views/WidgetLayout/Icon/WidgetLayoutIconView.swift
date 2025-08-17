import SwiftUI
import SwiftUICommon

struct WidgetLayoutIconView: View {
    private let icon: WidgetLayoutIcon
    private let color: Color

    init(
        icon: WidgetLayoutIcon,
        color: Color
    ) {
        self.icon = icon
        self.color = color
    }

    var body: some View {
        Image(systemName: icon.systemImage)
            .accessibilityLabel(icon.systemImage)
            .foregroundStyle(color)
            .imageScale(.large)
            .frame(size: 40.0)
            .background {
                Circle()
                    .fill(color.quinary)
            }
    }
}

#Preview {
    WidgetLayoutIconView(
        icon: .square,
        color: .blue
    )
    .padding()
}
