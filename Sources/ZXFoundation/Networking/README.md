## Networking

### Table of Contents

* [Endpoint, Networker, and Result](#endpoint-networker-and-result)

-----

### Endpoint, Networker, and Result

At ZX Ventures we use a networking model that simplifies our data flows while providing numerous outlets for testing and mocking data. This model has an idea of `Endpoint`, which contains all the information about the remote resource including parsing the response, and a `Networker` which loads the resource from the network and resolves the `Endpoint` into a `Result`.

This document intends to demonstrate this model. You can also see it in action with a Playground located at `Docs/Playgrounds/Networking.playground` in this project.

#### Essentials:

* [Endpoint](https://github.com/ZXVentures/ZXFoundation/blob/master/Sources/ZXFoundation/Networking/Models/Endpoint.swift)
* [Networker](https://github.com/ZXVentures/ZXFoundation/blob/master/Sources/ZXFoundation/Networking/Networker.swift)
* [Result](https://github.com/ZXVentures/ZXFoundation/blob/master/Sources/ZXFoundation/Result/Result.swift)

#### The Basics

Our networking starts with any Model that has outlets to to initialize the model from some network response. In our apps we assume this response is json.

```swift
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
```

We then provide a representation of the network resource as an `Endpoint` on the model it's associated with.

```swift
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
```

With the  `Endpoint` containing all the network attributes we need we can now use a `Networker` to load the `Endpoint` from the remote resource and handle the resulting `Result` type which wraps a `Photo` upon `.success` and and an `Error` upon `.failure`.

```swift
let networker = Networker()
let baseUrl = URL(string: "https://jsonplaceholder.typicode.com")!

do {
    
    let endpoint = try Photo.single(by: 5, with: baseUrl)
    
    networker.load(endpoint) { result in
     
        guard let photo = result.value else { print("Something went wrong!"); return }
        print(photo)
    }
    
} catch {}
```

#### Notes About Testing

We've often encountered situations where we wanted to test our applications offline or to provide mock data during prototyping. To accomplish this we've provided an outlet for a custom `URLSessionType` on our `Networker` to allow us to inject responses at the network layer of our application. There is also a `MockURLSession` provided in the source of this project that we use for our custom session in testing and mocks.

#### Further Reading

* `Endpoint` borrows heavily from Chris Eidof and Florian Kugler's [Swift Talk](https://talk.objc.io/episodes/S01E01-networking) on networking. I highly recommend watching that and also subscribing to their great service!

