import UIKit

protocol CharacterDetailsViewDelegate: AnyObject {
    func didTapFavorite(alreadyIs: Bool)
}

class CharacterDetailsView: UIView {

    // MARK: - PROPERTIES

    weak var delegate: CharacterDetailsViewDelegate?

    // MARK: - INIT

    init(name: String, description: String, imageURL: URL?, comics: Int, stories: Int, events: Int, series: Int) {
        super.init(frame: .zero)

        nameLabel.text = name
        descriptionLabel.text = description

        comicsLengthLabel.text = "Comics: \(comics)"
        storiesLengthLabel.text = "Stories: \(stories)"
        eventsLengthLabel.text = "Events: \(events)"
        seriesLengthLabel.text = "Series: \(series)"

        if let url = imageURL {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url) {
                    let image = UIImage(data: imageData) ?? UIImage()
                    DispatchQueue.main.async {
                        self.thumbImageView.image = image
                        self.setNeedsLayout()
                    }
                }
            }
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "photo-placeholder")
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var comicsLengthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var storiesLengthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var eventsLengthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var seriesLengthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var lengthStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [comicsLengthLabel, storiesLengthLabel,
                                                       eventsLengthLabel, seriesLengthLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("FAVORITE", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        return button
    }()

    // MARK: - API

    func setupView() {
        addViewHierarchy()
    }

    // MARK: - ACTION

    @objc private func didTapFavorite(_ sender: UIButton) {
        delegate?.didTapFavorite(alreadyIs: false)
    }

    // MARK: - VIEW

    private func addViewHierarchy() {
        addSubview(thumbImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(lengthStackView)
        addSubview(favoriteButton)

        setupConstraints()
    }

    private func setupConstraints() {
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            thumbImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            thumbImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            thumbImageView.widthAnchor.constraint(equalToConstant: 320),
            thumbImageView.heightAnchor.constraint(equalToConstant: 320)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            lengthStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            lengthStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            lengthStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            favoriteButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            favoriteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16)
        ])
    }
}
