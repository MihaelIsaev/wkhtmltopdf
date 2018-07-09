import Foundation

public enum PageParam: CustomStringConvertible, Equatable {
    /// --allow <path> Allow the file or files from the specified folder to be loaded (repeatable)
    case allow(path: String)
    /// --background Do print background (default)
    case background
    /// --no-background Do not print background
    case noBackground
    /// --bypass-proxy-for <value> Bypass proxy for host (repeatable)
    case bypassProxyFor(String)
    /// --cache-dir <path> Web cache directory
    case cacheDir(path: String)
    /// --checkbox-checked-svg <path> Use this SVG file when rendering checked checkboxes
    case checkboxChecked(path: String)
    /// --checkbox-svg <path> Use this SVG file when rendering unchecked checkboxes
    case checkboxUnchecked(path: String)
    /// --cookie <name> <value> Set an additional cookie (repeatable), value should be url encoded.
    case cookie(name: String, value: String)
    /// --custom-header <name> <value> Set an additional HTTP header (repeatable)
    case customHeader(name: String, value: String)
    /// --custom-header-propagation Add HTTP headers specified by
    case customHeaderPropagation
    /// --no-custom-header-propagation  Do not add HTTP headers specified by
    case noCustomHeaderPropagation
    /// --default-header Add a default header, with the name of the page to the left, and the page number to the right
    case defaultHeader()
    /// --encoding <encoding> Set the default text encoding, for input
    case encoding(String)
    /// --disable-external-links Do not make links to remote web pages
    case disableExternalLinks
    /// --enable-external-links Make links to remote web pages (default)
    case enableExternalLinks
    /// --enable-forms Turn HTML form fields into pdf form fields
    case enableForms
    /// --disable-forms Do not turn HTML form fields into pdf form fields (default)
    case disableForms
    /// --images Do load or print images (default)
    case images
    /// --no-images Do not load or print images
    case noImages
    /// --disable-internal-links Do not make local links
    case disableInternalLinks
    /// --enable-internal-links Make local links (default)
    case enableInternalLinks
    /// -n, --disable-javascript Do not allow web pages to run javascript
    case disableJavaScript
    /// --enable-javascript Do allow web pages to run javascript (default)
    case enableJavaScript
    /// --javascript-delay <msec> Wait some milliseconds for javascript finish (default 200)
    case javascriptDelay(msec: Int)
    /// --keep-relative-links Keep relative external links as relative external links
    case keepRelativeLinks
    /// --load-error-handling <handler> Specify how to handle pages that fail to load: abort, ignore or skip (default abort)
    case loadErrorHandling(Handler)
    /// --load-media-error-handling <handler> Specify how to handle media files that fail to load: abort, ignore or skip (default ignore)
    case loadMediaErrorHandling(Handler)
    /// --disable-local-file-access Do not allowed conversion of a local file to read in other local files, unless explicitly allowed with --allow
    case enableLocalFileAccess
    /// --enable-local-file-access Allowed conversion of a local file to read in other local files. (default)
    case disableLocalFileAccess
    /// --minimum-font-size <int> Minimum font size
    case minimumFontSize(Int)
    /// --exclude-from-outline Do not include the page in the table of contents and outlines
    case excludeFromOutline
    /// --include-in-outline Include the page in the table of contents and outlines (default)
    case includeInOutline
    /// --page-offset <offset> Set the starting page number (default 0)
    case pageOffset(Int)
    /// --password <password> HTTP Authentication password
    case password(String)
    /// --disable-plugins Disable installed plugins (default)
    case disablePlugins
    /// --enable-plugins Enable installed plugins (plugins will likely not work)
    case enablePlugins
    /// --post <name> <value> Add an additional post field (repeatable)
    case postField(name: String, value: String)
    /// --post-file <name> <path> Post an additional file (repeatable)
    case postFile(name: String, path: String)
    /// --print-media-type Use print media-type instead of screen
    case printMediaType()
    /// --no-print-media-type Do not use print media-type instead of screen (default)
    case noPrintMediaType
    /// -p, --proxy <proxy> Use a proxy
    case proxy(String)
    /// --proxy-hostname-lookup Use the proxy for resolving hostnames
    case proxyHostnameLookup
    /// --radiobutton-checked-svg <path> Use this SVG file when rendering checked radiobuttons
    case radioButtonChecked(path: String)
    /// --radiobutton-svg <path> Use this SVG file when rendering unchecked radiobuttons
    case radioButtonUnchecked(path: String)
    /// --resolve-relative-links Resolve relative external links into absolute links (default)
    case resolveRelativeLinks
    /// --run-script <js> Run this additional javascript after the page is done loading (repeatable)
    case runScript(js: String)
    /// --disable-smart-shrinking Disable the intelligent shrinking strategy used by WebKit that makes the pixel/dpi ratio none constant
    case disableSmartShrinking
    /// --enable-smart-shrinking Enable the intelligent shrinking strategy used by WebKit that makes the pixel/dpi ratio none constant (default)
    case enableSmartShrinking
    /// --ssl-crt-path <path> Path to the ssl client cert public key in OpenSSL PEM format, optionally followed by intermediate ca and trusted certs
    case sslCrtPath(path: String)
    /// --ssl-key-password <password> Password to ssl client cert private key
    case sslKeyPassword(String)
    /// --ssl-key-path <path> Path to ssl client cert private key in OpenSSL PEM format
    case sslKeyPath(path: String)
    /// --stop-slow-scripts Stop slow running javascripts (default)
    case stopSlowScripts
    /// --no-stop-slow-scripts Do not Stop slow running javascripts
    case noStopSlowScripts
    /// --disable-toc-back-links Do not link from section header to toc (default)
    case disableTocBackLinks
    /// --enable-toc-back-links Link from section header to toc
    case enableTocBackLinks
    /// --user-style-sheet <url> Specify a user style sheet, to load with every page
    case userStyleSheet(url: String)
    /// --username <username> HTTP Authentication username
    case username(String)
    /// --viewport-size <> Set viewport size if you have custom scrollbars or css attribute overflow to emulate window size
    case viewportSize(String)
    /// --window-status <windowStatus> Wait until window.status is equal to this string before rendering page
    case windowStatus(String)
    /// --zoom <float> Use this zoom factor (default 1)
    case zoom(Float)
    
