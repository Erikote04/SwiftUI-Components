import SwiftUI

@available(iOS 16.0, *)
public struct Text: View {
    let text: String
    let font: Font?
    let size: TextAttributes.FontSize
    let weight: TextAttributes.FontWeight
    let tint: TextAttributes.TextColor
    let color: Color
    let alignment: TextAlignment
    
    public init(
        _ text: String,
        font: Font? = nil,
        size: TextAttributes.FontSize = .body,
        weight: TextAttributes.FontWeight = .regular,
        tint: TextAttributes.TextColor = .primary,
        color: Color = .primary,
        alignment: TextAlignment = .center
    ) {
        self.text = text
        self.font = font
        self.size = size
        self.weight = weight
        self.tint = tint
        self.color = color
        self.alignment = alignment
    }
    
    var foregroundColor: Color {
        switch tint {
        case .primary: return .primary
        case .secondary: return .secondary
        case .custom: return color
        }
    }
    
    public var body: some View {
        SwiftUI.Text(text)
            .textDecorator(font: font, size: size, weight: weight, color: foregroundColor)
            .multilineTextAlignment(alignment)
    }
}

@available(iOS 16.0, *)
public struct TextDecorator: ViewModifier {
    let font: Font?
    let size: TextAttributes.FontSize
    let weight: TextAttributes.FontWeight
    let color: Color
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    public func body(content: Content) -> some View {
        content
            .font(font ?? dynamicFont(for: size.fontSize()))
            .if(font != nil) { text in
                text.fontWeight(weight.fontWeight)
            }
            .foregroundStyle(color)
    }
    
    private func dynamicFont(for size: CGFloat) -> Font {
        dynamicTypeSize.isAccessibilitySize ? Font.system(size: accessibleFontSize(for: size), weight: weight.fontWeight) : Font.system(size: size, weight: weight.fontWeight)
    }
    
    private func accessibleFontSize(for size: CGFloat) -> CGFloat {
        let scaleFactor: CGFloat
        
        switch dynamicTypeSize {
        case .xSmall, .small, .medium, .large, .xLarge, .xxLarge, .xxxLarge: scaleFactor = 1.0
        case .accessibility1: scaleFactor = 1.2
        case .accessibility2: scaleFactor = 1.4
        case .accessibility3: scaleFactor = 1.6
        case .accessibility4: scaleFactor = 1.8
        case .accessibility5: scaleFactor = 2.0
        @unknown default: scaleFactor = 1.0
        }
        
        return size * scaleFactor
    }
}

@available(iOS 16.0, *)
public extension View {
    func textDecorator(font: Font? = nil, size: TextAttributes.FontSize, weight: TextAttributes.FontWeight, color: Color) -> some View {
        self.modifier(TextDecorator(font: font, size: size, weight: weight, color: color))
    }
}
