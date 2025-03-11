import SwiftUI

@available(iOS 13.0, *)
public extension View {
    
    /// Sets the horizontal alignment of the view by expanding its width to the maximum available.
    /// - Parameter alignment: The horizontal alignment to apply. Default is `.center`.
    /// - Returns: A modified view with maximum width and the specified alignment.
    @ViewBuilder func horizontalAlignment(_ alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    /// Sets the vertical alignment of the view by expanding its height to the maximum available.
    /// - Parameter alignment: The vertical alignment to apply. Default is `.center`.
    /// - Returns: A modified view with maximum height and the specified alignment.
    @ViewBuilder func verticalAlignment(_ alignment: Alignment = .center) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
}
