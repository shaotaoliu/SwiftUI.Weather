import Foundation

class WebService {
    
    static let shared = WebService()
    
    private init() {}
    
    func fetch<T: Codable>(urlString: String, completion: @escaping (Result<T, WebError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString: urlString)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch {
                completion(.failure(.decodingError(error: error)))
            }
        }.resume()
    }
}
