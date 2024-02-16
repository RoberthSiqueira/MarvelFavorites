import Foundation

struct CharacterDataWrapper: Codable {
    let code: Int?
    let status: String?
    let data: CharacterDataContainer?
}

struct CharacterDataContainer: Codable {
    let results: [Character]?
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: CharacterImage?
    let comics: ComicList?
    let stories: StoriesList?
    let events: EventsList?
    let series: SeriesList?
}

struct CharacterImage: Codable {
    let path: String?
    let type: String?
    let imageURL: URL?

    enum CodingKeys: String, CodingKey {
        case path
        case type = "extension"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decode(String?.self, forKey: .path)
        type = try values.decode(String?.self, forKey: .type)
        imageURL = URL(string: "\(path ?? String()).\(type ?? String())")
    }
}

struct ComicList: Codable {
    let available: Int?
}

struct StoriesList: Codable {
    let available: Int?
}

struct EventsList: Codable {
    let available: Int?
}

struct SeriesList: Codable {
    let available: Int?
}
