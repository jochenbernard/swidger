import SwiftUI

struct WidgetLayoutRow: View {
    private let layout: WidgetLayout

    init(_ layout: WidgetLayout) {
        self.layout = layout
    }

    var body: some View {
        Text(layout.name)
    }
}

#Preview {
    WidgetLayoutRow(.mock)
}
