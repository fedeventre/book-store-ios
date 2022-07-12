import Foundation

protocol BookRepository {
    func putAll(_ books: [Book])
    func findAll(_ ids: [String]) -> [Book]
    func findBy(isbn: String) -> Book?
    func findByGenre(name: String) -> [Book]
    func findAllBestSeller() -> [Book]
}
