import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func numberOfCharacters() -> Int
    func characterForCell(indexPath: IndexPath) -> CharacterModelView?
    func goToCharacterDetails(_ character: CharacterModelView)
}

class FavoritesView: UIView {

    // MARK: - PROPERTIES

    weak var delegate: FavoritesViewDelegate?

    // MARK: - UI

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

    func deleteRowFromTable(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .none)
    }

    func insertRowOnTableView(indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .none)
    }

    // MARK: - VIEW

    private func addViewHierarchy() {
        addSubview(tableView)
        addSubview(noCharactersLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        let safeArea = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
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
