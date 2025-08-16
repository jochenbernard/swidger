import SwiftUI

enum WidgetLayoutColor: String, CaseIterable, Codable {
    case blue
    case brown
    case gray
    case green
    case indigo
    case orange
    case pink
    case purple
    case red
    case teal

    var color: Color {
        switch self {
        case .blue:
            .blue

        case .brown:
            .brown

        case .gray:
            .gray

        case .green:
            .green

        case .indigo:
            .indigo

        case .orange:
            .orange

        case .pink:
            .pink

        case .purple:
            .purple

        case .red:
            .red

        case .teal:
            .teal
        }
    }
}
