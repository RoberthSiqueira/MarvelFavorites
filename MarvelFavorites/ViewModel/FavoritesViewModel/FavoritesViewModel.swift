import CoreData
import Foundation

class FavoritesVieModel: NSObject {

    // MARK: PROPETIES

    private let viewContext = DataController.shared.viewContext
    private var fetchResultsController: NSFetchedResultsController<Favorite>?

    // MARK: - INIT

    override init() {
        super.init()
    }

    // MARK: - API

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
        let sort = NSSortDescriptor(key: "modified", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        return fetchRequest
    }
}
