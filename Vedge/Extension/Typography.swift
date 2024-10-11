import SwiftUI

// Typography 스타일 정의
struct Typography {
    enum Style {
        case caption, label, body, headline, title, display
        
        var fontSize: CGFloat {
            switch self {
            case .caption: return 14
            case .label: return 16
            case .body: return 18
            case .headline: return 20
            case .title: return 28
            case .display: return 32
            }
        }
        
        var lineHeight: CGFloat {
            switch self {
            case .caption: return 20
            case .label: return 24
            case .body: return 26
            case .headline: return 28
            case .title: return 36
            case .display: return 44
            }
        }
        
        func letterSpacing(accent: Bool) -> CGFloat {
            switch self {
            case .caption: return accent ? -0.5 : -0.55
            case .label: return accent ? -0.6 : -0.65
            case .body: return accent ? -0.7 : -0.75
            case .headline: return accent ? -0.8 : -0.85
            case .title: return accent ? -1.2 : -1.35
            case .display: return accent ? -1.5 : -1.65
            }
        }
    }
}

// Typography 환경 키
struct TypographyEnvironmentKey: EnvironmentKey {
    static let defaultValue: (Typography.Style, Bool, Color) -> Font = { style, accent, color in
        let fontName = accent ? "Interop-SemiBold" : "Interop-Medium"
        return Font.custom(fontName, size: style.fontSize)
    }
}

extension EnvironmentValues {
    var typography: (Typography.Style, Bool, Color) -> Font {
        get { self[TypographyEnvironmentKey.self] }
        set { self[TypographyEnvironmentKey.self] = newValue }
    }
}

// Typography Modifier
struct TypographyModifier: ViewModifier {
    let style: Typography.Style
    let accent: Bool
    let color: Color
    @Environment(\.typography) private var typography
    
    func body(content: Content) -> some View {
        content
            .font(typography(style, accent, color))
            .foregroundColor(color)
            .tracking(style.letterSpacing(accent: accent))
            .lineSpacing(style.lineHeight - style.fontSize) // 줄 간격 설정
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
    }
}

struct TextStyleModifier: ViewModifier {
    let style: Typography.Style
    let accent: Bool
    let color: Color
    @Environment(\.typography) private var typography
    
    func body(content: Content) -> some View {
        content
            .font(typography(style, accent, color))
            .foregroundColor(color)
            .tracking(style.letterSpacing(accent: accent))
            .lineSpacing(style.lineHeight - style.fontSize) // 줄 간격 설정
            .lineLimit(nil)
    }
}

// Typography Modifier를 쉽게 적용하기 위한 View 확장
extension View {
    func typography(_ style: Typography.Style, accent: Bool = false, color: Color = .primary) -> some View {
        self.modifier(TypographyModifier(style: style, accent: accent, color: color))
    }
    func textStyle(_ style: Typography.Style, accent: Bool = false, color: Color = .primary) -> some View {
        self.modifier(TextStyleModifier(style: style, accent: accent, color: color))
    }
}


struct CustomText: View {
    let text: String
    let style: Typography.Style
    let accent: Bool
    let color: Color
    
    @State private var textHeight: CGFloat = 0
    
    var body: some View {
        Text(text)
            .typography(style, accent: accent, color: color)
            .fixedSize(horizontal: false, vertical: true)
            .background(
                GeometryReader { geometry in
                    Color.clear.preference(key: TextHeightPreferenceKey.self, value: geometry.size.height)
                }
            )
            .onPreferenceChange(TextHeightPreferenceKey.self) { height in
                self.textHeight = height
            }
            .frame(height: max(textHeight, style.lineHeight))
    }
}

struct TextHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

