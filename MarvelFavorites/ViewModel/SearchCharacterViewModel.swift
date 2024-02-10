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

    func searchCharacter(with nameStartsWith: String, completion: @escaping () -> Void) {
        task?.cancel()
        task = marvelclient.getCharacters(nameStartsWith: nameStartsWith) { [weak self] characters, error in
            if error == nil && !characters.isEmpty {
                self?.characters = characters
                completion()
            }
        }
    }

    deinit {
        task = nil
    }
}
