import Foundation
import ZXFoundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

public struct Photo {
    
    var id: Int16
    var albumId: Int16
    var title: String
    var url: URL
    var thumbnailUrl: URL
}

extension Photo {
    
    init(with json: [String: Any]?) throws {
        
        guard let id         = json?["id"] as? Int,
            let albumId      = json?["albumId"] as? Int,
            let title        = json?["title"] as? String,
            let url          = URL(string: json?["url"] as? String ?? ""),
            let thumbnailUrl = URL(string: json?["thumbnailUrl"] as? String ?? "")
            else { throw NetworkError.parse }
        
        self.id           = Int16(id)
        self.albumId      = Int16(albumId)
        self.title        = title
        self.url          = url
        self.thumbnailUrl = thumbnailUrl
    }
}

extension Photo {
    
    static func single(by id: Int16, with baseUrl: URL) throws -> Endpoint<Photo> {
        
        guard let url = URL(string: "photos/\(id)", relativeTo: baseUrl) else {
            throw NetworkError.url
        }
        
        return Endpoint(url: url, parse: { json in
            
            do { return .success(try Photo(with: json as? [String: Any])) }
            catch let error { return .failure(error) }
        })
    }
}

let networker = Networker()
let baseUrl = URL(string: "https://jsonplaceholder.typicode.com")!

do {
    
    let endpoint = try Photo.single(by: 5, with: baseUrl)
    
    networker.load(endpoint) { result in
     
        guard let photo = result.value else { print("Something went wrong!"); return }
        print(photo)
    }
    
} catch {}
