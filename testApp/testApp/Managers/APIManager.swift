
import Foundation
import Kingfisher
import UIKit

class APIManager {
    
    static let shared = APIManager()
    private init(){}
    
    func fetchData(completion: @escaping ([Book]?)->()) {
        guard let url = URL(string: "https://openlibrary.org/query.json?type=/type/edition&authors=/authors/OL23919A&title=&publish_date=&covers=&description=&works=") else {
            return
        }

        var bookArray = [Book]()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil,
               let data = data {
                do {
                    let jsonSerialization = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)

                    if let json = jsonSerialization as? [[String: Any]] {
                        for item in json {
                            let newBook = Book()
                            let newDescription = Description()
                            let newWorks = Works()
                            
                            guard let works = item["works"] as? [[String: Any]] else { return }
                            for key in works {
                                if let key = key["key"] as? String {
                                    newWorks.key = key
                                    newBook.works = [newWorks]
                                }
                            }
                            if let title = item["title"] as? String {
                                newBook.title = title
                            }
                            if let publish = item["publish_date"] as? String {
                                newBook.publish_date = publish
                            }
                            if let cover = item["covers"] as? [Int] {
                                newBook.covers = cover
                            }
                            if let key = item["key"] as? String {
                                newBook.key = key
                            }
                            if let description = item["description"] as? String {
                                newDescription.simpleValue = description
                                newBook.description = newDescription
                            }
                            if let descriptionOdd = item["description"] as? [String: Any] {
                                if let value = descriptionOdd["value"] as? String {
                                    newDescription.value = value
                                    newBook.description = newDescription
                                }
                            }
                            bookArray.append(newBook)
                        }
                    }
                    completion(bookArray)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func fetchRatings(url: String, completion: @escaping (BookRating?)->()) {
        guard let url = URL(string: "https://openlibrary.org/works/\(url)/ratings.json") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil,
               let data = data {
                do {
                    let rating = try JSONDecoder().decode(BookRating.self, from: data)
                    completion(rating)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func fetchImage(_ book: Book, sizeImage: ImageSize, completion: @escaping (UIImage?) -> ()) {
        guard let partURL = book.key?.substring(from: 7) else { return }
        guard let url = URL(string: "https://covers.openlibrary.org/b/olid/\(partURL)-\(sizeImage.rawValue).jpg") else { return }
        if book.covers != nil {
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let value):
                    completion(value.image)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            completion(UIImage(named: "question"))
        }
    }
}

