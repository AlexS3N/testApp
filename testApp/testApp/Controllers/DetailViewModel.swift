
import Foundation
import UIKit

class DetailViewModel {
    
    var book: Book
    var bookRating: BookRating?
    
    var bookImageView = Bindable<UIImage?>(nil)
    var bookTitle = Bindable<String?>(nil)
    var bookDescription = Bindable<String?>(nil)
    var bookFirstPublication = Bindable<String?>(nil)
    var bookRatings = Bindable<String?>(nil)
    
    init(book: Book) {
        self.book = book
    }
    
    func fetchBookRating(starView: StarRatingView) {
        guard let partURL = book.works?.first?.key?.substring(from: 7) else { return }

        APIManager.shared.fetchRatings(url: partURL) { [weak self] rating in
            let bookRating = rating?.summary?.average
            DispatchQueue.main.async {
                starView.rating = Float(bookRating ?? 1.0)
                self?.bookRatings.value = bookRating != nil ? String(format: "%.1f", bookRating!) : "This book hasn't rating yet."
            }
        }
    }
    
    func fetchBookImage() {
        APIManager.shared.fetchImage(book, sizeImage: .medium) { image in
            self.bookImageView.value = image
        }
    }
    
    //Fix name this method
    func setupUI() {
        bookTitle.value = book.title
        if let description = book.description {
            let simple = description.simpleValue
            bookDescription.value = simple != nil ? description.simpleValue : description.value
        } else {
            bookDescription.value = "The book doesn't contain a description."
        }
        let publishDate = book.publish_date
        bookFirstPublication.value = (book.publish_date != nil) ? publishDate : "Publication date unknown"
    }
    
    
    
}

