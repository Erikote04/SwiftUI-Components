import SwiftUI

@available(iOS 13.0, *)
public extension View {
    
    /// Applies rounded corners to all edges of the view.
    /// - Parameter radius: The corner radius. Default is 8 points.
    /// - Returns: A view with rounded corners according to the specified radius.
    func roundCorners(_ radius: CGFloat = 8) -> some View {
        self.clipShape(.rect(cornerRadius: radius))
    }
    
    /// Applies a rounded corner to the view at the specified corner.
    /// - Parameters:
    ///   - corner: The specific corner to round.
    ///   - radius: The corner radius. Default is 8 points.
    /// - Returns: A view with the specified corner rounded.
    func roundCorners(_ corner: Corner, _ radius: CGFloat = 8) -> some View {
        self.clipShape(.roundCorners(corner, radius))
    }
    
    /// Applies rounded corners to a specific set of corners of the view.
    /// - Parameters:
    ///   - corners: Array of corners to round.
    ///   - radius: The corner radius. Default is 8 points.
    /// - Returns: A view with the specified corners rounded.
    func roundCorners(_ corners: [Corner], _ radius: CGFloat = 8) -> some View {
        self.clipShape(.roundCorners(corners, radius))
    }
}
