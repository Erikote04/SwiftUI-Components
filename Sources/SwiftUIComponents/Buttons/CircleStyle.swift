import SwiftUI

@available(iOS 15.0, *)
public struct CircleStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color
    let style: ButtonAttributes.Style
    let state: ButtonAttributes.State
    let size: ButtonAttributes.FrameSize
    
    @Environment(\.isEnabled) private var isEnabled
    
    public init(
        backgroundColor: Color = .primary,
        foregroundColor: Color = .white,
        style: ButtonAttributes.Style = .primary,
        state: ButtonAttributes.State = .enabled,
        size: ButtonAttributes.FrameSize = .accessible
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.style = style
        self.state = state
        self.size = size
    }
    
    var buttonBackgroundColor: Color {
        switch style {
        case .primary: return .primary
        case .secondary: return .secondary
        case .custom: return backgroundColor
        }
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: size.rawValue, height: size.rawValue)
            .foregroundStyle(foregroundColor)
            .background(buttonBackgroundColor)
            .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1)
            .clipShape(.circle)
            .overlay {
                if state == .loading {
                    ZStack {
                        Circle()
                            .fill(buttonBackgroundColor)
                        
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(foregroundColor)
                    }
                }
            }
    }
}

@available(iOS 15.0, *)
public extension ButtonStyle where Self == CircleStyle {
    static var circle: CircleStyle { .init() }
    
    static func circle(
        backgroundColor: Color = .primary,
        foregroundColor: Color = .white,
        style: ButtonAttributes.Style = .primary,
        state: ButtonAttributes.State = .enabled,
        size: ButtonAttributes.FrameSize = .accessible
    ) -> CircleStyle {
        CircleStyle(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            style: style,
            state: state,
            size: size
        )
    }
}
