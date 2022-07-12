import Foundation


struct Section {
    public let name: String
    public let position: Int
    public let books: [Book]
    
    func amountOfBooks() -> Int {
        books.count
    }
}

