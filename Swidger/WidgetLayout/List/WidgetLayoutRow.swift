import SwiftUI

struct WidgetLayoutRow: View {
    private let layout: WidgetLayout

    init(layout: WidgetLayout) {
        self.layout = layout
    }

    var body: some View {
        Text(layout.name)
    }
}

#Preview {
    WidgetLayoutRow(layout: .mock)
}
