import Foundation

@objc
class Movie: NSObject, Codable {
    @objc var identifier: String
    @objc var title: String
    @objc var plot: String

    enum CodingKeys: String, CodingKey {
        case identifier = "imdbID"
        case title = "Title"
        case plot = "Plot"
    }

    @objc init(identifier: String, title: String, plot: String) {
        self.identifier = identifier
        self.title = title
        self.plot = plot
    }
}
