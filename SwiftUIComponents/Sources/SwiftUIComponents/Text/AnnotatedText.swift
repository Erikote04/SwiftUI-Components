import SwiftUI

@available(iOS 16.0, *)
struct AnnotatedText: View {
    let text: String
    let font: TextAttributes.Font
    let family: Font?
    let weight: TextAttributes.FontWeight
    let tint: TextAttributes.TextColor
    let color: Color
    let alignment: TextAlignment
    var onClick: [String: () -> Void]
    
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    init(
        _ text: String,
        font: TextAttributes.Font = .body,
        family: Font? = nil,
        weight: TextAttributes.FontWeight = .regular,
        tint: TextAttributes.TextColor = .primary,
        color: Color = .primary,
        alignment: TextAlignment = .center,
        onClick: [String: () -> Void] = [:]
    ) {
        self.text = text
        self.font = font
        self.family = family
        self.weight = weight
        self.tint = tint
        self.color = color
        self.alignment = alignment
        self.onClick = onClick
    }
    
    var foregroundColor: Color {
        switch tint {
        case .primary: return .primary
        case .secondary: return .secondary
        case .custom: return color
        }
    }
    
    var body: some View {
        let text = replaceAnnotations(in: text)
        SwiftUI.Text(text)
            .textDecorator(font: font, family: family, weight: weight, color: foregroundColor)
            .multilineTextAlignment(alignment)
            .environment(
                \.openURL,
                OpenURLAction { url in
                    let action = url.absoluteString
                    onClick[action]?()
                    return .handled
                }
            )
    }
    
    private func replaceAnnotations(in inputString: String) -> AttributedString {
        let stringReplacements: [(pattern: String, replacement: String)] = [
            ("<annotation id=\"(.*?)\">(.*?)</annotation>", "[$2]($1)"),
            ("<bold>(.*?)</bold>", "**$1**"),
            ("<italic>(.*?)</italic>", "*$1*"),
            ("<em>(.*?)</em>", "*$1*"),
            ("<p>(.*?)</p>", "\n$1"),
            ("<sup>&(.*?)</sup>", "&$1"),
            ("<sub>&(.*?)</bup>", "&$1"),
        ]
        
        var modifiedString = inputString
        
        for (pattern, replacement) in stringReplacements {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                continue
            }
            modifiedString = regex.stringByReplacingMatches(
                in: modifiedString, options: [], range: NSRange(modifiedString.startIndex..., in: modifiedString), withTemplate: replacement)
        }
        
        var attributedResult =
        (try? AttributedString(
            markdown: modifiedString, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
        ?? AttributedString(modifiedString)
        
        let scaleFactor = getScaleFactor()
        let baseFontSize = font.fontSize()
        let dynamicFontSize = baseFontSize * scaleFactor
        
        attributedResult.font = Font.system(size: dynamicFontSize, weight: weight.fontWeight)
        
        let attributedTransformations: [(pattern: String, transform: (Range<AttributedString.Index>, AttributedString) -> AttributedString)] = [
            (
                "<strong>(.*?)</strong>",
                { range, _ in
                    var attributedString = AttributedString(attributedResult[range])
                    attributedString = attributedString.removingTags(["<strong>", "</strong>"])
                    attributedString.font = Font.system(size: font.fontSize(), weight: .bold)
                    return attributedString
                }
            ),
            (
                "<sup>(.*?)</sup>",
                { range, _ in
                    var attributedString = AttributedString(attributedResult[range])
                    attributedString = attributedString.removingTags(["<sup>", "</sup>"])
                    attributedString.baselineOffset = 5 * scaleFactor
                    attributedString.font = Font.system(size: dynamicFontSize, weight: weight.fontWeight)
                    return attributedString
                }
            ),
            (
                "<sub>(.*?)</sub>",
                { range, _ in
                    var attributedString = AttributedString(attributedResult[range])
                    attributedString = attributedString.removingTags(["<sub>", "</sub>"])
                    attributedString.baselineOffset = -4 * scaleFactor
                    attributedString.font = Font.system(size: dynamicFontSize, weight: weight.fontWeight)
                    return attributedString
                }
            ),
        ]
        
        for (pattern, transform) in attributedTransformations {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                continue
            }
            
            let fullRange = NSRange(attributedResult.startIndex..<attributedResult.endIndex, in: attributedResult)
            let matches = regex.matches(in: String(attributedResult.characters), options: [], range: fullRange)
            
            for match in matches.reversed() {
                let matchRange = match.range(at: 0)
                if let swiftRange = Range(matchRange, in: attributedResult) {
                    let transformedAttributedString = transform(swiftRange, attributedResult)
                    attributedResult.replaceSubrange(swiftRange, with: transformedAttributedString)
                }
            }
        }
        
        return attributedResult
    }
    
    private func getScaleFactor() -> CGFloat {
        switch dynamicTypeSize {
        case .xSmall, .small, .medium, .large, .xLarge, .xxLarge, .xxxLarge: return 1.0
        case .accessibility1: return 1.2
        case .accessibility2: return 1.4
        case .accessibility3: return 1.6
        case .accessibility4: return 1.8
        case .accessibility5: return 2.0
        @unknown default: return 1.0
        }
    }
}

@available(iOS 15, *)
extension AttributedString {
    func removingTags(_ tags: [String]) -> AttributedString {
        var mutableAttributedString = self
        
        for tag in tags {
            if let range = mutableAttributedString.range(of: tag) {
                mutableAttributedString.removeSubrange(range)
            }
        }
        
        return mutableAttributedString
    }
}
