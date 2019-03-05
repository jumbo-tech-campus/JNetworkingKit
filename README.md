# JNetworkingKit

[![Build Status](https://travis-ci.org/jumbo-tech-campus/JNetworkingKit.svg?branch=master)](https://travis-ci.org/jumbo-tech-campus/JNetworkingKit)

This project contains a generic networking setup for Swift, but can also be called upon from Objective-C using a Gateway.

Keys in this proposal are:

* Only 1 class will execute requests
* Only 1 class will parse requests
* Only 1 class will validate requests
* `RequestExecutor` can be extended easily
* `RequestClient` can be extended easily
* `RequestParser` can be extended easily
* `RequestValidator` can be extended easily

The proposal is build upon:

* Protocol Oriented Programming
* SOLID's separation of concerns

Together they make the code fully testable and can be developed & expanded test-driven.

## Architecture

The architecture has 8 different entities, that are defined at *Application level* (your application) or *Library level* (the library itself).

#### Application level

* **`Environment`**: should contains information about current environment, it is an extension to the library environment struct that contains the environments, in order to access them with the dot notation:

```swift
extension Environment {
    static let develop = Environment(server: "http://192.168.0.1",
                                     path: "test",
                                     version: "v1")

    static let production = Environment(server: "http://www.<YOUR-WEBSITE>.com")
}
```

* **`Gateway`**: is the entry point to the network layer, a unique class the defines the relevant methods to perform a network call. In the demo application, we have created an empty class `Gateway` that can be used from Objective-C and will be extended by any set of requests.
If your application has two set of services (*products* and *user*), you can create 2 extensions to the Gateway:

```swift
protocol ProductsGateway {
    func getProducts(onSuccess: @escaping (Product) -> Void, onError: @escaping (Error) -> Void)
    func getProduct(with id: String, onSuccess: @escaping (Product) -> Void, onError: @escaping (Error) -> Void)
}

extension Gateway: ProductsGateway {
    @objc func getProducts(onSuccess: @escaping (Product) -> Void, onError: @escaping (Error) -> Void) {
        // ...
    }

    @objc func getProduct(with id: String, onSuccess: @escaping (Product) -> Void, onError: @escaping (Error) -> Void) {
        // ...
    }
}
```

```swift
protocol UserGateway {
    func getUser(with id: String, onSuccess: @escaping (User) -> Void,     onError: @escaping (Error) -> Void)
}

extension Gateway: UserGateway {
    @objc func getUser(with id: String, onSuccess: @escaping (User) -> Void, onError: @escaping (Error) -> Void) {
        // ...
    }
}
```

* **`Request`**: contains all the necessary information to perform a network call. A `Request` is the result of an `Environment` and a `Route`

#### Library level

* **`RequestOperation`**: responsible to provide and manage the correct instances of `Request`, `Executor` and `Parser`.
* **`RequestExecutor`**: responsible to perform the request using the correct `Client`. An extended version of the Executor can be used to add more business logic, like caching or the observable pattern.
* **`RequestClient`**: responsible to execute the request. The default `Client` uses the `URLSession` component, but a different `Client` can be created to use different system or libraries (like _Alamofire_).
* **`RequestValidator`**: responsible to perform the validation of the request. The default implementation checks for the response code, but you can validate header or body as well.
* **`RequestParser`**: responsible to parse the response and create the final object.

The library is designed around the `RequestOperation`. It defines its variable using **swift's generics**, in this way a developer can instantiate and use different `RequestExecutor`, `RequestClient` and `RequestParser` instances to add more functionality and capabilities to the Network Layer.


## Dataflow

The usual flow to using this proposal would be:

1. Create an extension for the `Gateway` for the relevant service set. In the demo application, we have created the *MovieGateway* protocol. If the relevant extension already exists, add a proper method for the service you want to use:

```swift
protocol MovieGateway {
    func getMovie(onSuccess: @escaping (Movie) -> Void, onError: @escaping (Error) -> Void)
}

extension Gateway: MovieGateway {
    @objc func getMovie(onSuccess: @escaping (Movie) -> Void, onError: @escaping (Error) -> Void) {
        MovieDetailRequestOperation().execute(onSuccess: onSuccess, onError: onError)
    }
}
```

2. Define the proper `Router` that defines the relevant `Route` for the different services. We suggest to define them in order to have a *the dot notation*.

```swift
struct MovieRouter {
    static var list: RequestRoute {
        let path = "?apikey={apikey}&t={t}"
        let parameters = ["apikey": "<YOUR-OMDB-KEY>", "t": "Matrix"]
        return RequestRoute(path: path, parameters: parameters)
    }
}
```

3. Create a new `RequestOperation` for the service you need to use. The new operation will define the proper parser, executor and request:

```swift
class MovieDetailRequestOperation: NSObject, RequestOperationType {
    typealias Result = Movie

    var executor = RequestExecutor()
    var parser = MovieDetailRequestParser()
    var validator = RequestValidator()
    var request = Request(route: MovieRouter.list)
}
```

4. Call proper method on your `Gateway`:

    * In the `onSuccess` completion block handle the data as necessary
    * In the `onError` completion block handle the error as necessary

```objc
[self.gateway getMovieOnSuccess:^(Movie *movie) {
    NSLog(@"Fetched movie %@", movie.title);

} onError:^(NSError *error) {
    NSLog(@"Error fetching the movie: %@", error.localizedDescription);
}];
```


## Notes

### Objective-C support

All magic is, and will be, written in Swift. We didn't want to limit our self in the creation of the library, that's why the only thing Objective-C needs to be able to interact with is the `Gateway`, created on the app level.

### Try/Catch & error handling

You might have noticed there are a number of `try` and `throw` keywords in there. Correct and complete error handling will be a challenge and there will be `do {} catch {}` closures through the codebase.

For the moment the request to the Gateway can generate a `Error` and we can handle it in the `onError` completion block.


### RequestExecutor

You've probably noticed `RequestExecutor` is currently only a proxy between `RequestOperation` and the `RequestClient` which was chosen. It gives us the freedom to add business logic to the network layer and change the client as per our needs.

A simple example is the `CacheRequestExecutor`: it add a very simple cache system to show how easy is to extend it. It is also a good point to implement an `Observable` pattern.

### RequestParser

The parser can be extended or changes as per our needs with one line of code change, just using a different parser in the `RequestOperation`. To show how easy it is, there is a `HeaderRequestParser` added to the project that can parse the response header in place of response parameters.

## Installation


### Library

```
$ git clone https://github.com/jumbo-tech-campus/JNetworkingKit
$ cd JNetworkingKit/JNetworkingKit
$ open JNetworkingKit.xcworkspace
```

Now you can open the workspace and run the unit tests to check that everything works properly.

### DemoApp

```
$ git clone https://github.com/jumbo-tech-campus/JNetworkingKit
$ cd JNetworkingKit/DemoApp
$ open DemoApp.xcworkspace
```

After you open the workspace, you should replace the **API key** in the `MovieRouter.swift` file. A new key can be created on [OMDb Api](https://www.omdbapi.com/).

Now you can run the demo application. There are 2 screens:

- The first one will load an image and show it on the screen
- The second one will download information about the movie Matrix and display title and plot on the screen

## Future improvement

- Create a `Logger`, which can be used to log information in debug mode.
- Add support for `+` operator on `Request`s, to implement the parent / child concept
- Add Cocoapod support
- Add Carthage support
- Add Swift Package Manager support
