import SwiftUI

@available(iOS 13.0, *)
public extension View {
    
    func hide(_ condition: Bool) -> some View {
        self.opacity(condition ? 0 : 1)
    }
    
    func hideAndResize(_ condition: Bool) -> some View {
        condition ? EmptyView() as! Self : self
    }
}
