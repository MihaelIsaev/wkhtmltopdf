import Foundation

public enum Orientation: String {
    case Portrait, Landscape
}

public enum Handler: String {
    case abort, ignore, skip
}

public enum GeneralParam: CustomStringConvertible, Equatable {
    /// -q, --quiet Be less verbose, maintained for backwards compatibility; Same as using --log-level none
    case quiet()
    /// -s, --page-size <Size> Set paper size to: A4, Letter, etc. (default A4)
    case paperSize(PaperSize)
    /// -g, --grayscale PDF will be generated in grayscale
    case grayscale()
    /// -l, --lowquality Generates lower quality pdf/ps. Useful to shrink the result document space
    case lowQuality()
    /// -O, --orientation <orientation> Set orientation to Landscape or Portrait (default Portrait)
    case orientation(Orientation)
    /// -T, --margin-top <unitreal> Set the page top margin
    case topMargin(Float)
    /// -R, --margin-right <unitreal> Set the page right margin (default 10mm)
    case rightMargin(Float)
    /// -B, --margin-bottom <unitreal> Set the page bottom margin
    case bottomMargin(Float)
    /// -L, --margin-left <unitreal> Set the page left margin (default 10mm)
    case leftMargin(Float)
    /// --page-height <unitreal> Page height
    case pageHeight(Float)
    /// --page-width <unitreal> Page width
    case pageWidth(Float)
    /// --footer-center <text> Centered footer text
    case footerCenter(String)
    /// --footer-font-name <name> Set footer font name (default Arial)
    case footerFontName(String)
    /// --footer-font-size <size> Set footer font size (default 12)
    case footerFontSize(Int)
    /// --footer-html <url> Adds a html footer
    case footerHtml(url: String)
    /// --footer-left <text> Left aligned footer text
    case footerLeft(String)
    /// --footer-line Display line above the footer
    case footerLine()
    /// --no-footer-line Do not display line above the footer (default)
    case noFooterLine()
    /// --footer-right <text> Right aligned footer text
    case footerRight(String)
    /// --footer-spacing <real> Spacing between footer and content in mm (default 0)
    case footerSpacing(Float)
    /// --header-center <text> Centered header text
    case headerCenter(String)
    /// --header-font-name <name> Set header font name (default Arial)
    case headerFontName(String)
    /// --header-font-size <size> Set header font size (default 12)
    case headerFontSize(Int)
    /// --header-html <url> Adds a html header
    case headerHtml(url: String)
    /// --header-left <text> Left aligned header text
    case headerLeft(String)
    /// --header-line Display line below the header
    case headerLine()
    /// --no-header-line Do not display line below the header (default)
    case noHeaderLine()
    /// --header-right <text> Right aligned header text
    case headerRight(String)
    /// --header-spacing <real> Spacing between header and content in mm (default 0)
    case headerSpacing(Float)
    /// --replace <name> <value> Replace [name] with value in header and footer (repeatable)
    case replace(name: String, value: String)
    /// --disable-dotted-lines Do not use dotted lines in the toc
    case disableDottedLines()
    /// --toc-header-text <text> The header text of the toc (default Table of Contents)
    case tocHeaderText(String)
    /// --toc-level-indentation <width> For each level of headings in the toc indent by this length (default 1em)
    case tocLevelIndentation(String)
    /// --disable-toc-links Do not link from toc to sections
    case disableTocLinks()
    /// --toc-text-size-shrink <real> For each level of headings in the toc the font is scaled by this factor (default 0.8)
    case tocTextSizeShrink(Float)
    /// --xsl-style-sheet <file> Use the supplied xsl style sheet for printing the table of content
    case xslStyleSheet(path: String)
    
    public var key: String {
        switch self {
        case .quiet: return "--quiet"
        case .paperSize: return "-s"
        case .grayscale: return "-g"
        case .lowQuality: return "-l"
        case .orientation: return "-O"
        case .topMargin: return "-T"
        case .rightMargin: return "-R"
        case .bottomMargin: return "-B"
        case .leftMargin: return "-L"
        case .pageHeight: return "--page-height"
        case .pageWidth: return "--page-width"
        case .footerCenter: return "--footer-center"
        case .footerFontName: return "--footer-font-name"
        case .footerFontSize: return "--footer-font-size"
        case .footerHtml: return "--footer-html"
        case .footerLeft: return "--footer-left"
        case .footerLine: return "--footer-line"
        case .noFooterLine: return "--no-footer-line"
        case .footerRight: return "--footer-right"
        case .footerSpacing: return "--footer-spacing"
        case .headerCenter: return "--header-center"
        case .headerFontName: return "--header-font-name"
        case .headerFontSize: return "--header-font-size"
        case .headerHtml: return "--header-html"
        case .headerLeft: return "--header-left"
        case .headerLine: return "--header-line"
        case .noHeaderLine: return "--no-header-line"
        case .headerRight: return "--header-right"
        case .headerSpacing: return "--header-spacing"
        case .replace: return "--replace"
        case .disableDottedLines: return "--disable-dotted-lines"
        case .tocHeaderText: return "--toc-header-text"
        case .tocLevelIndentation: return "--toc-level-indentation"
        case .disableTocLinks: return "--disable-toc-links"
        case .tocTextSizeShrink: return "--toc-text-size-shrink"
        case .xslStyleSheet: return "--xsl-style-sheet"
        }
    }
        
    public var description: String {
        return key
    }
    
    var values: [String] {
        var result: [String] = [self.description]
        switch self {
        case let .paperSize(v): result.append(v.rawValue)
        case let .orientation(v): result.append(v.rawValue)
        case let .topMargin(v): result.append(String(describing: v).appending("mm"))
        case let .rightMargin(v): result.append(String(describing: v).appending("mm"))
        case let .bottomMargin(v): result.append(String(describing: v).appending("mm"))
        case let .leftMargin(v): result.append(String(describing: v).appending("mm"))
        case let .pageHeight(v): result.append(String(describing: v).appending("mm"))
        case let .pageWidth(v): result.append(String(describing: v).appending("mm"))
        case let .footerCenter(v): result.append(v)
        case let .footerFontName(v): result.append(v)
        case let .footerFontSize(v): result.append(String(describing: v))
        case let .footerHtml(url): result.append(url)
        case let .footerLeft(v): result.append(v)
        case let .footerRight(v): result.append(v)
        case let .footerSpacing(v): result.append(String(describing: v))
        case let .headerCenter(v): result.append(v)
        case let .headerFontName(v): result.append(v)
        case let .headerFontSize(v): result.append(String(describing: v))
        case let .headerHtml(url): result.append(url)
        case let .headerLeft(v): result.append(v)
        case let .headerRight(v): result.append(v)
        case let .headerSpacing(v): result.append(String(describing: v))
        case let .replace(name, value): result.append(name); result.append(value)
        case let .tocHeaderText(v): result.append(v)
        case let .tocLevelIndentation(v): result.append(v)
        case let .tocTextSizeShrink(v): result.append(String(describing: v))
        case let .xslStyleSheet(path): result.append(path.doubleQuotted)
        default: break
        }
        return result
    }
    
    public static func ==(lhs: GeneralParam, rhs: GeneralParam) -> Bool {
        return lhs.key == rhs.key
    }
}
