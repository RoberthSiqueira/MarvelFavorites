import CoreData

extension FavoritesViewModel: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,
                    at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            indexPathInsert = newIndexPath ?? IndexPath()
        case .delete:
            indexPathDelete = indexPath ?? IndexPath()
        default:
            break
        }
    }
}
