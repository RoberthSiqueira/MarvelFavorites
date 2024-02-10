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

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterCell")
        return tableView
    }()

    // MARK: - API

    func setupView() {
        backgroundColor = .white
        addViewHierarchy()
    }

    // MARK: - VIEW

    private func addViewHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)

        setupConstraints()
    }

    private func setupConstraints() {
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
