import SwiftUI

public enum TextAttributes {
    public enum FontWeight: CaseIterable { case regular, bold }
    public enum TextColor { case primary, secondary, custom }
    
    public enum FontSize: CaseIterable {
        /// size: 44
        case h1
        /// size: 42
        case h2
        /// size: 40
        case h3
        /// size: 38
        case h4
        /// size: 36
        case h5
        /// size: 34
        case h6
        /// size: 32
        case largeTitle
        /// size: 28
        case title
        /// size: 24
        case title2
        /// size: 22
        case title3
        /// size: 20
        case headline
        /// size: 18
        case subheadline
        /// size: 16
        case body
        /// size: 14
        case caption
        /// size: 12
        case footnote
    }
}

public extension TextAttributes.FontSize {
    func fontSize() -> CGFloat {
        switch self {
        case .h1: return 44
        case .h2: return 42
        case .h3: return 40
        case .h4: return 38
        case .h5: return 36
        case .h6: return 34
        case .largeTitle: return 32
        case .title: return 28
        case .title2: return 24
        case .title3: return 22
        case .headline: return 20
        case .subheadline: return 18
        case .body: return 16
        case .caption: return 14
        case .footnote: return 12
        }
    }
}

@available(iOS 13.0, *)
public extension TextAttributes.FontWeight {
    var fontWeight: Font.Weight {
        switch self {
        case .regular: return .regular
        case .bold: return .bold
        }
    }
}
