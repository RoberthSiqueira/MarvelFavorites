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

        viewModel.searchCharacter(with: nameStarts) { [weak self] success in
            if success {
                self?.searchCharactersView.setViewState(.content)
                self?.searchCharactersView.reloadCharacters()
            } else {
                self?.searchCharactersView.setViewState(.empty)
            }
        }
    }

    func goToCharacterDetails(_ character: CharacterModelView) {
        let detailsViewModel = CharacterDetailsViewModel(character: character)
        let detailsVC = CharacterDetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
