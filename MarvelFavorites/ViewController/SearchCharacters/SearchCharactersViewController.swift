import UIKit

class SearchCharactersViewController: UIViewController {

    // MARK: - PROPERTIES

    private(set) var searchCharactersView = SearchCharactersView()

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
        searchCharactersView.setupView()
        searchCharactersView.delegate = self
        view = searchCharactersView
    }

    private func searchCharacterHandler(_ success: Bool) {
        let isThereCharacter = viewModel.numberOfCharacters() > 0

        if success && isThereCharacter {
            searchCharactersView.setViewState(.content)
        } else if success && !isThereCharacter {
            searchCharactersView.setViewState(.empty)
        } else {
            searchCharactersView.setViewState(.error)
            showConnectionError()
        }

        searchCharactersView.reloadCharacters()
    }

    private func showConnectionError() {
        let alert = UIAlertController(title: "Connection Error",
                                      message: "Check your connectivity with the internet.",
                                      preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Sure", style: .default)
        alert.addAction(actionOk)
        present(alert, animated: true)
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
        searchCharactersView.setViewState(.loading)
        viewModel.searchCharacter(with: nameStarts, completion: searchCharacterHandler(_:))
    }

    func goToCharacterDetails(_ character: CharacterModelView) {
        let detailsViewModel = CharacterDetailsViewModel(character: character)
        let detailsVC = CharacterDetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
