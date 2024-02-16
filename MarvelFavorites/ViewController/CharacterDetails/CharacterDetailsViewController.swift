import UIKit

class CharacterDetailsViewController: UIViewController {

    // MARK: - PROPERTIES

    let character: Character

    // MARK: - INIT

    init(character: Character) {
        self.character = character
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
        let characterDetailsView = CharacterDetailsView(name: character.name,
                                                        description: character.description,
                                                        imageURL: character.thumbnail?.imageURL,
                                                        comics: character.comics?.available,
                                                        stories: character.stories?.available,
                                                        events: character.events?.available,
                                                        series: character.series?.available)
        characterDetailsView.setupView()
        characterDetailsView.delegate = self
        view = characterDetailsView
    }
}

extension CharacterDetailsViewController: CharacterDetailsViewDelegate {
    func didTapFavorite(alreadyIs: Bool) {}
}
