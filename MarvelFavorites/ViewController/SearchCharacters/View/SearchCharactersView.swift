import UIKit

protocol SearchCharactersViewDelegate: AnyObject {
    func numberOfCharacters() -> Int
    func characterForCell(indexPath: IndexPath) -> Character
    func searchCharacter(with nameStarts: String)
    func goToCharacterDetails(_ character: CharacterModelView)
}

class SearchCharactersView: UIView {

    // MARK: - PROPERTIES

    weak var delegate: SearchCharactersViewDelegate?

    enum ViewState {
        case loading
        case empty
        case content
    }

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

    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.hidesWhenStopped = true
        return loadingView
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

    func setViewState(_ state: ViewState) {
        DispatchQueue.main.async {
            switch state {
            case .loading:
                self.noCharactersLabel.isHidden = true
                self.loadingView.startAnimating()
                self.tableView.isHidden = true
            case .empty:
                self.noCharactersLabel.isHidden = false
                self.loadingView.stopAnimating()
                self.tableView.isHidden = true
            case .content:
                self.noCharactersLabel.isHidden = true
                self.loadingView.stopAnimating()
                self.tableView.isHidden = false
            }
        }
    }

    func reloadCharacters() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - VIEW

    private func addViewHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(loadingView)
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
            loadingView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            noCharactersLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            noCharactersLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
}
