import UIKit

class CharacterDetailsViewController: UIViewController {

    // MARK: - PROPERTIES

    let viewModel: CharacterDetailsViewModel

    // MARK: - INIT

    init(viewModel: CharacterDetailsViewModel) {
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
        navigationItem.title = "Character Details"
        setupView()
    }

    // MARK: - METHODS

    private func setupView() {
        let character = viewModel.retrieveCharacter()
        let characterDetailsView = CharacterDetailsView(name: character.name,
                                                        description: character.description,
                                                        imageURL: character.imageURL,
                                                        comics: character.comics,
                                                        stories: character.stories,
                                                        events: character.events,
                                                        series: character.series)
        characterDetailsView.setupView()
        characterDetailsView.delegate = self
        view = characterDetailsView
    }
}

extension CharacterDetailsViewController: CharacterDetailsViewDelegate {
    func didTapFavorite(alreadyIs: Bool) {
        viewModel.toFavorite(alreadyIs)
    }
}
