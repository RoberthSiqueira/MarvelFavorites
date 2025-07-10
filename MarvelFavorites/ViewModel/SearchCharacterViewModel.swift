import Combine
import Foundation

class SearchCharacterViewModel {
    private let marvelclient = MarvelClient.shared
    private var task: URLSessionDataTask?
    private var characters: [Character] = []

    @Published var loadedData: Bool = false
    @Published var charactersCombine: [Character] = []
    private var cancellables: Set<AnyCancellable> = []

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

    func searchCharacterWithCombine(startedWith: String) {
        marvelclient.fetchCharactersWithCombine(namestarWith: startedWith)
            .sink { [weak self] completionError in
                switch completionError {
                case .finished:
                    self?.loadedData  = true
                case .failure(let error):
                    switch error {
                    default:
                        self?.charactersCombine.removeAll()
                    }
                }
            } receiveValue: { [weak self] characters in
                self?.charactersCombine = characters
            }.store(in: &cancellables)
    }

    deinit {
        task = nil
    }
}
