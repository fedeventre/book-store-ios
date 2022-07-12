
import Foundation
import Combine

protocol HomeViewDelegate: AnyObject {
    func reloadData()
}

class HomeViewModel {
    let getAllBook: GetAllBooksBySection
    weak var viewDelegate: HomeViewDelegate?
    
    var homeSection: ArrayOfSections?
    
    init(getAllBook: GetAllBooksBySection, viewDelegate: HomeViewDelegate?){
        self.getAllBook = getAllBook
        self.viewDelegate = viewDelegate
    }
    
    func reloadView(){
        viewDelegate?.reloadData()
    }
    
    func onViewDisplayed() {
        let _ = fetchBooks().subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink ( receiveCompletion: { completion in
                switch completion {
                case .failure(let error): print("Error \(error)")
                case .finished: print("Publisher is finished")
                }
            },
                    receiveValue: { [weak self] in
                self?.homeSection = $0
                self?.reloadView()
            })
        
    }
    
    func fetchBooks() -> AnyPublisher<ArrayOfSections, Error> {
        return Deferred {
            Future { promise in
                do {
                    promise(.success(try self.getAllBook.execute().get()))
                } catch let error {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}

