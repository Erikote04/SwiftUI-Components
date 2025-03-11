import SwiftUI

@available(iOS 15.0, *)
public struct ToggleGroup<T: Hashable>: View {
    private let options: [T]
    private let choice: ToggleAttributes.SelectionType
    private let style: InputStyle
    private let label: (T) -> String
    
    @Binding private var selectedOptions: Set<T>
    
    public init(
        options: [T],
        selectedOptions: Binding<Set<T>>,
        choice: ToggleAttributes.SelectionType = .single,
        style: InputStyle = .radio,
        label: @escaping (T) -> String = { String(describing: $0) }
    ) {
        self.options = options
        self.choice = choice
        self.style = style
        self.label = label
        self._selectedOptions = selectedOptions
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            ForEach(options, id: \.self) { option in
                toggleOption(for: option)
            }
        }
    }
    
    @ViewBuilder
    private func toggleOption(for option: T) -> some View {
        Toggle(isOn: Binding(
            get: { selectedOptions.contains(option) },
            set: { newValue in
                switch choice {
                case .single: selectedOptions = [option]
                case .multiple:
                    if newValue { selectedOptions.insert(option) }
                    else { selectedOptions.remove(option) }
                }
            }
        )) { SwiftUI.Text(label(option)) }.toggleStyle(style)
    }
}
