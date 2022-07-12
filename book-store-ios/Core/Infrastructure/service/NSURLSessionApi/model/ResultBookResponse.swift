
import Foundation

struct ResultBookResponse: Decodable {
    let results: ArrayBookResponse
    
    func toModel() -> [Book] {
        return results.books.map{ Book(isbn: $0.isbn, image: $0.img, title: $0.title,
                                       author: $0.author, genre: $0.genre, description: $0.description)}
    }
}

struct ArrayBookResponse: Decodable {
    let books: [BookResponse]
}

struct BookResponse: Decodable {
    public let isbn: String
    public let img: String
    public let title: String
    public let author: String
    public let genre: String
    public let description: String
}

