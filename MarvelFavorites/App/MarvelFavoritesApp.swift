import SwiftUI

@main
struct MarvelFavoritesApp: App {

    let dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView().onAppear {
                dataController.load()
            }
        }
    }
}
