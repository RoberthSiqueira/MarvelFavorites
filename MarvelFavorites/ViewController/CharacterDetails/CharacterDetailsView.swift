import UIKit

protocol CharacterDetailsViewDelegate: AnyObject {
    func didTapFavorite(alreadyIs: Bool)
}

class CharacterDetailsView: UIView {

    // MARK: - PROPERTIES

    private var isFavorite: Bool
    weak var delegate: CharacterDetailsViewDelegate?

    // MARK: - INIT

    init(name: String, description: String, imageURL: URL?, comics: Int,
         stories: Int, events: Int, series: Int, isFavorite: Bool) {

        self.isFavorite = isFavorite

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

        favoriteBehavior(isFavorite: isFavorite)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var thumbImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        imageView.image = UIImage(systemName: "person.crop.rectangle")
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
        return label
    }()

    private lazy var storiesLengthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private lazy var eventsLengthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private lazy var seriesLengthLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [comicsLengthLabel, storiesLengthLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eventsLengthLabel, seriesLengthLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        return button
    }()

    // MARK: - API

    func setupView() {
        addViewHierarchy()
    }

    // MARK: - ACTION

    @objc private func didTapFavorite(_ sender: UIButton) {
        delegate?.didTapFavorite(alreadyIs: isFavorite)
        isFavorite.toggle()
        favoriteBehavior(isFavorite: isFavorite)
    }

    // MARK: - METHODS

    private func favoriteBehavior(isFavorite: Bool) {
        favoriteButton.setTitle(isFavorite ? "UNFAVORITE" : "FAVORITE", for: .normal)
        favoriteButton.setTitleColor(isFavorite ? .systemRed : .systemBlue, for: .normal)
        favoriteButton.layer.borderColor = isFavorite ? UIColor.systemRed.cgColor : UIColor.systemBlue.cgColor
    }

    // MARK: - VIEW

    private func addViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)

        containerView.addSubview(thumbImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(topStackView)
        containerView.addSubview(bottomStackView)
        containerView.addSubview(favoriteButton)

        setupScrollViewConstraints()
        setupConstraints()
    }

    private func setupScrollViewConstraints() {
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            thumbImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            thumbImageView.widthAnchor.constraint(equalToConstant: 320),
            thumbImageView.heightAnchor.constraint(equalToConstant: 320)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: thumbImageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            topStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 8),
            bottomStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            bottomStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 16),
            favoriteButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            favoriteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
}
