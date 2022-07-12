import Foundation

public struct URLSessionBookApi: BookApi {
    
    let urlSession: URLSession
    private static let BASE_PATH = "https://raw.githubusercontent.com/ejgteja/files/main"
    
    private enum TYPE: String {
        case GET = "GET"
        case POST = "POST"
    }
    
    private enum EndPoint: String {
        case ALL = "/books.json"
        case BestSeller = "/best_sellers.json"
    }
    
    enum ApiError: Error {
        case invalidURL(msg: String)
        case invalidResponse(msg: String)
    }
    
    func getAll() -> Result<[Book], Error> {
        let endpoint = "\(URLSessionBookApi.BASE_PATH)\(EndPoint.ALL.rawValue)"
        guard let enpointUrl = URL(string: endpoint) else {
            return .failure(ApiError.invalidURL(msg: "invalidURL"))
        }
        let urlRequest = URLRequest(url: enpointUrl)
        let result = urlSession.sendSynchronousRequest(request: urlRequest)
        guard let data = result.0 else {
            return .failure(ApiError.invalidResponse(msg: result.2.debugDescription))
        }
        let decoder = JSONDecoder()
        do {
            //decouple Decoder && book should implement decodable, we should have an specifc model for apiresponse that later is converted to do domain model
            //
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            print(json)
            let book = try decoder.decode(ResultBookResponse.self, from: jsonData)
            return .success(book.toModel())
        } catch {
            print(error.localizedDescription)
            return .failure(error)
        }
    }
    
    func getBestSellers() -> Result<[String], Error> {
        let endpoint = "\(URLSessionBookApi.BASE_PATH)\(EndPoint.BestSeller.rawValue)"
        guard let enpointUrl = URL(string: endpoint) else {
            return .failure(ApiError.invalidURL(msg: "invalidURL"))
        }
        let urlRequest = URLRequest(url: enpointUrl)
        let result = urlSession.sendSynchronousRequest(request: urlRequest)
        guard let data = result.0 else {
            return .failure(ApiError.invalidResponse(msg: result.2.debugDescription))
        }
        let decoder = JSONDecoder()
        do {
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            let bestSeller = try decoder.decode(BestSellerResponse.self, from: jsonData)
            print(bestSeller)
            return .success(bestSeller.toModel())
        } catch {
            print(error.localizedDescription)
            return .failure(ApiError.invalidResponse(msg: error.localizedDescription))
        }
    }
}

extension URLSession {
    func sendSynchronousRequest(request: URLRequest) -> (Data?, URLResponse?, Error?) {
        let semaphore = DispatchSemaphore(value: 0)
        
        var result: (data: Data?, response: URLResponse?, error: Error?)
        let task = self.dataTask(with: request) {
            result = (data: $0, response: $1, error: $2)
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return result
    }
}
