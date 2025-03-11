import SwiftUI

public enum ButtonAttributes {
    public enum Size { case fit, fillMaxWidth }
    public enum State { case enabled, disabled, loading }
    public enum Style { case primary, secondary, custom }
    
    public enum CornerSize: CGFloat {
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
    
    public enum FrameSize: CGFloat {
        /// size: 44
        case accessible = 44
    }
}
