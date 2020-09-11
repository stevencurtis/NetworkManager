# NetworkLibrary

A simple tested network library.

This provides an `AnyHTTPManager` that can be stored in a property

`private var httpManager: AnyHTTPManager<URLSession>?`

which can then be called with something like the following

```swift
self.httpManager?.get(url: , completionBlock: )
```