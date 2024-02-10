//
//  CharacterTableViewCell.swift
//  MarvelFavorites
//
//  Created by Roberth Siqueira on 10/02/24.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

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

    // MARK: - API

    func setupCellImage(_ image: UIImage) {
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
            thumbImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            thumbImageView.widthAnchor.constraint(equalToConstant: 48),
            thumbImageView.heightAnchor.constraint(equalToConstant: 48)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
