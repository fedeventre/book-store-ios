
import Foundation
import XCTest
@testable import book_store_ios


class BookServiceTest: XCTestCase {
    var bookService: BookService?
    var bookSection: ArrayOfSections?
    
    override func setUp() {
        bookService = nil
        bookSection = nil
    }
    
    func givenBookService(){
        let bookRepositoryMock = BookRepositoryMock()
        var books = [Book]()
        books.append(contentsOf: getBestSellersBook())
        books.append(contentsOf: getHistoryBook())
        books.append(contentsOf: getScienceBook())
        books.append(contentsOf: getBusinessBook())
        bookRepositoryMock.putAll(books)
        self.bookService = BookService(repository: bookRepositoryMock)
    }
    
    func getBestSellersBook() -> [Book]{
        let bookA = Book(isbn: "124", image: "iamge", title: "Titulo", author: "Juan Perez", genre: "Art", description: "Historia argentina", isBestSeller: true)
        let bookB = Book(isbn: "1243", image: "iamge", title: "Titulo B", author: "Juan Perez", genre: "Ficcion", description: "Historia Mexicana", isBestSeller: true)
        
        return [bookA,bookB]
    }
    func getHistoryBook() -> [Book]{
        let bookA = Book(isbn: "11", image: "iamge", title: "Titulo", author: "Juan Perez", genre: "History", description: "Historia argentina", isBestSeller: false)
        let bookB = Book(isbn: "22", image: "iamge", title: "Titulo B", author: "Juan Perez", genre: "History", description: "Historia Mexicana", isBestSeller: false)
        
        return [bookA,bookB]
    }
    
    func getScienceBook() -> [Book]{
        let bookA = Book(isbn: "11", image: "iamge", title: "Titulo", author: "Juan Perez", genre: "Science", description: "Historia argentina", isBestSeller: false)
        let bookB = Book(isbn: "22", image: "iamge", title: "Titulo B", author: "Juan Perez", genre: "Science", description: "Historia Mexicana", isBestSeller: false)
        
        return [bookA,bookB]
    }
    func getBusinessBook() -> [Book]{
        let bookA = Book(isbn: "11", image: "iamge", title: "Titulo", author: "Juan Perez", genre: "Business", description: "Historia argentina", isBestSeller: false)
        let bookB = Book(isbn: "22", image: "iamge", title: "Titulo B", author: "Juan Perez", genre: "Business", description: "Historia Mexicana", isBestSeller: false)
        
        return [bookA,bookB]
    }
    
    func whenRequestAllBooksBySections() {
        self.bookSection = try! self.bookService?.allBooksBySection().get()
    }
    
    func thenFirstSectionIsBestSeller(){
        let firstSection = self.bookSection?.getSectionAtIndex(0)
        XCTAssertNotNil(firstSection)
        XCTAssertEqual("Best Seller", firstSection?.name)
        XCTAssertEqual(2, firstSection?.books.count)
    }
    
    func thenSecondSectionsIsHistoryBooks(){
        let secondSection = self.bookSection?.getSectionAtIndex(1)
        XCTAssertNotNil(secondSection)
        XCTAssertEqual("History", secondSection?.name)
        XCTAssertEqual(2, secondSection?.books.count)
    }
    
    func thenThirdSectionsIsScienceBooks(){
        let thirdSection = self.bookSection?.getSectionAtIndex(2)
        XCTAssertNotNil(thirdSection)
        XCTAssertEqual("Science", thirdSection?.name)
        XCTAssertEqual(2, thirdSection?.books.count)
    }
    
    func thenFourthSectionsIsBusinessBooks(){
        let fourthSection = self.bookSection?.getSectionAtIndex(3)
        XCTAssertNotNil(fourthSection)
        XCTAssertEqual("Business", fourthSection?.name)
        XCTAssertEqual(2, fourthSection?.books.count)
    }
    
    func testCheckBestSellerSection(){
        givenBookService()
        whenRequestAllBooksBySections()
        thenFirstSectionIsBestSeller()
    }
    
    func testCheckHistorySection(){
        givenBookService()
        whenRequestAllBooksBySections()
        thenSecondSectionsIsHistoryBooks()
    }
    
    func testCheckScienceSection(){
        givenBookService()
        whenRequestAllBooksBySections()
        thenSecondSectionsIsHistoryBooks()
    }
    func testCheckBusinessSection(){
        givenBookService()
        whenRequestAllBooksBySections()
        thenFourthSectionsIsBusinessBooks()
    }
}
