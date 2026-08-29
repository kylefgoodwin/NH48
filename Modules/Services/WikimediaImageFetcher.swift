import Foundation

struct WikimediaImageFetcher {
    struct PageImagesResponse: Codable {
        let query: Query?
        struct Query: Codable { let pages: [String: Page] }
        struct Page: Codable { let original: WikiImage?; let thumbnail: WikiImage? }
        struct WikiImage: Codable { let source: String }
    }

    struct CommonsResponse: Codable {
        let query: Query?
        struct Query: Codable { let pages: [String: Page] }
        struct Page: Codable { let imageinfo: [ImageInfo]? }
        struct ImageInfo: Codable {
            let url: String?
            let descriptionurl: String?
            let extmetadata: ExtMetadata?
        }
        struct ExtMetadata: Codable {
            let artist: MetaField?
            let licenseShortName: MetaField?
            let objectName: MetaField?
            enum CodingKeys: String, CodingKey {
                case artist = "Artist"
                case licenseShortName = "LicenseShortName"
                case objectName = "ObjectName"
            }
        }
        struct MetaField: Codable { let value: String? }
    }

    struct Attribution {
        var title: String?
        var author: String?
        var license: String?
        var filePageURL: String?
    }

    static func fetchImageURL(for title: String) async throws -> URL? {
        var components = URLComponents(string: "https://en.wikipedia.org/w/api.php")!
        components.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "prop", value: "pageimages"),
            URLQueryItem(name: "piprop", value: "original"),
            URLQueryItem(name: "pithumbsize", value: "1600"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "titles", value: title),
            URLQueryItem(name: "redirects", value: "1"),
        ]
        guard let url = components.url else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PageImagesResponse.self, from: data)
        guard let pages = decoded.query?.pages, let page = pages.values.first else { return nil }
        if let src = page.original?.source, let url = URL(string: src) { return url }
        if let src = page.thumbnail?.source, let url = URL(string: src) { return url }
        return nil
    }

    static func fetchCommonsMetadata(forImageURL url: URL) async throws -> Attribution? {
        // Extract filename from URL (after last "/"); Wikimedia uses File: namespace
        let filename = url.lastPathComponent
        guard !filename.isEmpty else { return nil }

        var components = URLComponents(string: "https://commons.wikimedia.org/w/api.php")!
        components.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "prop", value: "imageinfo"),
            URLQueryItem(name: "iiprop", value: "extmetadata|url"),
            URLQueryItem(name: "titles", value: "File:\(filename)")
        ]
        guard let apiURL = components.url else { return nil }
        let (data, _) = try await URLSession.shared.data(from: apiURL)
        let decoded = try JSONDecoder().decode(CommonsResponse.self, from: data)
        guard let page = decoded.query?.pages.values.first, let info = page.imageinfo?.first else { return nil }
        var attr = Attribution()
        attr.title = info.extmetadata?.objectName?.value
        attr.author = info.extmetadata?.artist?.value
        attr.license = info.extmetadata?.licenseShortName?.value
        attr.filePageURL = info.descriptionurl
        return attr
    }

    struct SearchResponse: Codable {
        let query: Query?
        struct Query: Codable { let search: [SearchItem] }
        struct SearchItem: Codable { let title: String }
    }

    static func searchBestTitle(for query: String) async throws -> String? {
        var components = URLComponents(string: "https://en.wikipedia.org/w/api.php")!
        components.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "list", value: "search"),
            URLQueryItem(name: "srsearch", value: query),
            URLQueryItem(name: "srlimit", value: "1"),
            URLQueryItem(name: "format", value: "json")
        ]
        guard let url = components.url else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(SearchResponse.self, from: data)
        return decoded.query?.search.first?.title
    }
    
    struct GeoSearchResponse: Codable {
        let query: Query?
        struct Query: Codable { let geosearch: [Item] }
        struct Item: Codable { let title: String }
    }

    static func searchNearbyTitle(lat: Double, lon: Double, radiusMeters: Int = 10000) async throws -> String? {
        var components = URLComponents(string: "https://en.wikipedia.org/w/api.php")!
        components.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "list", value: "geosearch"),
            URLQueryItem(name: "gscoord", value: "\(lat)|\(lon)"),
            URLQueryItem(name: "gsradius", value: String(radiusMeters)),
            URLQueryItem(name: "gslimit", value: "1"),
            URLQueryItem(name: "format", value: "json")
        ]
        guard let url = components.url else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(GeoSearchResponse.self, from: data)
        return decoded.query?.geosearch.first?.title
    }
}
