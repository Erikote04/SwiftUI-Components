import SwiftUI

@available(iOS 13.0, *)
extension View {

    func disable(_ isDisabled: Bool) -> some View {
        self.disabled(isDisabled).opacity(isDisabled ? 0.5 : 1)
    }
}
