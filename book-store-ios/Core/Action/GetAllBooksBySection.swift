import Foundation

struct GetAllBooksBySection {
    let bookService: BookService
    
    func execute() -> Result<ArrayOfSections, Error> {
        return bookService.allBooksBySection()
    }
}
