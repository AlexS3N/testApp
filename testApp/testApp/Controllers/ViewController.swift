
import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.myTableView.reloadData()
                self.myTableView.isHidden = false
                self.spinner.stopAnimating()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailViewController,
              let bookArray = viewModel.bookArray else { return }
        if let indexPath = myTableView.indexPathForSelectedRow {
            destinationVC.viewModel.book = bookArray[indexPath.row]
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numbersOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = self.viewModel.cellViewModel(index: indexPath.row)
        cell.viewModel?.reloadTableView = {
            self.myTableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailViewController", sender: self)
    }
}
