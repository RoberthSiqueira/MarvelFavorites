import UIKit

class TabBarController: UITabBarController {

    // MARK: UI

    private lazy var tableModeTabBarItem: UITabBarItem = {
        let image = UIImage(imageLiteralResourceName: "search")
        let tabBarItem = UITabBarItem(title: nil, image: image, tag: 0)
        return tabBarItem
    }()

    private lazy var collectionModeTabBarItem: UITabBarItem = {
        let image = UIImage(imageLiteralResourceName: "favorite")
        let tabBarItem = UITabBarItem(title: nil, image: image, tag: 0)
        return tabBarItem
    }()

    // MARK: LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewControllers()
    }

    // MARK: PRIVATE METHODS

    private func setupViewControllers() {}
}
