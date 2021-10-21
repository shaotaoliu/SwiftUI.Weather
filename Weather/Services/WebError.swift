import Foundation

enum WebError: Error {
    case invalidURL(urlString: String)
    case serverError(error: Error)
    case emptyData
    case decodingError(error: Error)
}
