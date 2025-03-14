import SwiftUI

@available(iOS 17.0, *)
public struct CapsuleStyle: ButtonStyle {
    let padding: EdgeInsets
    let backgroundColor: Color?
    let borderColor: Color
    let foregroundColor: Color
    let style: ButtonAttributes.Style
    let size: ButtonAttributes.Size
    let state: ButtonAttributes.State
    
    @Environment(\.isEnabled) private var isEnabled
    
    public init(
        padding: EdgeInsets = .init(top: 12, leading: 24, bottom: 12, trailing: 24),
        backgroundColor: Color? = nil,
        borderColor: Color = .primary,
        foregroundColor: Color = .primary,
        style: ButtonAttributes.Style = .primary,
        size: ButtonAttributes.Size = .fillMaxWidth,
        state: ButtonAttributes.State = .enabled
    ) {
        self.padding = padding
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.foregroundColor = foregroundColor
        self.style = style
        self.size = size
        self.state = state
    }
    
    var buttonBorderColor: Color {
        switch style {
        case .primary: return .primary
        case .secondary: return .secondary
        case .custom: return borderColor
        }
    }
    
    var buttonForegroundColor: Color {
        switch style {
        case .primary: return .primary
        case .secondary: return .secondary
        case .custom: return foregroundColor
        }
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        let buttonBackgroundColor: AnyView = backgroundColor.map { color in
            AnyView(Capsule().fill(color))
        } ?? AnyView(Capsule().fill(.background))
        
        return HStack {
            configuration.label
                .frame(maxWidth: size == .fillMaxWidth ? .infinity : nil)
        }
        .font(.system(.title2).bold())
        .padding(padding)
        .foregroundColor(buttonForegroundColor)
        .background(buttonBackgroundColor)
        .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1)
        .overlay {
            if state == .loading {
                ZStack {
                    buttonBackgroundColor
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(buttonForegroundColor)
                }
            } else {
                Capsule().stroke(buttonBorderColor, lineWidth: 2)
                    .opacity(configuration.isPressed || !isEnabled ? 0.5 : 1)
            }
        }
    }
}

@available(iOS 17.0, *)
public extension ButtonStyle where Self == CapsuleStyle {
    static var capsule: CapsuleStyle { .init() }
    
    static func capsule(
        padding: EdgeInsets = .init(top: 12, leading: 24, bottom: 12, trailing: 24),
        backgroundColor: Color? = nil,
        borderColor: Color = .primary,
        foregroundColor: Color = .primary,
        style: ButtonAttributes.Style = .primary,
        size: ButtonAttributes.Size = .fillMaxWidth,
        state: ButtonAttributes.State = .enabled
    ) -> CapsuleStyle {
        CapsuleStyle(
            padding: padding,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            foregroundColor: foregroundColor,
            style: style,
            size: size,
            state: state
        )
    }
}
