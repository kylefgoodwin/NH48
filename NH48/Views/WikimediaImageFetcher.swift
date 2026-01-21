import Foundation

struct WikimediaImageFetcher {
    struct Response: Codable {
        let query: Query?
    }
    struct Query: Codable {
        let pages: [String: Page]
    }
    struct Page: Codable {
        let original: WikiImage?
        let thumbnail: WikiImage?
    }
    struct WikiImage: Codable {
        let source: String
    }

    static func fetchImageURL(for title: String) async throws -> URL? {
        // Prefer original image; fallback to a large thumbnail
        // Wikipedia API: https://en.wikipedia.org/w/api.php?action=query&prop=pageimages&piprop=original&pithumbsize=1600&format=json&titles=...
        var components = URLComponents(string: "https://en.wikipedia.org/w/api.php")!
        components.queryItems = [
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "prop", value: "pageimages"),
            URLQueryItem(name: "piprop", value: "original"),
            URLQueryItem(name: "pithumbsize", value: "1600"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "titles", value: title)
        ]
        guard let url = components.url else { return nil }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        guard let pages = decoded.query?.pages, let page = pages.values.first else { return nil }

        if let src = page.original?.source, let url = URL(string: src) { return url }
        if let src = page.thumbnail?.source, let url = URL(string: src) { return url }
        return nil
    }
}
