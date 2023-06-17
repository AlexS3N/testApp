
import Foundation

class Book {
    var key: String? = nil
    var title: String? = nil
    var publish_date: String? = nil
    var covers: [Int]? = nil
    var description: Description? = nil
    var works: [Works]? = nil
}

class Description {
    //1st case
    var simpleValue: String? = nil
    //2nd case
    var value: String? = nil
}

class Works {
    var key: String? = nil
}

class BookRating: Codable {
    let summary: Rating?
}

class Rating: Codable {
    let average: Double?
}
