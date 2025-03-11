import SwiftUI

@available(iOS 13.0, *)
public extension View {

    /// Disables the view and adjusts its opacity to visually indicate the disabled state.
    /// - Parameter isDisabled: Boolean indicating whether the view should be disabled.
    /// - Returns: A disabled view with reduced opacity when disabled.
    func disable(_ isDisabled: Bool) -> some View {
        self.disabled(isDisabled).opacity(isDisabled ? 0.5 : 1)
    }
}
