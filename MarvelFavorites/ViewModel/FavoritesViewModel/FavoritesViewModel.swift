import CoreData
import Foundation

class FavoritesViewModel: NSObject {

    // MARK: PROPETIES

    private let viewContext = DataController.shared.viewContext
    private var fetchResultsController: NSFetchedResultsController<Favorite>?

    // MARK: - INIT

    override init() {
        super.init()
        performFavoritesFetch()
    }

    // MARK: - API

    func numberOfCharacters() -> Int {
        if let objects = fetchResultsController?.fetchedObjects {
            return objects.count
        }
        return .zero
    }

    func characterForCell(indexPath: IndexPath) -> CharacterModelView? {
        guard let favorite = fetchResultsController?.object(at: indexPath) else { return nil }

        let characterModelView = CharacterModelView(id: Int(favorite.id),
                                                    name: favorite.name ?? String(),
                                                    description: favorite.desc ?? String(),
                                                    imageURL: favorite.imageURL,
                                                    comics: Int(favorite.comics),
                                                    stories: Int(favorite.stories),
                                                    events: Int(favorite.events),
                                                    series: Int(favorite.series))
        return characterModelView
    }

    // MARK: METHODS

    private func performFavoritesFetch() {
        let query = requestFavoriteFetch()
        fetchResultsController = NSFetchedResultsController(fetchRequest: query,
                                                            managedObjectContext: viewContext,
                                                            sectionNameKeyPath: nil,
                                                            cacheName: nil)
        fetchResultsController?.delegate = self

        do {
            try fetchResultsController?.performFetch()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func requestFavoriteFetch() -> NSFetchRequest<Favorite> {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let sort = NSSortDescriptor(key: "addedIn", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        return fetchRequest
    }
}
