import SwiftUI

@available(iOS 15.0, *)
public struct InputStyle: ToggleStyle {
    let style: ToggleAttributes.ToggleStyle
    let checkedImage: Image?
    let uncheckedImage: Image?
    let onColor: Color
    let offColor: Color
    
    public init(
        style: ToggleAttributes.ToggleStyle = .radio,
        checkedImage: Image? = nil,
        uncheckedImage: Image? = nil,
        onColor: Color = .primary,
        offColor: Color = .secondary
    ) {
        self.style = style
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
        self.onColor = onColor
        self.offColor = offColor
    }
    
    var onImage: Image { checkedImage ?? defaultOnImage }
    var offImage: Image { uncheckedImage ?? defaultOffImage }
    
    private var defaultOnImage: Image {
        switch style {
        case .checkbox: return Image(systemName: "checkmark.square.fill")
        case .radioCheck: return Image(systemName: "checkmark.circle.fill")
        case .radio: return Image(systemName: "inset.filled.circle")
        }
    }
    
    private var defaultOffImage: Image {
        switch style {
        case .checkbox: return Image(systemName: "square")
        case .radio, .radioCheck: return Image(systemName: "circle")
        }
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .zero) {
            Button { configuration.isOn.toggle() } label: {
                if configuration.isOn { image(for: onImage) }
                else { image(for: offImage) }
            }
            .foregroundStyle(configuration.isOn ? onColor : offColor)
            .frame(width: 44, height: 44)
            
            configuration.label
        }
    }
    
    @ViewBuilder
    private func image(for image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
    }
}

@available(iOS 15.0, *)
public extension ToggleStyle where Self == InputStyle {
    static var radio: InputStyle { .init() }
    static var radioCheck: InputStyle { .init(style: .radioCheck) }
    static var check: InputStyle { .init(style: .checkbox) }
    
    static func custom(
        style: ToggleAttributes.ToggleStyle = .radio,
        checkedImage: Image? = nil,
        uncheckedImage: Image? = nil,
        onColor: Color = .primary,
        offColor: Color = .secondary
    ) -> InputStyle {
        InputStyle(
            style: style,
            checkedImage: checkedImage,
            uncheckedImage: uncheckedImage,
            onColor: onColor,
            offColor: offColor
        )
    }
}
