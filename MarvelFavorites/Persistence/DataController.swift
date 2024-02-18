import CoreData
import Foundation

class DataController {

    // MARK: PROPERTIES

    static let shared = DataController(modelName: "DataModel")

    private let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    // MARK: - INIT

    private init(modelName: String) {
        container = NSPersistentContainer(name: modelName)
    }

    // MARK: - API

    func load() {
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
        }
    }
}
