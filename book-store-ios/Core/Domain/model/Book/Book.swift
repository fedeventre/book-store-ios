import Foundation

struct Book: Decodable {
    public let isbn: String
    public let image: String
    public let title: String
    public let author: String
    public let genre: String
    public let description: String
    public var isBestSeller: Bool = false
    
    mutating func isBestSeller(_ bestSeller: Bool){
        self.isBestSeller = bestSeller
    }
}


