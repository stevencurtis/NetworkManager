# NetworkLibrary

A simple tested network library.

## Supports 
- Get
- Patch
- Put
 - Delete

To use the network manager you must `import NetworkLibrary`.

This provides an `AnyNetworkManager` that can be stored in a property

`private var networkManager: AnyNetworkManager<URLSession>?`

which can then be called with something like the following

```swift
self.networkManager?.get(url: , method: ,completionBlock: )
```
