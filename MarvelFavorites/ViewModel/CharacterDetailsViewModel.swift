import CoreData
import Foundation

class CharacterDetailsViewModel {

    // MARK: PROPERTIES

    private let viewContext = DataController.shared.viewContext
    private let character: CharacterViewModel

    // MARK: - INIT

    init(character: CharacterViewModel) {
        self.character = character
    }

    // MARK: - API

    func retrieveCharacter() -> CharacterViewModel {
        return character
    }

    func toFavorite(_ alreadyIs: Bool) {
        if alreadyIs {
            // TODO: Remove objects from View Context
        }
        createFavorite()
    }

    // MARK: METHODS

    private func createFavorite() {
        let favorite = Favorite(context: viewContext)
        favorite.name = character.name
        favorite.desc = character.description
        favorite.imageURL = character.imageURL
        favorite.comics = Int16(character.comics)
        favorite.events = Int16(character.events)
        favorite.series = Int16(character.series)
        favorite.stories = Int16(character.stories)
        favorite.modified = Date()

        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            fatalError("Could not save favorite")
        }
    }
}
