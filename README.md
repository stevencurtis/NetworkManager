# NetworkLibrary

A simple tested network library.

This provides an `AnyNetworkManager` that can be stored in a property

`private var networkManager: AnyNetworkManager<URLSession>?`

which can then be called with something like the following

```swift
self.networkManager?.get(url: , completionBlock: )
```
