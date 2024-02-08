import Foundation

class MarvelClient {
    static let shared = MarvelClient()

    private var total: Int = .zero

    enum Endpoints {

        static private let baseURL = "https://gateway.marvel.com/v1/public"
        static private let apiKey = "6522eea05abacc2c4526361e6bd0fdda"
        static private let privateKey = "d412fca9cfb394ff4a4a65d925998faaecc93723"
        static private let timestamp = Int(Date().timeIntervalSince1970).description
        static private let hash = (apiKey + privateKey + timestamp).md5

        static private let limitParam: Int = 100
        static private let defaultParams = "&apiKey=\(apiKey)&ts=\(timestamp)&hash=\(hash).md5"

        case characters(nameStartsWith: String)

        var stringValue: String {
            switch self {
            case .characters(let nameStartsWith):
                    return Endpoints.baseURL +
                            "/characters" +
                            "/limit=\(Endpoints.limitParam)" +
                            "&orderBy=modified" +
                            "&nameStartsWith=\(nameStartsWith)" +
                            Endpoints.defaultParams
            }
        }

        var url: URL {
            return URL(string: stringValue) ?? URL(string: "https://developer.marvel.com")!
        }
    }

    func getCharacters(nameStartsWith: String, completion: @escaping ([Character], Error?) -> Void) {
        let url = Endpoints.characters(nameStartsWith: nameStartsWith).url
        getRequest(url: url, responseType: CharacterDataWrapper.self) { result in
            switch result {
            case .success(let charDataWrapper):
                guard let results = charDataWrapper.charDataContainer?.results else {
                    completion([], nil)
                    return
                }
                completion(results, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }

    private func getRequest<ResponseType: Decodable>(url: URL,
                                                     responseType: ResponseType.Type,
                                                     completion: @escaping (Result<ResponseType, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.badURL))
                }
                return
            }

            let decoder = JSONDecoder()
            do {
                let decodableObject = try decoder.decode(responseType, from: data)

                DispatchQueue.main.async {
                    completion(.success(decodableObject))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case badURL
}
