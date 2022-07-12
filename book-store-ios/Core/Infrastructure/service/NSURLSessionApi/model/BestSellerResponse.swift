
import Foundation

struct BestSellerResponse: Decodable {
    let results: BestSellerId
    
    func toModel() -> [String] {
        return self.results.best_sellers
    }
}

struct BestSellerId: Decodable {
    let best_sellers: [String]
}



