import UIKit

extension FavoritesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let length = delegate?.numberOfCharacters() else { return 0 }
        return length
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell",
                                                       for: indexPath) as? CharacterTableViewCell,
              let character = delegate?.characterForCell(indexPath: indexPath) else {
            return UITableViewCell()
        }

        cell.setupCell(name: character.name,
                       description: character.description,
                       imageURL: character.imageURL)

        return cell
    }
}

extension FavoritesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let character = delegate?.characterForCell(indexPath: indexPath) else { return }
        let characterToView = CharacterModelView(id: character.id,
                                                 name: character.name,
                                                 description: character.description,
                                                 imageURL: character.imageURL,
                                                 comics: character.comics,
                                                 stories: character.stories,
                                                 events: character.events,
                                                 series: character.series)
        delegate?.goToCharacterDetails(characterToView)
    }
}
