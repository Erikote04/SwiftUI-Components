import SwiftUI

enum ButtonAttributes {
    enum Size { case fit, fillMaxWidth }
    enum State { case enabled, disabled, loading }
    enum Style { case primary, secondary, custom }
    
    enum CornerSize: CGFloat {
        /// size: 4
        case tiny = 4
        /// size: 8
        case small = 8
        /// size: 12
        case medium = 12
        /// size: 16
        case regular = 16
        /// size: 24
        case large = 24
    }
    
    enum FrameSize: CGFloat {
        /// size: 44
        case accessible = 44
    }
}
