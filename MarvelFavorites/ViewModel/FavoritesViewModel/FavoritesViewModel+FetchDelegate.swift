import CoreData

extension FavoritesViewModel: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,
                    at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            // TODO: Add character on table view
            break
        case .delete:
            // TODO: Delete character from table view
            break
        default:
            break
        }
    }
}
