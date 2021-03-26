import Foundation

public class KeyPathDecoder: JSONDecoder {

    let keyPath: String?
    
    public init(_ keyPath: String?) {
        self.keyPath = keyPath
    }
    
    public override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let keyPath = keyPath {
            let toplevel = try JSONSerialization.jsonObject(with: data)
            if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
                let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
                return try decode(type, from: nestedJsonData)
            } else {
                throw DecodingError.dataCorrupted(.init(codingPath: [],
                                                        debugDescription: "Nested json not found for key path \"\(keyPath)\""))
            }
        } else {
            return try super.decode(T.self, from: data)
        }
    }
}
