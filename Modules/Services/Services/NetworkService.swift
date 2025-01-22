import Foundation

public protocol NetworkServiceProtocol {
    func execute<Response: Decodable>(with url: URL, completion: @escaping (Response) -> Void)
    func execute<Response: Decodable>(with request: URLRequest, completion: @escaping (Response) -> Void)
}

public class NetworkService: NetworkServiceProtocol {
    public init() {}
    
    public func execute<Response: Decodable>(with url: URL, completion: @escaping (Response) -> Void) {
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            decode(data, completion: completion)
        }
    }
    
    public func execute<Response: Decodable>(with request: URLRequest, completion: @escaping (Response) -> Void) {
        Task {
            let (data, _) = try await URLSession.shared.data(for: request)
            decode(data, completion: completion)
        }
    }
    
    private func decode<Response: Decodable>(_ data: Data, completion: (Response) -> Void) {
        completion(try! JSONDecoder().decode(Response.self, from: data))
    }
}
