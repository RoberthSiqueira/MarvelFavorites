import UIKit

protocol SearchCharactersViewDelegate: AnyObject {}

class SearchCharactersView: UIView {

    // MARK: - PROPERTIES

    weak var delegate: SearchCharactersViewDelegate?

    // MARK: - UI

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.delegate = self
        searchBar.placeholder = "Character's name"
        return searchBar
    }()

    // MARK: - API

    func setupView() {
        backgroundColor = .white
        addViewHierarchy()
    }

    // MARK: - VIEW

    private func addViewHierarchy() {
        addSubview(searchBar)

        setupConstraints()
    }

    private func setupConstraints() {
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}
