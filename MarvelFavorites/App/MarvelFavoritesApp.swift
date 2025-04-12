import SwiftUI

@main
struct MarvelFavoritesApp: App {
    var body: some Scene {
        WindowGroup {
            MarvelFavoritesTab()
        }
    }
}

struct MarvelFavoritesTab: UIViewControllerRepresentable {
    typealias UIViewControllerType = TabBarController

    func makeUIViewController(context: Context) -> TabBarController {
        let tabbarController = TabBarController()
        return tabbarController
    }

    func updateUIViewController(_ uiViewController: TabBarController, context: Context) { }
}

#Preview {
    MarvelFavoritesTab()
}
