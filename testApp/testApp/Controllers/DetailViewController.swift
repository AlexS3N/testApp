
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookFirstPublication: UILabel!
    @IBOutlet weak var bookRatings: UILabel!
    @IBOutlet weak var starRatingView: StarRatingView!
    
    let viewModel = DetailViewModel(book: Book())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.fetchBookRating(starView: starRatingView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchBookImage()
        viewModel.setupUI()
    }
    
    private func bind() {
        viewModel.bookImageView.bind { [weak self] image in
            self?.bookImageView.image = image
        }
        viewModel.bookTitle.bind { [weak self] title in
            self?.bookTitle.text = title
        }
        viewModel.bookDescription.bind { [weak self] description in
            self?.bookDescription.text = description
        }
        viewModel.bookFirstPublication.bind { [weak self] publishDate in
            self?.bookFirstPublication.text = publishDate
        }
        viewModel.bookRatings.bind { [weak self] rating in
            self?.bookRatings.text = rating
        }
    }
}
