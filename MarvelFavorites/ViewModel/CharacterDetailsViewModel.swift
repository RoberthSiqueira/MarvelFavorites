import Foundation

class CharacterDetailsViewModel {

    private let character: CharacterViewModel

    init(character: CharacterViewModel) {
        self.character = character
    }

    func retrieveCharacter() -> CharacterViewModel {
        return character
    }

    func toFavorite(_ alreadyIs: Bool) {
        // TODO: Add on CoreData if it is not favorite OR Remove from objects on CoreData if it already favorite
    }
}
