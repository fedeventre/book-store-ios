import Foundation

internal struct BookService {
        
    let repository: BookRepository
    
    public func allBooksBySection() -> Result<ArrayOfSections, Error> {
        return .success(homeSection())
    }
    
    private func homeSection() -> ArrayOfSections {
        return ArrayOfSections(sections:[
            bestSellerSection(),
            historySection(),
            sciencieSection(),
            businessSection()
        ])
    }
    
    private func bestSellerSection() -> Section {
        let bestSellerBooks = repository.findAllBestSeller()
        return Section(name: "Best Seller",
                       position: 0,
                       books: bestSellerBooks)
    }
    
    private func historySection() -> Section {
        let historyBooks = repository.findByGenre(name: "History")
        return Section(name: "History",
                       position: 1,
                       books: historyBooks)
    }
    
    private func sciencieSection() -> Section {
        let scienceBooks = repository.findByGenre(name: "Science")
        return Section(name: "Science",
                       position: 2,
                       books: scienceBooks)
    }
    
    private func businessSection() -> Section {
        let businessBooks = repository.findByGenre(name: "Business")
        return Section(name: "Business",
                       position: 3,
                       books: businessBooks)
    }
    
}
