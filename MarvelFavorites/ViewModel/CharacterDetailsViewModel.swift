import Foundation

class CharacterDetailsViewModel {

    private let character: CharacterViewModel

    init(character: CharacterViewModel) {
        self.character = character
    }

    func retrieveCharacter() -> CharacterViewModel {
        return character
    }
}
