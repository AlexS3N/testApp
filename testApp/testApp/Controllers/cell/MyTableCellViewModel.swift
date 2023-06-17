
import UIKit

class MyTableCellViewModel {
    
    var coverImageView: UIImage? = nil {
        didSet {
            self.reloadTableView?()
        }
    }
    var title: String
    var publication: String
    var reloadTableView: (() -> ())?
        
    required init(_ book: Book) {
        self.title = book.title ?? "TITLE"
        let publishDate = book.publish_date
        publication = (book.publish_date != nil) ? publishDate! : "Publication date unknown"
        getImage(book)
    }
    
    func getImage(_ book: Book) {
        APIManager.shared.fetchImage(book, sizeImage: .small) { [weak self] image in
            self?.coverImageView = image ?? UIImage(named: "question")!
        }
    }
}


