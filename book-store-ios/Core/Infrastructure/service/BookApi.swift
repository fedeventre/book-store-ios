import Foundation

protocol BookApi {
    func getAll() -> Result<[Book], Error>
    func getBestSellers() -> Result<[String], Error>
}
