import Foundation

class BookStoreInstanceProvider {
    
    private static let inMemRepository = provideInMemoryRepository()
    private static let fetchRemoteRepository = provideRemoteFetchBookRepository()
    
    static func getAllBookBySection() -> GetAllBooksBySection {
        return GetAllBooksBySection(bookService: provideBookService())
    }
    
    private static func provideInMemoryRepository() -> InMemoryRepository {
        return InMemoryRepository()
    }
    
    private static func provideRemoteFetchBookRepository() -> BookRepository {
        return RemoteFetchBookRepository(source: inMemRepository, bookApi: provideBookApi())
    }
    
    private static func provideBookApi() -> BookApi {
        return URLSessionBookApi(urlSession: URLSession.shared)
    }
    
    private static func provideBookService() -> BookService {
        return BookService(repository: fetchRemoteRepository)
    }
}
