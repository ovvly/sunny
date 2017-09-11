import Foundation
import RxSwift
import RxCocoa

public enum HTTPMethod: String {
    case get, post, put, patch, delete
}

public protocol APIClient {
    func request<A>(_ resource: Resource<A>) -> Observable<A>
}

public final class MainAPIClient {
    public let baseURL: URL
    public let session: URLSession
    
    public init(baseURL: URL, session: URLSession = URLSession.shared) {
        self.baseURL = baseURL
        self.session = session
    }
}

extension MainAPIClient: APIClient {
    public func request<A>(_ resource: Resource<A>) -> Observable<A> {
        let request = buildRequest(for: resource)
        
        return Observable
            .just(request)
            .flatMap (session.rx.data)
            .parseToJSON()
            .map (resource.parse)
    }
    
    private func buildRequest<A>(for resource: Resource<A>) -> URLRequest {
        let requestUrl = buildRequestUrl(withPath: resource.path, parameters: resource.parameters)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = resource.method.rawValue.uppercased()
        
        request.addValue(RequestHeader.Value.JSON, forHTTPHeaderField: RequestHeader.Field.Accept)
        request.addValue(RequestHeader.Value.JSON, forHTTPHeaderField: RequestHeader.Field.ContentType)
        
        if let body = buildBody(resource.body) {
            request.httpBody = body
        }
        
        return request
    }
    
    private func buildRequestUrl(withPath path: String, parameters: QueryParameters?) -> URL {
        let fullPath = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: fullPath, resolvingAgainstBaseURL: false)!
        components.queryItems = parameters?.map(URLQueryItem.init)

        return components.url!
    }
    
    private func buildBody(_ json: JSON?) -> Data? {
        guard let json = json else { return nil }
        return try! JSONSerialization.data(withJSONObject: json, options: [])
    }
}

extension ObservableType where E == Data {
    fileprivate func parseToJSON() -> Observable<JSON> {
        return map { data in
            let object = try? JSONSerialization.jsonObject(with: data, options: [])
            let json = object as? JSON
            return json ?? [:]
        }
    }
}

private struct RequestHeader {
    struct Field {
        static let ContentType = "Content-Type"
        static let Accept = "Accept"
    }
    
    struct Value {
        static let JSON = "application/json"
    }
}
