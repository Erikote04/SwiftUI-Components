import SwiftUI

@available(iOS 13.0, *)
public extension View {
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies the given transform if the given optional has a value.
    /// - Parameters:
    ///   - value: The optional value to unwrap and evaluate.
    ///   - transform: The transform to apply to the unwrapped value.
    /// - Returns: Either the original `View` or the modified `View` if the optional has a value.
    @ViewBuilder func ifLet<Value, Content: View>(_ value: Value?, transform: (Self, Value) -> Content) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
}
