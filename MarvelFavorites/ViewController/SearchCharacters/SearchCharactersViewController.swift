import UIKit

class SearchCharactersViewController: UIViewController {

    // MARK: - PROPERTIES

    private let searchCharactersView = SearchCharactersView()

    let viewModel: SearchCharacterViewModel

    // MARK: - INIT

    init(viewModel: SearchCharacterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

extension SearchCharactersViewController: SearchCharactersViewDelegate {
    func numberOfCharacters() -> Int {
        return viewModel.numberOfCharacters()
    }

    func characterForCell(indexPath: IndexPath) -> Character {
        return viewModel.characterForCell(indexPath: indexPath)
    }

    func searchCharacter(with nameStarts: String) {
        viewModel.searchCharacter(with: nameStarts) { [weak self] in
            self?.searchCharactersView.reloadCharacters()
        }
    }
}
