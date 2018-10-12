# JNetworkingKit

This project contains a generic networking setup for Swift, but can also be called upon from Objective-C.

Key in this proposal are:

* Only 1 class will execute requests
* Only 1 class will parse requests
* `RequestExecutor` can be extended easily
* `RequestClient` can be extended easily
* `RequestParser` can be extended easily

The proposal is build upon:

* Protocol Oriented Programming
* SOLID's separation of concerns

Together they make the code fully testable and can be developed & expanded test-driven.

## Architecture

The architecture has 6 different entities, that are defined at *Application level* or *Core level*.

#### App level

* **`Gateway`**: is the entry point to the network layer, a unique class the defines the relevant methods to start a network call quickly. In our implementation, we will call it `MyGateway` and we will create an extension for every service set we have (*products*, *user*, ...)
* **`Request`**: contains all the necessary information perform a network call. A `Request` is the result of the of an `Environment` and a `Route`

#### Core level

* **`RequestOperation`**: responsible to provide and manage the correct instances of `Request`, `Executor` and `Parser`.
* **`RequestExecutor`**: responsible to perform the request using the correct `Client`. An extended version of the Executor can be used to add more business logic, like caching or reactive programming functionality.
* **`RequestClient`**: responsible to execute the request. The default `Client` uses thr `URLSession` component but a different `Client` can be created to use different system or libraries (like _Alamofire_ or similar).
* **`RequestParser`**: responsible to parse the response.

The **Core** is designed around the `RequestOperation`. It defines its variable using **swift's generics**, in this way a developer can instantiate and use different `RequestExecutor`, `RequestClient` and `RequestParser` instances to add more functionality and capabilities to the Network Layer.


## Dataflow

The usual flow to using this proposal would be:

1. Create an extension for the `MyGateway` for the relevant service set, like *Products* or *User*. If the relevant extension already exists, add a proper method for the service you want to use:

	```swift
	// BASE CLASS FOR THE APP
	@objc
	class MyGateway: NSObject {}
	```

	```swift
	// EXTENSION FOR PRODUCT GATEWAY
	@objc
	protocol ProductsGateway {
	    @objc func getProducts(onSuccess: @escaping ([Product]) -> Void, onError: @escaping (Error) -> Void)
	    @objc func getProductDetails(_ product: Product, onSuccess: @escaping (Product) -> Void, onError: @escaping (Error) -> Void)
	}

	extension MyGateway: ProductsGateway {
	    @objc func getProducts(onSuccess: @escaping ([Product]) -> Void, onError: @escaping (Error) -> Void) {
	        ProductListRequestOperation().execute(onSuccess: onSuccess, onError: onError)
	    }

	    @objc func getProductDetails(_ product: Product, onSuccess: @escaping (Product) -> Void, onError: @escaping (Error) -> Void) {
	        ProductDetailsRequestOperation(product: product).execute(onSuccess: onSuccess, onError: onError)
	    }
	}

	```

2. Define the proper `Router` that define the relevant `Route` for the different services. Note that in this example we implemented a variable and a method: this will allow us to ask for a route using *the dot notation*: `ProductsRouter.list` and `ProductsRouter.details(of: product)` are now available.

	```swift
	struct ProductsRouter {
	    static var list = RequestRoute(path: "products/")

	    static func details(of product: Product) -> RequestRoute {
	        return RequestRoute(path: "products/{id}", parameters: ["id": product.identifier])
	    }
	}
	```

3. Create a new `RequestOperation` for the service you need to use, the new operation will define the proper parser, executor and request:

	```swift
	class ProductListRequestOperation: NSObject, RequestOperationType {
	    typealias Result = [Product]

	    var executor = RequestExecutor()
	    var parser = ProductListRequestParser()
	    var request = Request(route: ProductsRouter.list)
	}
	```

4. Call proper method on the `MyGateway`:

	* In the `onSuccess` completion block handle the data as necessary
	* In the `onError` completion block handle the error as necessary

    ```objc
    [self.gateway getProductsOnSuccess:^(NSArray<Product *> *products) {
        NSLog(@"Fetched %ld products", (long)products.count);

    } onError:^(NSError *error) {
        NSLog(@"Error fetching list: %@", error.localizedDescription);
    }];
    ```


## Notes

### Objective-C support

All magic is, and will be, written in Swift. The only thing Objective-C needs to be able to interact with is the `MyGateway`.

### Try/Catch & errror handling
You might have noticed there are a number of `try` and `throw` keywords in there. Correct and complete error handling will be a challenge and there will be `do {} catch {}` closures throughtout the codebase.

I'd recommend us to start using [RxSwift](https://github.com/ReactiveX/RxSwift) to overcome this, but also the need of generic app boilerplate.

For the moment the request to the Gateway can generate a `Error` and we can handle it in the `onError` completion block.


### RequestExecutor

You've probably noticed `RequestExecutor` is currently only a proxy between `RequestOperation` and the `RequestClient` which was chosen. It gives us the freedom to add business logic to the network layer and change the client as per our needs.

A simple example is the `CacheRequestExecutor`: it add a very simple cache system to show how easy is to extend it. It is also a good point to add [RxSwift](https://github.com/ReactiveX/RxSwift) or implement an `Observable` pattern.

### RequestParser

The parser can be extended or changes as per our needs with one line of code change, just using a different parser in the `RequestOperation`. To show how easy it is, there is a `HeaderRequestParser` added to the project that can parse the response header in place of response parameters.

## Installation

```
$ git clone https://github.com/jumbo-tech-campus/JNetworkingKit
$ cd JNetworkingKit
$ open JNetworkingKit.xcworkspace
```


## Future improvement

- Create a `Logger`, which can be used to log information in debug mode.
- Create an `Executor` to implement a reactive or observable pattern.
- Add support for `+` operator on requests, to implement the parent / child concept
- Add Cocoapod support
- Add Carthage support
- Add Swift Package Manager support
