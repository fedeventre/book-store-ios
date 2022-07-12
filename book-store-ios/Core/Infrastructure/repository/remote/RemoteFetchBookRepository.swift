import Foundation

class RemoteFetchBookRepository: BookRepository {
  
    private let bookApi: BookApi
    private let source: BookRepository
    private var hasAlreadyFetch = false
    
    init(source: BookRepository, bookApi: BookApi) {
        self.bookApi = bookApi
        self.source = source
    }
    
    func putAll(_ books: [Book]) {
        source.putAll(books)
    }
    
    func findBy(isbn: String) -> Book? {
        fetchFromRemoteIfNeeded()
        return source.findBy(isbn: isbn)
    }
    
    func findAll(_ ids: [String]) -> [Book] {
        fetchFromRemoteIfNeeded()
        return source.findAll(ids)
    }
    
    func findByGenre(name: String) -> [Book] {
        fetchFromRemoteIfNeeded()
        return source.findByGenre(name: name)
    }
    
    func findAllBestSeller() -> [Book] {
        fetchFromRemoteIfNeeded()
        return source.findAllBestSeller()
    }
    
    // Needs circuitBreaker, retry, should be one endpoint
    fileprivate func getRemoteBooks() {
        do{
            let books = try self.bookApi.getAll().get()
            let bestSellerIds = try bookApi.getBestSellers().get()
            var inMemoryBooks = [Book]()
            for var book in books {
                if bestSellerIds.contains(book.isbn){
                    book.isBestSeller(true)
                }
                inMemoryBooks.append(book)
            }
            source.putAll(inMemoryBooks)
            self.hasAlreadyFetch = true
            
        }catch{
            print("Error trying to get all books")
        }
    }
    
    fileprivate func fetchFromRemoteIfNeeded() {
        if (!hasAlreadyFetch) {
            getRemoteBooks()
        }
    }
}
