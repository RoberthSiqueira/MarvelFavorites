import UIKit

extension SearchCharactersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "CharacterCell",
            for: indexPath
        ) as? CharacterTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }
}

extension SearchCharactersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Go to detail
    }
}
