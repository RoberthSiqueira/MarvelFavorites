import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchCharactersTabView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            FavaoritesTabView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}

struct SearchCharactersTabView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        let viewModel = SearchCharacterViewModel()
        let searchCharVC = SearchCharactersViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: searchCharVC)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

struct FavaoritesTabView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        let viewModel = FavoritesViewModel()
        let favoritesVC = FavoritesViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: favoritesVC)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}

#Preview {
    MainTabView()
}
