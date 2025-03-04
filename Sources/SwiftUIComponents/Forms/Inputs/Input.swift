import SwiftUI

@available(iOS 15.0, *)
public struct Input<L: View>: View {
    @Binding var isChecked: Bool
    let style: InputAttributes.InputStyle
    let size: InputAttributes.ImageSize
    let checkedImage: Image?
    let uncheckedImage: Image?
    let imageColor: Color
    let label: () -> L
    
    public init(
        isChecked: Binding<Bool>,
        style: InputAttributes.InputStyle = .radio,
        size: InputAttributes.ImageSize = .default,
        checkedImage: Image? = nil,
        uncheckedImage: Image? = nil,
        imageColor: Color = .primary,
        @ViewBuilder label: @escaping () -> L = { EmptyView() }
    ) {
        self._isChecked = isChecked
        self.style = style
        self.size = size
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
        self.imageColor = imageColor
        self.label = label
    }
    
    var offImage: Image {
         uncheckedImage ?? defaultOffImage
     }

     var onImage: Image {
         checkedImage ?? defaultOnImage
     }

     private var defaultOffImage: Image {
         switch style {
         case .checkbox:
             return Image(systemName: "square")
         case .radio, .radioCheck:
             return Image(systemName: "circle")
         }
     }

     private var defaultOnImage: Image {
         switch style {
         case .checkbox:
             return Image(systemName: "checkmark.square.fill")
         case .radioCheck:
             return Image(systemName: "checkmark.circle.fill")
         case .radio:
             return Image(systemName: "circle.fill")
         }
     }
    
    public var body: some View {
        HStack(spacing: .zero) {
            Button { isChecked.toggle() } label: {
                VStack {
                    image(offImage)
                        .overlay {
                            if isChecked {
                                if style == .radio {
                                    ZStack {
                                        offImage
                                        image(onImage)
                                            .scaleEffect(0.6)
                                    }
                                } else {
                                    image(onImage)
                                }
                            }
                        }
                }
                .frame(width: ButtonAttributes.FrameSize.accessible.rawValue, height: ButtonAttributes.FrameSize.accessible.rawValue)
            }
            .foregroundStyle(imageColor)
            
            label()
        }
    }
    
    @ViewBuilder
    private func image(_ image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: size.rawValue, height: size.rawValue)
    }
}