    public var key: String {
        switch self {
        case .allow: return "--allow"
        case .background: return "--background"
        case .noBackground: return "--no-background"
        case .bypassProxyFor: return "--bypass-proxy-for"
        case .cacheDir: return "--cache-dir"
        case .checkboxChecked: return "--checkbox-checked-svg"
        case .checkboxUnchecked: return "--checkbox-svg"
        case .cookie: return "--cookie"
        case .customHeader: return "--custom-header"
        case .customHeaderPropagation: return "--custom-header-propagation"
        case .noCustomHeaderPropagation: return "--no-custom-header-propagation"
        case .defaultHeader: return "--default-header"
        case .encoding: return "--encoding"
        case .disableExternalLinks: return "--disable-external-links"
        case .enableExternalLinks: return "--enable-external-links"
        case .enableForms: return "--enable-forms"
        case .disableForms: return "--disable-forms"
        case .images: return "--images"
        case .noImages: return "--no-images"
        case .disableInternalLinks: return "--disable-internal-links"
        case .enableInternalLinks: return "--enable-internal-links"
        case .disableJavaScript: return "--disable-javascript"
        case .enableJavaScript: return "--enable-javascript"
        case .javascriptDelay: return "--javascript-delay"
        case .keepRelativeLinks: return "--keep-relative-links"
        case .loadErrorHandling: return "--load-error-handling"
        case .loadMediaErrorHandling: return "--load-media-error-handling"
        case .enableLocalFileAccess: return "--disable-local-file-access"
        case .disableLocalFileAccess: return "--enable-local-file-access"
        case .minimumFontSize: return "--minimum-font-size"
        case .excludeFromOutline: return "--exclude-from-outline"
        case .includeInOutline: return "--include-in-outline"
        case .pageOffset: return "--page-offset"
        case .password: return "--password"
        case .disablePlugins: return "--disable-plugins"
        case .enablePlugins: return "--enable-plugins"
        case .postField: return "--post"
        case .postFile: return "--post-file"
        case .printMediaType: return "--print-media-type"
        case .noPrintMediaType: return "--no-print-media-type"
        case .proxy: return "--proxy"
        case .proxyHostnameLookup: return "--proxy-hostname-lookup"
        case .radioButtonChecked: return "--radiobutton-checked-svg"
        case .radioButtonUnchecked: return "--radiobutton-svg"
        case .resolveRelativeLinks: return "--resolve-relative-links"
        case .runScript: return "--run-script"
        case .disableSmartShrinking: return "--disable-smart-shrinking"
        case .enableSmartShrinking: return "--enable-smart-shrinking"
        case .sslCrtPath: return "--ssl-crt-path"
        case .sslKeyPassword: return "--ssl-key-password"
        case .sslKeyPath: return "--ssl-key-path"
        case .stopSlowScripts: return "--stop-slow-scripts"
        case .noStopSlowScripts: return "--no-stop-slow-scripts"
        case .disableTocBackLinks: return "--disable-toc-back-links"
        case .enableTocBackLinks: return "--enable-toc-back-links"
        case .userStyleSheet: return "--user-style-sheet"
        case .username: return "--username"
        case .viewportSize: return "--viewport-size"
        case .windowStatus: return "--window-status"
        case .zoom: return "--zoom"
        }
    }
    
