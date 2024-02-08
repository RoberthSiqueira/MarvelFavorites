import Foundation

class MarvelClient {
    static let shared = MarvelClient()

    private let apiKey = "6522eea05abacc2c4526361e6bd0fdda"
    private let privateKey = "d412fca9cfb394ff4a4a65d925998faaecc93723"
    private let timestamp = Int(Date().timeIntervalSince1970).description
    private let limit: Int = 50
    private var total: Int = .zero

    enum Endpoints {

        static private let baseURL = "https://gateway.marvel.com/v1/public"

        case characters(limit: Int, nameStartsWith: String)

        var stringValue: String {
            switch self {
            case .characters(let limit, let nameStartsWith):
                    return Endpoints.baseURL +
                            "/characters" +
                            "/limit=\(limit)" +
                            "&orderBy=modified" +
                            "&nameStartsWith=\(nameStartsWith)"
            }
        }

        var url: URL {
            return URL(string: stringValue) ?? URL(string: "https://developer.marvel.com")!
        }
    }

    func getCharacters(nameStartsWith: String, completion: @escaping (Bool, Error?) -> Void) {
        let url = Endpoints.characters(limit: limit, nameStartsWith: nameStartsWith).url
        getRequest(url: url, responseType: Bool.self) { result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
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
