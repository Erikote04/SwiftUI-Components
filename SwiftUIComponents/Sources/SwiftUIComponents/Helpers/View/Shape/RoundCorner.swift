import SwiftUI

enum Corner: CaseIterable {
    case all
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

@available(iOS 13.0, *)
struct RoundCorner: Shape {
    let corners: [Corner]
    let radius: CGFloat
    
    init(corners: [Corner] = [.all], radius: CGFloat = 8) {
        self.corners = corners
        self.radius = radius
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadii = CGSize(width: radius, height: radius)
        
        var maskedCorners: UIRectCorner = []
        
        if corners.contains(.all) || corners.isEmpty {
            maskedCorners = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        } else {
            if corners.contains(.topLeft) { maskedCorners.insert(.topLeft) }
            if corners.contains(.topRight) { maskedCorners.insert(.topRight) }
            if corners.contains(.bottomLeft) { maskedCorners.insert(.bottomLeft) }
            if corners.contains(.bottomRight) { maskedCorners.insert(.bottomRight) }
        }
        
        let bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: maskedCorners, cornerRadii: cornerRadii)
        path.addPath(Path(bezierPath.cgPath))
        
        return path
    }
}

@available(iOS 13.0, *)
extension Shape where Self == RoundCorner {
    static var roundCorners: RoundCorner { .init() }
    
    static func roundCorners(_ corner: Corner, _ radius: CGFloat = 8) -> RoundCorner {
        RoundCorner(corners: [corner], radius: radius)
    }
    
    static func roundCorners(_ corners: [Corner], _ radius: CGFloat = 8) -> RoundCorner {
        RoundCorner(corners: corners, radius: radius)
    }
}
