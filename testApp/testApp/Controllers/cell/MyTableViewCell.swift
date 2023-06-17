
import UIKit
import Kingfisher

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var coverImageView: UIImageView!
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var publication: UILabel!
    
    weak var viewModel: MyTableCellViewModel? {
        didSet {
            coverImageView.image = viewModel?.coverImageView
            title.text = viewModel?.title
            publication.text = viewModel?.publication
        }
    }
}


