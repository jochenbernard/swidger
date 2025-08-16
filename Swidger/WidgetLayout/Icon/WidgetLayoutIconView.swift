import SwiftUI
import SwiftUICommon

struct WidgetLayoutIconView: View {
    private let icon: WidgetLayoutIcon

    init(_ icon: WidgetLayoutIcon) {
        self.icon = icon
    }

    var body: some View {
        Image(systemName: icon.systemImage)
            .accessibilityLabel(icon.systemImage)
            .foregroundStyle(.tint)
            .imageScale(.large)
            .frame(size: 40.0)
            .background {
                Circle()
                    .fill(.tint.quinary)
            }
    }
}

#Preview {
    WidgetLayoutIconView(.square)
}
