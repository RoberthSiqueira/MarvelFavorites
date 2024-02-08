import Foundation

struct CharacterDataWrapper: Codable {
    let code: String?
    let status: String?
    let charDataContainer: CharacterDataContainer?
}

struct CharacterDataContainer: Codable {
    let results: [Character]?
}

struct Character: Codable {
    let id: String
    let name: String
    let description: String
    let thumbnail: CharacterImage
}

struct CharacterImage: Codable {
    let path: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case path
        case type = "extension"
    }
}
