
import Foundation
@testable import book_store_ios

class BookRepositoryMock: BookRepository {
    private var books =  [Book]()
    
    func putAll(_ books: [Book]) {
        self.books = books
    }
    
    func findAll(_ ids: [String]) -> [Book] {
        return books.filter { book in
            ids.contains(book.isbn)
        }
    }
    
    func findBy(isbn: String) -> Book? {
        return books.first { $0.isbn == isbn }
    }
    
    func findByGenre(name: String) -> [Book] {
        return books.filter { $0.genre == name}
    }
    
    func findAllBestSeller() -> [Book] {
        return books.filter{ $0.isBestSeller }
    }
}
