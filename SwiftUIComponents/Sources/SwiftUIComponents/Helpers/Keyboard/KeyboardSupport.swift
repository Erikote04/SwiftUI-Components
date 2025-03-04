import Combine
import SwiftUI

extension Notification {
    fileprivate var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

@available(iOS 13.0, *)
extension Publishers {
    fileprivate static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }

    fileprivate static var isKeyboardVisible: AnyPublisher<Bool, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { _ in true }

        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in false }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

@available(iOS 15.0, *)
struct KeyboardAvoiding: ViewModifier {
    @State private var keyboardActiveAdjustment: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.top, keyboardActiveAdjustment)
            .safeAreaInset(edge: .bottom, spacing: keyboardActiveAdjustment) {
                EmptyView().frame(height: 0)
            }
            .onReceive(Publishers.keyboardHeight) {
                self.keyboardActiveAdjustment = min($0, 12)
            }
    }
}

@available(iOS 13.0, *)
struct HideWhenKeyboardAppears: ViewModifier {
    @State private var isKeyboardVisible: Bool = false

    func body(content: Content) -> some View {
        Group {
            if !isKeyboardVisible {
                content
            }
        }
        .onReceive(Publishers.isKeyboardVisible) { isVisible in
            isKeyboardVisible = isVisible
        }
    }
}

@available(iOS 15.0, *)
extension View {
    func keyboardAvoiding() -> some View {
        modifier(KeyboardAvoiding())
    }

    func hideWhenKeyboardAppears() -> some View {
        modifier(HideWhenKeyboardAppears())
    }
}
