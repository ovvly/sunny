import Foundation

public typealias Path = String
public typealias QueryParameters = [String: String]
public typealias Headers = [String: String]
public typealias JSON = [String: Any]

public struct Resource<A> {
    public var path: Path
    public var parameters: QueryParameters?
    public var headers: Headers?
    public var body: JSON?
    public var parse: (JSON) throws -> A
    public var method: HTTPMethod
    
    public init(path: Path, parameters: QueryParameters? = nil, method: HTTPMethod = .get, headers: Headers? = nil, body: JSON? = nil, parse: @escaping (JSON) throws -> A) {
        self.path = path
        self.parameters = parameters
        self.headers = headers
        self.body = body
        self.parse = parse
        self.method = method
    }
}

extension Resource where A: JSONMappable {
    public init(path: Path, parameters: QueryParameters? = nil, body: JSON? = nil) {
        self.init(path: path, parameters: parameters, body: body, parse: A.init)
    }
}
