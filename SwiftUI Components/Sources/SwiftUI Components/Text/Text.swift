import SwiftUI

@available(iOS 16.0, *)
struct Text: View {
    let text: String
    let font: TextAttributes.Font
    let family: Font?
    let weight: TextAttributes.FontWeight
    let tint: TextAttributes.TextColor
    let color: Color
    let alignment: TextAlignment
    
    init(
        _ text: String,
        font: TextAttributes.Font = .body,
        family: Font? = nil,
        weight: TextAttributes.FontWeight = .regular,
        tint: TextAttributes.TextColor = .primary,
        color: Color = .primary,
        alignment: TextAlignment = .center
    ) {
        self.text = text
        self.family = family
        self.font = font
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
    
    var body: some View {
        SwiftUI.Text(text)
            .textDecorator(font: font, family: family, weight: weight, color: foregroundColor)
            .multilineTextAlignment(alignment)
    }
}

@available(iOS 16.0, *)
struct TextDecorator: ViewModifier {
    let font: TextAttributes.Font
    let family: Font?
    let weight: TextAttributes.FontWeight
    let color: Color
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    func body(content: Content) -> some View {
        content
            .font(family ?? dynamicFont(for: font.fontSize()))
            .if(family != nil) { text in
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
extension View {
    func textDecorator(font: TextAttributes.Font, family: Font? = nil, weight: TextAttributes.FontWeight, color: Color) -> some View {
        self.modifier(TextDecorator(font: font, family: family, weight: weight, color: color))
    }
}
