import SwiftUI

@available(iOS 17.0, *)
public struct RoundedRectangleStyle: ButtonStyle {
    let padding: EdgeInsets
    let cornerRadius: ButtonAttributes.CornerSize
    let backgroundColor: Color
    let foregroundColor: Color?
    let style: ButtonAttributes.Style
    let size: ButtonAttributes.Size
    let state: ButtonAttributes.State
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.isEnabled) private var isEnabled
    
    public init(
        padding: EdgeInsets = .init(top: 12, leading: 24, bottom: 12, trailing: 24),
        cornerRadius: ButtonAttributes.CornerSize = .small,
        backgroundColor: Color = .primary,
        foregroundColor: Color? = nil,
        style: ButtonAttributes.Style = .primary,
        size: ButtonAttributes.Size = .fillMaxWidth,
        state: ButtonAttributes.State = .enabled
    ) {
        self.padding = padding
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
    
    var buttonForegroundColor: Color {
        foregroundColor ?? (colorScheme == .dark && style == .primary ? .black : .white)
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .frame(maxWidth: size == .fillMaxWidth ? .infinity : nil)
        }
        .font(.system(.title2).bold())
        .padding(padding)
        .foregroundColor(buttonForegroundColor)
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
                        .tint(buttonForegroundColor)
                }
            }
        }
    }
}

@available(iOS 17.0, *)
public extension ButtonStyle where Self == RoundedRectangleStyle {
    static var roundRect: RoundedRectangleStyle { .init() }
    
    static func roundRect(
        padding: EdgeInsets = .init(top: 12, leading: 24, bottom: 12, trailing: 24),
        cornerRadius: ButtonAttributes.CornerSize = .small,
        backgroundColor: Color = .primary,
        foregroundColor: Color? = nil,
        style: ButtonAttributes.Style = .primary,
        size: ButtonAttributes.Size = .fillMaxWidth,
        state: ButtonAttributes.State = .enabled
    ) -> RoundedRectangleStyle {
        RoundedRectangleStyle(
            padding: padding,
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            style: style,
            size: size,
            state: state
        )
    }
}
