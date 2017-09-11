public protocol JSONMappable {
    init(json: JSON) throws
}

public enum ParsingError: Error {
    case InvalidJSON(JSON)
    case NotAJSON
}
