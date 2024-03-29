---
title: Paginated API requests using Functional Reactive in Swift
description: "Reactive is magic, transform your API responses into streams of data and you'll se how easy is to build for example paginated API requests"
tags: [reactive, objective-c, swift, reactive cocoa]
---

I’ve been playing the days with Reactive Cocoa. I fell in love with that programming paradigm. I had heard about it before but hadn’t stopped to play a little bit with it.
Although it might be scary at first, and most of the concepts are difficult to understand when you first take a look at them. The more you get familiarized with it the more you think in term of streams.

In order to practice a little bit with reactive programming I implemented an API client offering a public reactive interface. That client has methods that instead of using blocks to notify the completion of the API request, return a signal which is executed when someone subscribes to that signal. That API client pointed to an API that offered paginated responses, i.e. having execute different requests to get all the resources if the results number is higher than the page limit.

Taking advantange of the reactive approach of the client I implemented that paginated method and made it resusable for any client independent from the http framework you are using. Let's see how I did it:

```language-swift
typealias PaginatedRequest = (page: Int, pageLimit: Int) -> RACSignal

internal func rac_paginatedSignal(initialPage: Int, pageLimit: Int, requestSignal: PaginatedRequest) -> RACSignal {
    var currentPage = initialPage
    let nextSignal = { () -> RACSignal in
        let signal = requestSignal(page: currentPage, pageLimit: pageLimit)
        currentPage = currentPage + 1
        return signal
    }
    var subscribeNext: ((RACSubscriber!) -> Void)?
    subscribeNext = { (s: RACSubscriber!) -> Void in
        nextSignal().subscribeNext({ (response) -> Void in
            if let items = response as? [AnyObject] {
                for item in items {
                   s.sendNext(item)
                }
                if items.count == pageLimit {
                    subscribeNext!(s)
                }
            }
            else {
                s.sendError(NSError(domain: "invalid.response", code: -1, userInfo: nil))
            }
        }, error: { (error) -> Void in
            s.sendError(error)
        }, completed: { () -> Void in
            s.sendCompleted()
        })
    }
    return RACSignal.createSignal({ (subscriber) -> RACDisposable! in
        subscribeNext!(subscriber)
        return nil
    })
}
```

## Breaking down

- **PaginatedRequest**: We define that typealias which represents a function that takes the page number and the page limit and returns the signal. If someone subscribes to that signal it'll execute the request and return the results or an error.

```language-swift
typealias PaginatedRequest = (page: Int, pageLimit: Int) -> RACSignal
```

- **Paginated request signal generator**: The paginated signal generator takes three parameters, the **initialPage**, the **pageLimit** and the **PaginatedRequest** and returns the signal. That signal encapsulates the iteration through all the pages and send the collection results as stream items.

- **Next signal generator**: That closure is the responsible to return the signal associated to the next page. The function context has a variable to keep a reference of the current page and every time this method is called, that counter is increased by 1. It uses the _PaginatedRequest_ closure.

```language-swift
var currentPage = initialPage
let nextSignal = { () -> RACSignal in
    let signal = requestSignal(page: currentPage, pageLimit: pageLimit)
    currentPage = currentPage + 1
    return signal
}
```

- **Subscribe next**: The approach uses recursive subscribing to the next signal and passing the subscriber through. Subscribe next closure takes the source subscriber and depending on the next signal results it:
  - _Closes_ the stream: Sending a completion or a failure message
  - _Sends_ the results through the stream
  - Subscribes to the _next signal_ when the results count is equal to the page limit

```language-swift
var subscribeNext: ((RACSubscriber!) -> Void)?
subscribeNext = { (s: RACSubscriber!) -> Void in
    nextSignal().subscribeNext({ (response) -> Void in
        if let items = response as? [AnyObject] {
            for item in items {
               s.sendNext(item)
            }
            if items.count == pageLimit {
                subscribeNext!(s)
            }
        }
        else {
            s.sendError(NSError(domain: "invalid.response", code: -1, userInfo: nil))
        }
    }, error: { (error) -> Void in
        s.sendError(error)
    }, completed: { () -> Void in
        s.sendCompleted()
    })
}
```

- **Entry signal**: That's the source signal which fires the recursive subscribing. That just calls _subscribeNext_ passing the subscriber.

```language-swift
RACSignal.createSignal({ (subscriber) -> RACDisposable! in
  subscribeNext!(subscriber)
  return nil
})
```

## Important notes

- Collection results are **sent one by one** through the stream. Thanks to that you can update your collection as the items are being sent. In case you having all these results in an Array you can use the method `toArray()` of RACSignals. Be careful with that method because it blocks the thread execution until the stream is completed with either a completion or a failure message.
- If **any page fails** the recursive algorighm stops and it sends an error message to the subscriber. The remaining pages won't be fetched

> ReactiveCocoa is very useful when you're dealing with asynchronnous events because you can manipulate and combine them easily as you're receiving them. In that case we have different streams that we combine in a single stream we're we're receiving the collection items.

If you want to use Reactive programming in your projects and don't know how, or you wanna talk about anything related with that, drop me a line, [pedropb@hey.com](mailto://pedropb@hey.com)
