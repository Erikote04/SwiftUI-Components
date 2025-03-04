import SwiftUI

@available(iOS 15.0, *)
struct RatingView: View {
    @Binding var rating: Int
    let onImage: Image
    let offImage: Image?
    let offColor: Color
    let onColor: Color
    
    init(
        rating: Binding<Int>,
        onImage: Image = .init(systemName: "star.fill"),
        offImage: Image? = nil,
        onColor: Color = .yellow,
        offColor: Color = .gray
    ) {
        self._rating = rating
        self.onImage = onImage
        self.offImage = offImage
        self.onColor = onColor
        self.offColor = offColor
    }
    
    var body: some View {
        HStack {
            ForEach(1..<6, id: \.self) { number in
                Button { rating = number } label: {
                    image(for: number)
                        .resizable()
                        .scaledToFit()
                        .frame(width: ButtonAttributes.FrameSize.accessible.rawValue)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
    }
    
    private func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}
