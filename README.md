[![Mihael Isaev](https://user-images.githubusercontent.com/1272610/41496020-48236678-7146-11e8-8c8e-bf36bc74a5ba.png)](http://mihaelisaev.com)

<p align="center">
<a href="LICENSE">
<img src="https://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
</a>
<a href="https://swift.org">
<img src="https://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
</a>
<a href="https://twitter.com/VaporRussia">
<img src="https://img.shields.io/badge/twitter-VaporRussia-5AA9E7.svg" alt="Twitter">
</a>
</p>

<br>

Swift lib for building pdf file data from leaf templates and/or web pages through wkhtmltopdf cli
Built for Vapor 3 and uses Vapor itself (with Swift-NIO under the hood) and Leaf for templates.

# Installation ⚙️

First of all install `wkhtmltopdf` itself

## Ubuntu
```bash
sudo apt-get update
sudo apt-get install xvfb libfontconfig wkhtmltopdf
```

## macOS
```bash
brew cask install wkhtmltopdf
```

## Swift Package Manager

Edit your Package.swift

```swift
//add this repo to dependencies
.package(url: "https://github.com/MihaelIsaev/wkhtmltopdf.git", from: "1.0.0")
//and don't forget about targets
//"WKHTMLTOPDF"
```

# Example 🔥

The very common usage is to generate some report on request on-the-fly and return pdf file in response

```swift
import WKHTMLTOPDF

router.get("pdf") { req throws -> EventLoopFuture<Response> in
    let wk = WK(.topMargin(20),
                .leftMargin(20),
                .rightMargin(20),
                .bottomMargin(20),
                .paperSize(.A4))
    struct ReportIntro: Codable {
        var reportName = "Monthly usage"
    }
    struct ReportData: Codable {
        var records:[ReportRecord] = []
    }
    let page1 = Page(view: "report-intro", payload: ReportIntro(), params: PageParam.zoom(1.3))
    let page2 = Page(view: "report-body", payload: ReportData(), params: PageParam.zoom(1.3))
    let page3 = Page<Test>(url: "http://google.com", params: PageParam.zoom(1.3))
    return try wk.generate(container: req, pages: page1, page2, page3).map { pdfData in //Data
        let response = req.makeResponse(pdfData, as: .pdf)
        response.http.headers.add(name: HTTPHeaderName.contentDisposition, value: "attachment; filename=\"report.pdf\"")
        return response
    }
}
```

Looks good, right? 😃

# ToDo 👨🏻‍💻

- [ ] generate headers/footers from Leaf templates too (available in `dev` branch 🔥)

# Cheatsheet 📌

## Global Options

It is `GeneralParam` enum type.

Uses in `WK` object initialization.

```swift
WK(GeneralParam...)
```

GeneralParam | Description
------------ | -------------
.quiet() | -q, --quiet Be less verbose, maintained for backwards compatibility; Same as using --log-level none
.paperSize(PaperSize) | -s, --page-size <Size> Set paper size to: A4, Letter, etc. (default A4)
.grayscale() | -g, --grayscale PDF will be generated in grayscale
.lowQuality() | -l, --lowquality Generates lower quality pdf/ps. Useful to shrink the result document space
.orientation(Orientation) | -O, --orientation <orientation> Set orientation to Landscape or Portrait (default Portrait)
.topMargin(Float) | -T, --margin-top <unitreal> Set the page top margin
.rightMargin(Float) | -R, --margin-right <unitreal> Set the page right margin (default 10mm)
.bottomMargin(Float) | -B, --margin-bottom <unitreal> Set the page bottom margin
.leftMargin(Float) | -L, --margin-left <unitreal> Set the page left margin (default 10mm)
.pageHeight(Float) | --page-height <unitreal> Page height
.pageWidth(Float) | --page-width <unitreal> Page width
.footerCenter(String) | --footer-center <text> Centered footer text
.footerFontName(String) | --footer-font-name <name> Set footer font name (default Arial)
.footerFontSize(Int) | --footer-font-size <size> Set footer font size (default 12)
.footerHtml(url: String) | --footer-html <url> Adds a html footer
.footerLeft(String) | --footer-left <text> Left aligned footer text
.footerLine() | --footer-line Display line above the footer
.noFooterLine() | --no-footer-line Do not display line above the footer (default)
.footerRight(String) | --footer-right <text> Right aligned footer text
.footerSpacing(Float) | --footer-spacing <real> Spacing between footer and content in mm (default 0)
.headerCenter(String) | --header-center <text> Centered header text
.headerFontName(String) | --header-font-name <name> Set header font name (default Arial)
.headerFontSize(Int) | --header-font-size <size> Set header font size (default 12)
.headerHtml(url: String) | --header-html <url> Adds a html header
.headerLeft(String) | --header-left <text> Left aligned header text
.headerLine() | --header-line Display line below the header
.noHeaderLine() | --no-header-line Do not display line below the header (default)
.headerRight(String) | --header-right <text> Right aligned header text
.headerSpacing(Float) | --header-spacing <real> Spacing between header and content in mm (default 0)
.replace(name: String, value: String) | --replace <name> <value> Replace [name] with value in header and footer (repeatable)
.disableDottedLines() | --disable-dotted-lines Do not use dotted lines in the toc
.tocHeaderText(String) | --toc-header-text <text> The header text of the toc (default Table of Contents)
.tocLevelIndentation(String) | --toc-level-indentation <width> For each level of headings in the toc indent by this length (default 1em)
.disableTocLinks() | --disable-toc-links Do not link from toc to sections
.tocTextSizeShrink(Float) | --toc-text-size-shrink <real> For each level of headings in the toc the font is scaled by this factor (default 0.8)
.xslStyleSheet(path: String) | --xsl-style-sheet <file> Use the supplied xsl style sheet for printing the table of content

## Page Options

It is `PageParam` enum type.

Uses in `Page` object initialization.

```swift
Page(view: String, payload: Codable, PageParam...) //for generating Leaf page
//or
Page<Codable>(url: String, PageParam...) //for loading from URL
```

PageParam | Description
------------ | -------------
.allow(path: String) | --allow <path> Allow the file or files from the specified folder to be loaded (repeatable)
.background() | --background Do print background (default)
.noBackground() | --no-background Do not print background
.bypassProxyFor(String) | --bypass-proxy-for <value> Bypass proxy for host (repeatable)
.cacheDir(path: String) | --cache-dir <path> Web cache directory
.checkboxChecked(path: String) | --checkbox-checked-svg <path> Use this SVG file when rendering checked checkboxes
.checkboxUnchecked(path: String) | --checkbox-svg <path> Use this SVG file when rendering unchecked checkboxes
.cookie(name: String, value: String) | --cookie <name> <value> Set an additional cookie (repeatable), value should be url encoded.
.customHeader(name: String, value: String) | --custom-header <name> <value> Set an additional HTTP header (repeatable)
.customHeaderPropagation() | --custom-header-propagation Add HTTP headers specified by
.noCustomHeaderPropagation() | --no-custom-header-propagation  Do not add HTTP headers specified by
.defaultHeader() | --default-header Add a default header, with the name of the page to the left, and the page number to the right
.encoding(String) | --encoding <encoding> Set the default text encoding, for input
.disableExternalLinks() | --disable-external-links Do not make links to remote web pages
.enableExternalLinks() | --enable-external-links Make links to remote web pages (default)
.enableForms() | --enable-forms Turn HTML form fields into pdf form fields
.disableForms() | --disable-forms Do not turn HTML form fields into pdf form fields (default)
.images() | --images Do load or print images (default)
.noImages() | --no-images Do not load or print images
.disableInternalLinks() | --disable-internal-links Do not make local links
.enableInternalLinks() | --enable-internal-links Make local links (default)
.disableJavaScript() | -n, --disable-javascript Do not allow web pages to run javascript
.enableJavaScript() | --enable-javascript Do allow web pages to run javascript (default)
.javascriptDelay(msec: Int) | --javascript-delay <msec> Wait some milliseconds for javascript finish (default 200)
.keepRelativeLinks() | --keep-relative-links Keep relative external links as relative external links
.loadErrorHandling(Handler) | --load-error-handling <handler> Specify how to handle pages that fail to load: abort, ignore or skip (default abort)
.loadMediaErrorHandling(Handler) | --load-media-error-handling <handler> Specify how to handle media files that fail to load: abort, ignore or skip (default ignore)
.enableLocalFileAccess() | --disable-local-file-access Do not allowed conversion of a local file to read in other local files, unless explicitly allowed with --allow
.disableLocalFileAccess() | --enable-local-file-access Allowed conversion of a local file to read in other local files. (default)
.minimumFontSize(Int) | --minimum-font-size <int> Minimum font size
.excludeFromOutline() | --exclude-from-outline Do not include the page in the table of contents and outlines
.includeInOutline() | --include-in-outline Include the page in the table of contents and outlines (default)
.pageOffset(Int) | --page-offset <offset> Set the starting page number (default 0)
.password(String) | --password <password> HTTP Authentication password
.disablePlugins() | --disable-plugins Disable installed plugins (default)
.enablePlugins() | --enable-plugins Enable installed plugins (plugins will likely not work)
.postField(name: String, value: String) | --post <name> <value> Add an additional post field (repeatable)
.postFile(name: String, path: String) | --post-file <name> <path> Post an additional file (repeatable)
.printMediaType() | --print-media-type Use print media-type instead of screen
.noPrintMediaType() | --no-print-media-type Do not use print media-type instead of screen (default)
.proxy(String) | -p, --proxy <proxy> Use a proxy
.proxyHostnameLookup() | --proxy-hostname-lookup Use the proxy for resolving hostnames
.radioButtonChecked(path: String) | --radiobutton-checked-svg <path> Use this SVG file when rendering checked radiobuttons
.radioButtonUnchecked(path: String) | --radiobutton-svg <path> Use this SVG file when rendering unchecked radiobuttons
.resolveRelativeLinks() | --resolve-relative-links Resolve relative external links into absolute links (default)
.runScript(js: String) | --run-script <js> Run this additional javascript after the page is done loading (repeatable)
.disableSmartShrinking() | --disable-smart-shrinking Disable the intelligent shrinking strategy used by WebKit that makes the pixel/dpi ratio none constant
.enableSmartShrinking() | --enable-smart-shrinking Enable the intelligent shrinking strategy used by WebKit that makes the pixel/dpi ratio none constant (default)
.sslCrtPath(path: String) | --ssl-crt-path <path> Path to the ssl client cert public key in OpenSSL PEM format, optionally followed by intermediate ca and trusted certs
.sslKeyPassword(String) | --ssl-key-password <password> Password to ssl client cert private key
.sslKeyPath(path: String) | --ssl-key-path <path> Path to ssl client cert private key in OpenSSL PEM format
.stopSlowScripts() | --stop-slow-scripts Stop slow running javascripts (default)
.noStopSlowScripts() | --no-stop-slow-scripts Do not Stop slow running javascripts
.disableTocBackLinks() | --disable-toc-back-links Do not link from section header to toc (default)
.enableTocBackLinks() | --enable-toc-back-links Link from section header to toc
.userStyleSheet(url: String) | --user-style-sheet <url> Specify a user style sheet, to load with every page
.username(String) | --username <username> HTTP Authentication username
.viewportSize(String) | --viewport-size <> Set viewport size if you have custom scrollbars or css attribute overflow to emulate window size
.windowStatus(String) | --window-status <windowStatus> Wait until window.status is equal to this string before rendering page
.zoom(Float) | --zoom <float> Use this zoom factor (default 1)
