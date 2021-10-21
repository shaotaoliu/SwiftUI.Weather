import Foundation

extension WeatherResponse {
    
    static func loadFromFile(filename: String) -> WeatherResponse {
        
        var data: Data? = nil
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("File does not exist")
        }
        
        do {
            data = try Data(contentsOf: file)
        }
        catch {
            fatalError("Cannot read from file")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            return try decoder.decode(WeatherResponse.self, from: data!)
        }
        catch {
            fatalError("Cannot decode file: \(error)")
        }
    }
}
