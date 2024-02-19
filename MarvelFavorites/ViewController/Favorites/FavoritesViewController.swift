import Combine
import UIKit

class FavoritesViewController: UIViewController {

    // MARK: - PROPERTIES

    private let favoriteView = FavoritesView()

    private var subscriptions = Set<AnyCancellable>()

    let viewModel: FavoritesViewModel

    // MARK: - INIT

    init(viewModel: FavoritesViewModel) {
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
        navigationItem.title = "Favorite Characters"
        setupView()
        setupBindings()
    }

    // MARK: - METHODS

    private func setupView() {
        favoriteView.setupView()
        favoriteView.delegate = self
        view = favoriteView
    }

    private func setupBindings() {
        viewModel.$indexPathInsert.sink(receiveValue: { [weak self] indexPath in
            guard !indexPath.isEmpty else { return }
            self?.favoriteView.insertRowOnTableView(indexPath: indexPath)
        }).store(in: &subscriptions)

        viewModel.$indexPathDelete.sink(receiveValue: { [weak self] indexPath in
            guard !indexPath.isEmpty else { return }
            self?.favoriteView.deleteRowFromTable(indexPath: indexPath)
        }).store(in: &subscriptions)
    }
}

extension FavoritesViewController: FavoritesViewDelegate {
    func numberOfCharacters() -> Int {
        return viewModel.numberOfCharacters()
    }

    func characterForCell(indexPath: IndexPath) -> CharacterModelView? {
        return viewModel.characterForCell(indexPath: indexPath)
    }

    func goToCharacterDetails(_ character: CharacterModelView) {
        let detailsViewModel = CharacterDetailsViewModel(character: character)
        let detailsVC = CharacterDetailsViewController(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