    public var description: String {
        return key
    }
    
    var values: [String] {
        var result: [String] = [self.description]
        switch self {
        case let .allow(path): result.append(path.doubleQuotted)
        case let .bypassProxyFor(v): result.append(v)
        case let .cacheDir(path): result.append(path.doubleQuotted)
        case let .checkboxChecked(path): result.append(path.doubleQuotted)
        case let .checkboxUnchecked(path): result.append(path.doubleQuotted)
        case let .cookie(name, value): result.append(name); result.append(value)
        case let .customHeader(name, value): result.append(name); result.append(value)
        case let .encoding(v): result.append(v)
        case let .javascriptDelay(msec): result.append(String(describing: msec))
        case let .loadErrorHandling(v): result.append(String(describing: v))
        case let .loadMediaErrorHandling(v): result.append(String(describing: v))
        case let .minimumFontSize(v): result.append(String(describing: v))
        case let .pageOffset(v): result.append(String(describing: v))
        case let .password(v): result.append(v)
        case let .postField(name, value): result.append(name); result.append(value)
        case let .postFile(name, path): result.append(name); result.append(path.doubleQuotted)
        case let .proxy(v): result.append(v)
        case let .radioButtonChecked(path): result.append(path.doubleQuotted)
        case let .radioButtonUnchecked(path): result.append(path.doubleQuotted)
        case let .runScript(js): result.append(js)
        case let .sslCrtPath(path): result.append(path.doubleQuotted)
        case let .sslKeyPassword(v): result.append(v)
        case let .sslKeyPath(path): result.append(path.doubleQuotted)
        case let .userStyleSheet(url): result.append(url)
        case let .username(v): result.append(v)
        case let .viewportSize(v): result.append(v)
        case let .windowStatus(v): result.append(v)
        case let .zoom(v): result.append(String(describing: v))
        default: break
        }
        return result
    }
    
    public static func ==(lhs: PageParam, rhs: PageParam) -> Bool {
        return lhs.key == rhs.key
    }
}
