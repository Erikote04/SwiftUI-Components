import SwiftUI

@available(iOS 13.0, *)
public extension View {
    
    /// Hides the view by modifying its opacity without affecting its size or layout.
    /// - Parameter condition: Boolean indicating whether the view should be hidden.
    /// - Returns: A view with opacity 0 when the condition is true, maintaining its space in the layout.
    func hide(_ condition: Bool) -> some View {
        self.opacity(condition ? 0 : 1)
    }
    
    /// Completely hides the view and removes its space in the layout when the condition is true.
    /// - Parameter condition: Boolean indicating whether the view should be completely hidden.
    /// - Returns: An empty view when the condition is true, or the original view when false.
    func hideAndResize(_ condition: Bool) -> some View {
        condition ? EmptyView() as! Self : self
    }
}
