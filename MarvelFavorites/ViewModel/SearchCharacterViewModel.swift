import Foundation

class SearchCharacterViewModel {
    private let marvelclient = MarvelClient.shared
    private var task: URLSessionDataTask?
    private var characters: [Character] = []

    func numberOfCharacters() -> Int {
        return characters.count
    }

    func characterForCell(indexPath: IndexPath) -> Character {
        return characters[indexPath.row]
    }

    func searchCharacter(with nameStartsWith: String, completion: @escaping (_ success: Bool) -> Void) {
        task?.cancel()
        task = marvelclient.getCharacters(nameStartsWith: nameStartsWith) { [weak self] characters, error in
            if let error {
                if let networkError = error as? NetworkError, networkError == .badURL {
                    self?.characters.removeAll()
                    completion(false)
                }
            } else {
                self?.characters = characters
                completion(true)
            }
        }
    }

    deinit {
        task = nil
    }
}
