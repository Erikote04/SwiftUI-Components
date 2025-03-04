import SwiftUI

@available(iOS 17.0, *)
struct RoundedRectangleStyle: ButtonStyle {
    let cornerRadius: ButtonAttributes.CornerSize
    let backgroundColor: Color
    let foregroundColor: Color
    let style: ButtonAttributes.Style
    let size: ButtonAttributes.Size
    let state: ButtonAttributes.State
    
    @Environment(\.isEnabled) private var isEnabled
    
    init(
        cornerRadius: ButtonAttributes.CornerSize = .small,
        backgroundColor: Color = .primary,
        foregroundColor: Color = .white,
        style: ButtonAttributes.Style = .primary,
        size: ButtonAttributes.Size = .fillMaxWidth,
        state: ButtonAttributes.State = .enabled
    ) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.style = style
        self.size = size
        self.state = state
    }
    
    var buttonBackgroundColor: Color {
        switch style {
        case .primary: return .primary
        case .secondary: return .secondary
        case .custom: return backgroundColor
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .frame(maxWidth: size == .fillMaxWidth ? .infinity : nil)
        }
        .font(.system(.title2).bold())
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
        .foregroundColor(foregroundColor)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius.rawValue)
                .fill(buttonBackgroundColor)
        )
        .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1)
        .overlay {
            if state == .loading {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius.rawValue)
                        .fill(buttonBackgroundColor)
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(foregroundColor)
                }
            }
        }
    }
}

@available(iOS 17.0, *)
extension ButtonStyle where Self == RoundedRectangleStyle {
    static var roundRect: RoundedRectangleStyle { .init() }
    
    static func roundRect(
        cornerRadius: ButtonAttributes.CornerSize = .small,
        backgroundColor: Color = .primary,
        foregroundColor: Color = .white,
        style: ButtonAttributes.Style = .primary,
        size: ButtonAttributes.Size = .fillMaxWidth,
        state: ButtonAttributes.State = .enabled
    ) -> RoundedRectangleStyle {
        RoundedRectangleStyle(
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            style: style,
            size: size,
            state: state
        )
    }
}
