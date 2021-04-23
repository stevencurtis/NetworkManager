# NetworkLibrary

A simple tested network library.

## Installation
This library supports Swift Package Manager ([installation guide](https://stevenpcurtis.medium.com/use-swift-package-manager-to-add-dependencies-b605f91a4990b605f91a4990?sk=adfd10c7d96557b37ba6ea0443145eb4)).

## Functionality
- Get
- Post
- Patch
- Put
- Delete

To use the network manager you must `import NetworkLibrary` at the top of the relevant class.

This provides an `AnyNetworkManager` that can be stored in a property

```swift
private var anyNetworkManager: AnyNetworkManager<URLSession>
```

which may be passed through an initializer

```swift
init<T: NetworkManagerProtocol>(networkManager: T) {
    self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
}
```

The network manager can then be called with something like the following (if you have previously declared some body data and a URL)

```swift
anyNetworkManager.fetch(url: url, method: .post(body: data), completionBlock: {[weak self] res in
    // process Result<Data, Error> type
}
)
```

The network manager itself can be instantiated by using NetworkManager itself with something like: `NetworkManager(session: URLSession.shared)`.

Even better we can use mutliple initializers to instantiate `AnyNetworkManager<URLSession>?`. This can be implemented with a class like the following:

```swift
final class ApiService {
    private var anyNetworkManager: AnyNetworkManager<URLSession>?

    init() {
        self.anyNetworkManager = AnyNetworkManager()
    }

    init<T: NetworkManagerProtocol>(
        networkManager: T
    ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
    }
}
```

## Guide
[There is an accompanying guide on Medium](https://stevenpcurtis.medium.com/write-a-network-layer-in-swift-388fbb5d9497)
