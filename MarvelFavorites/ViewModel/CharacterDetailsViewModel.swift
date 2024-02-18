import CoreData
import Foundation

class CharacterDetailsViewModel {

    // MARK: PROPERTIES

    private let viewContext = DataController.shared.viewContext
    private var fetchResultsController: NSFetchedResultsController<Favorite>?
    private let character: CharacterModelView

    // MARK: - INIT

    init(character: CharacterModelView) {
        self.character = character
        performFavoriteCheck()
    }

    // MARK: - API

    func retrieveCharacter() -> CharacterModelView {
        return character
    }

    func isFavoriteCharacter() -> Bool {
        if let object = fetchResultsController?.fetchedObjects {
            return !object.isEmpty
        }
        return false
    }

    func toFavorite(_ alreadyIs: Bool) {
        if alreadyIs {
            guard let favorite = fetchResultsController?.fetchedObjects?.first else { return }
            deleteFavorite(favorite)
        } else {
            createFavorite()
        }
    }

    // MARK: METHODS

    private func performFavoriteCheck() {
        let query = requestFavoriteFetch()
        fetchResultsController = NSFetchedResultsController(fetchRequest: query,
                                                            managedObjectContext: viewContext,
                                                            sectionNameKeyPath: nil,
                                                            cacheName: nil)
        do {
            try fetchResultsController?.performFetch()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func requestFavoriteFetch() -> NSFetchRequest<Favorite> {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", character.id)

        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = []
        return fetchRequest
    }

    private func deleteFavorite(_ favorite: Favorite) {
        viewContext.delete(favorite)
        saveContext()
    }

    private func createFavorite() {
        let favorite = Favorite(context: viewContext)
        favorite.id = Int32(character.id)
        favorite.name = character.name
        favorite.desc = character.description
        favorite.imageURL = character.imageURL
        favorite.comics = Int16(character.comics)
        favorite.events = Int16(character.events)
        favorite.series = Int16(character.series)
        favorite.stories = Int16(character.stories)
        favorite.addedIn = Date()

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
