import UIKit

protocol SearchCharactersViewDelegate: AnyObject {
    func numberOfCharacters() -> Int
    func characterForCell(indexPath: IndexPath) -> Character
    func searchCharacter(with nameStarts: String)
    func goToCharacterDetails(_ character: CharacterViewModel)
}

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

    private lazy var noCharactersLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "No characters to show"
        label.isHidden = true
        return label
    }()

    // MARK: - API

    func setupView() {
        backgroundColor = .white
        addViewHierarchy()
    }

    func reloadCharacters() {
        DispatchQueue.main.async {
            self.noCharactersLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }

    func noCharactersToShow() {
        tableView.isHidden = true
        noCharactersLabel.isHidden = false
    }

    // MARK: - VIEW

    private func addViewHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(noCharactersLabel)

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

        NSLayoutConstraint.activate([
            noCharactersLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            noCharactersLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
}
