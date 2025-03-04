import SwiftUI

@available(iOS 13.0, *)
extension View {
    
    @ViewBuilder
    func horizontalAlignment(_ alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func verticalAlignment(_ alignment: Alignment = .center) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
}
