import SwiftUI

@available(iOS 13.0, *)
extension View {
    func roundCorners(_ radius: CGFloat = 8) -> some View {
        self.clipShape(.rect(cornerRadius: radius))
    }
    
    func roundCorners(_ corner: Corner, _ radius: CGFloat = 8) -> some View {
        self.clipShape(.roundCorners(corner, radius))
    }
    
    func roundCorners(_ corners: [Corner], _ radius: CGFloat = 8) -> some View {
        self.clipShape(.roundCorners(corners, radius))
    }
}
