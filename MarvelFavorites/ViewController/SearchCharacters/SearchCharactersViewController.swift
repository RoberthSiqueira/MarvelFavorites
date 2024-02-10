import UIKit

class SearchCharactersViewController: UIViewController {

    // MARK: - PROPERTIES

    private let searchCharactersView = SearchCharactersView()

    // MARK: - LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search Characters"
        setupView()
    }

    // MARK: - METHODS

    private func setupView() {
        view = searchCharactersView
        searchCharactersView.setupView()
        searchCharactersView.delegate = self
    }
}

extension SearchCharactersViewController: SearchCharactersViewDelegate {}
