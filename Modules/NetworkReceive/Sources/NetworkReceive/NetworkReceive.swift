import Foundation

public class NetworkReceive {

    public init() {}

    public func fetch<T: Codable>(_ t: T.Type, for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard error == nil else {
                print(String(describing: error))
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        }.resume()
    }
}

public enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError(err: String)
    case error(err: String)
}
