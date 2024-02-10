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
}

struct CharacterImage: Codable {
    let path: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case path
        case type = "extension"
    }
}
