import UIKit

class CharacterTableViewCell: UITableViewCell {

    // MARK: - UI

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
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    // MARK: - INIT

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViewHierarchy()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFE CYCLE

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

    // MARK: - API

    func setupCell(name: String?, description: String?, imageURL: URL?) {
        nameLabel.text = name
        descriptionLabel.text = description

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

    func setupCell(name: String?, description: String?, imageData: Data) {
        nameLabel.text = name
        descriptionLabel.text = description

        let image = UIImage(data: imageData) ?? UIImage()
        DispatchQueue.main.async {
            self.thumbImageView.image = image
            self.setNeedsLayout()
        }
    }

    // MARK: - VIEW

    private func addViewHierarchy() {
        contentView.addSubview(thumbImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            thumbImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            thumbImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            thumbImageView.widthAnchor.constraint(equalToConstant: 64),
            thumbImageView.heightAnchor.constraint(equalToConstant: 64)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
