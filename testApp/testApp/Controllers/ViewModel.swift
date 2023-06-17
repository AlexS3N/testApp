
import Foundation

class ViewModel {
    
    var bookArray : [Book]? = nil
    private var cellsArray = [MyTableCellViewModel]()
    
    func fetchData(completion: @escaping () -> ()) {
        APIManager.shared.fetchData { books in
            self.bookArray = books
            books?.forEach({ book in
                self.cellsArray.append(MyTableCellViewModel(book))
            })
            completion()
        }
    }
    
    func cellViewModel(index: Int) -> MyTableCellViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }
    
    func numbersOfRows() -> Int {
        bookArray?.count ?? 2
    }
    
}
