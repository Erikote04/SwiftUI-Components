import SwiftUI

@available(iOS 15.0, *)
struct InputGroup: View {
    let options: [String]
    @Binding var selectedIndices: Set<Int>
    let isMultipleChoice: Bool
    let checkedImage: Image?
    let uncheckedImage: Image?
    let imageColor: Color
    let radioStyle: InputAttributes.InputStyle
    let radioSize: InputAttributes.ImageSize
    
    init(
        options: [String],
        selectedIndices: Binding<Set<Int>>,
        isMultipleChoice: Bool = false,
        checkedImage: Image? = nil,
        uncheckedImage: Image? = nil,
        imageColor: Color = .primary,
        radioStyle: InputAttributes.InputStyle = .radio,
        radioSize: InputAttributes.ImageSize = .default
    ) {
        self.options = options
        self._selectedIndices = selectedIndices
        self.isMultipleChoice = isMultipleChoice
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
        self.imageColor = imageColor
        self.radioStyle = radioStyle
        self.radioSize = radioSize
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(options.indices, id: \.self) { index in
                let isSelected = Binding<Bool>(
                    get: { selectedIndices.contains(index) },
                    set: { newValue in
                        if isMultipleChoice {
                            if newValue {
                                selectedIndices.insert(index)
                            } else {
                                selectedIndices.remove(index)
                            }
                        } else {
                            selectedIndices = [index]
                        }
                    }
                )
                
                Input(
                    isChecked: isSelected,
                    style: radioStyle,
                    size: radioSize,
                    checkedImage: checkedImage,
                    uncheckedImage: uncheckedImage,
                    imageColor: imageColor
                ) { SwiftUI.Text(options[index]) }
            }
        }
    }
}
