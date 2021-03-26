import Alamofire
import Foundation
import SwiftRepository
import RemoteStoreAlamofire

open class RemoteStoreCodable<Item: Decodable>: RemoteStoreAlamofire, RemoteStoreObjects {
    
    public func send(request: RequestProvider,
                     keyPath: String? = nil,
                     responseObject: @escaping (Result<Item, Error>) -> Void)
    {
        do {
            try send(request).responseDecodable(decoder: KeyPathDecoder(keyPath)) { (response: AFDataResponse<Item>) -> Void in
                responseObject(self.handler.handle(response))
            }
        } catch {
            responseObject(.failure(error))
        }
    }
    
    public func send(request: RequestProvider,
                     keyPath: String? = nil,
                     responseArray: @escaping (Result<[Item], Error>) -> Void)
    {
        do {
            try send(request).responseDecodable(decoder: KeyPathDecoder(keyPath)) { (response: AFDataResponse<[Item]>) -> Void in
                responseArray(self.handler.handle(response))
            }
        } catch {
            responseArray(.failure(error))
        }
    }
}
