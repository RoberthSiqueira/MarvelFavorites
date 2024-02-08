import UIKit

class TabBarController: UITabBarController {

    // MARK: LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewControllers()
    }

    // MARK: PRIVATE METHODS

    private func setupViewControllers() {
        let navigationControllers = [
            createSearchCharactersNavigation(),
            createFavoritesNavigation()
        ]

        setViewControllers(navigationControllers, animated: true)
        selectedViewController = navigationControllers[0]
    }

    private func createSearchCharactersNavigation() -> UINavigationController {
        let searchCharVC = SearchCharactersViewController()
        let navigationFromSearchChar = UINavigationController(rootViewController: searchCharVC)
        navigationFromSearchChar.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        return navigationFromSearchChar
    }

    private func createFavoritesNavigation() -> UINavigationController {
        let navigationFromFavorites = UINavigationController()
        navigationFromFavorites.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        return navigationFromFavorites
    }
}
