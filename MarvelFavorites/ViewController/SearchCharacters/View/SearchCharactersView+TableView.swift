import UIKit

extension SearchCharactersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let lenght = delegate?.numberOfCharacters() else { return 0 }
        return lenght
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CharacterCell",
            for: indexPath
        ) as? CharacterTableViewCell,
              let character = delegate?.characterForCell(indexPath: indexPath) else {
            return UITableViewCell()
        }

        cell.setupCell(name: character.name ?? String(), description: character.description ?? String())

        return cell
    }
}

extension SearchCharactersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Go to detail
    }
}
