import Foundation

struct NewsItem: Identifiable, Decodable {
    let id: String
    let title: String
    let shortDescription: String
    let longDescription: String
    let imageUrl: String
    let link: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id" 
        case title
        case shortDescription
        case longDescription
        case imageUrl
        case link
    }
}
