import Foundation

struct APIError: Decodable, Error {
    let message: String
}
