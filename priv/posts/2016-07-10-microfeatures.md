---
title: 'Micro Features Architecture for iOS'
description: 'Organize your app in small features that you '
tags: [xcode, ios swift, objective-c, testing, appcode]
---

When teams grow, maintaining large codebases can be a big pain in the ass. You end up having a lot of conflicts because when a feature is built up, it relies on horizontal layers and across teams that are shared with other features. One example for an horizontal layer could be the database.

> Have you ever seen yourself in a situation where one of your colleagues modified that layer and bugs came out from other features?

Companies such as [Facebook](https://www.facebook.com), [Uber](https://uber.com) or [Spotify](https://www.spotify.com) have their projects organised in small projects that are linked together, maintained by different teams that are responsible of their development, versioning, documentation, testing… Unless the architecture of your project is as atomic as your teams, you’ll end up with more conflicts that you had initially since these teams will end up depending on other teams progress. As there isn’t a lot of information about how these companies are managing it I started thinking about it, and what these atomic features would look like answering questions such as _how would the navigation to these features be?, who’d inject the dependencies between features?, would it be possible to share wrappers across these features?…_

The problem is sort of similar to what happened in backend services. Code bases written with frameworks such as [Ruby and Rails](http://rubyonrails.org/), or [Django](https://www.djangoproject.com/) didn’t scale as teams became bigger. They wound up moving into something you might have probably heard about, _”Microservices”_ _(Martin Fowler writes about it [**here**](http://martinfowler.com/articles/microservices.html))_. In that architecture, backend infrastructures are organised in multiple microservices responsible of different areas, for example, one microservice just for the payments, another one for users, one for the search feature… They discover each other and interact between them, _for example, if the payments microservice needs to fetch something about the user whose information is provided by another microservice, it will use that microservice instead to fetch that information_. These backend microservices are completely atomic, they can use any programming language, internal architecture, dependencies… The only requirement for these atomic microservices is that they provide an accessible interface that other services can consume through network.

Since they tackled the same problems in backend services I started thinking about how the same ideas would apply to an environment other than servers, iOS.

> Would it be possible to build atomic features that could be hooked up within the app?

It is a big challenge, but what if we could? Features as packages, that implement their own views, models, programming language, business logic... They’d offer a _linkable_ interface and the app responsibility would be just hooking all of them and injecting the dependencies as needed.

On this post, I'll go through some basic definitions and ideas that I came up with about this architectural challenge, establishing analogies with microservices for server environments.

# Framework

![framework](/images/posts/microfeatures-framework.png)

Features should be atomic, thus, contained in themselves. They should have clearly defined responsibilities and boundaries. In microservices we have instances running on servers, either Ruby on Rails projects, Scala… where the boundaries are defined by the network layer. But what about mobile? **frameworks**. Frameworks are a way to encapsulate your source code, deciding which elements should be accessible, and in essence, defining the interface of your feature in code.

Frameworks should **speak** the same public language. As we can code on _Swift/Objective-C/Objective-C++/React Native_ for iOS we have to ensure that no matter which language they use internally, there’s a contract for the public language. Otherwise the connection between them would be impossible.

It doesn’t necessarily mean every feature has to be one framework. In most of cases it’ll be but it can also be more than one. For example, a _Player_ feature, could be 2 frameworks, a _PlayerCore_ with everything that has to be with the interaction with [`AVPlayer`](https://developer.apple.com/library/ios/documentation/AVFoundation/Reference/AVPlayer_Class/index.html) and a `PlayerUI` offers the _View/ViewController_ that uses the _PlayerCore_ underneath.

If you want to know more about frameworks, I’ve written about them before, but there are also good articles out there where they explain what a framework is in essence, what’s the difference between framework and a Library, and the difference between Static and Dynamic ones. Here you have a list of good references to check out:

- [Static and Dynamic libraries](https://pewpewthespells.com/blog/static_and_dynamic_libraries.html)
- [How to create a framework for iOS](https://www.raywenderlich.com/65964/create-a-framework-for-ios)
- [Working with a Static Library/framework vs Embedded framework](https://hacking-ios.cocoagarage.com/working-with-a-static-library-framework-vs-embedded-framework-9ca7cd77b4f9#.pm3yebkk7)

### Data Source framework

As I pointed out, frameworks should be atomic. However some will access resources that are shared with other frameworks. Just to mention some, the disk space through [`NSFileManager`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSFileManager_Class/index.html) or the user preferences via [`NSUserDefaults`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSUserDefaults_Class/)… We should try the access to be also atomic. _How?_, organise the resource atomically, providing subspaces in those resources that you access from all your feature frameworks. As an example we could have different databases in different folders inside a `Databases` root folder:

```language-bash
Databases/
  Player/
  Database.sqlite
  Stream/
  Database.sqlite
```

Since frameworks shouldn’t know about where others are saving their data, you might have conflicts accessing/writing that shared resource. You could end up with a non consistent resource structure where each feature has taken its own _”portion”_ of the pizza and used it. **How can we prevent it? Providing access frameworks for these resources**

Providing wrappers for accessing these resources, you ensure the consistency when organising the shared resources. A _CoreDataframework_ for example, could guarantee that the structure is the one shown above. Or a _Keychainframework_ that guarantees a proper access to the Keychain from multiple frameworks.

> These wrappers should never be tied to use cases. If we think about CoreData, they shouldn’t provide a data model. This one should be defined and provided externally from the framework using the wrapper.

Some examples of these frameworks could be:

- CoreData framework
- Network framework
- Keychain framework
- FileManager framework

These frameworks are also useful to avoid the boilerplate setup code that some persistence solutions require, for example CoreData.

![Shared microfeatures](/images/posts/microfeatures-shared.png)

### Backend framework

A **backend** framework is a framework that doesn't provide an UI interface. In most of cases they'll fetch data from somewhere, apply some business logic and return data back to be consumed. In some other cases they might be input only frameworks, for example, we could have a framework that is responsible for downloading images and persisting them in the disk. The API of that framework would look like this:

```language-swift
// Image Caching framework
class ImageCaching {
  func isCached(url: String) -> Bool
  func fetchCaching(url: String) throws -> UIImage?
}
```

### UI framework

A **UI** framework represents a component that your application can navigate to. It could internally include backend components, or have them as a separate framework that would be the backend of your feature. Think about any of your apps, and think about the features users can see. If I take as a example for example SoundCloud, these features would most likely be:

- Search
- Stream
- Player
- UserProfile
- Settings

The example below shows two different setups. The one on the left includes everything in the same framework whereas the one on the right separates the UI layer from the backend one:

![UI microfeatures](/images/posts/microfeatures-ui.png)

UI frameworks must be _navigatable_ _(i.e. the application should be able to navigate to them)_. We can achieve that by just exposing the `ViewController` but there's a more interesting approach that doesn't expose any `UIKit` component but coordinators. Before diving into the idea I'd like to share with you this talk from NSSpain about [Presenting Coordinators](https://vimeo.com/144116310) that introduces the coordinators idea and inspired me to use them for this architecture.

The idea of coordinator is extracting the navigation from `ViewController`s and move it to entities called `Coordinators`. Coordinators are responsible of instantiate your `ViewController`s and setup everything necesary to navigate to the `ViewController`. Coordinators build up a tree that you can navigate through, and the only thing they need to navigate is a navigation context, for example a `ViewController`. They could also set up some information, for example a track identifier. The example below shows how these components would work in practice.

```language-swift
// Player.swift
class Player {
  let storage: Storage
}

// Player+API
extension Player {
  func createQueue(tracks: [PlayerTrack]) -> String
}

// Player+Coordinators.swift
extension Player {
  func coordinator(fromViewController viewController: UIViewController, queueId: String) -> Coordinator
}

```

Then let's say we launch the player from the search results _(Search framework)_:

```language-swift
// Search.swift
class Search {
  let player: Player
  let storage: Storage

  init(player: Player) {
    self.player = player
    self.storage = Storage(model: "Player")
    self.storage.setup()
  }
}

// SearchResultsCoordinator
class SearchResultsCoordinator {
  weak var search: Search?
  weak var viewController: UIViewController?

  func userDidSelectSearchTrack(track: Track) {
    guard let search = self.search, viewController = self.viewController else { return }
    let player = search.player
    let queueId = self.createQueueFromSearchTrack(track)
    let coordinator = player.coordinator(fromViewController: viewController, queueId: queueId)
  }
}

```

### Schema

This is an example of what the architecture would look like in an application such as [SoundCloud](https://soundcloud.com). I haven't drawn the dependencies between them but the frameworks that we'd have in each of these layers. The frameworks will vary depending on your application features but you'll probably need an `API` framework or a `Session` framework that is responsible to provide the user session to those frameworks that need it, for example `API`:

![Microfeatures schema](/images/posts/microfeatures-schema.png)

# Dependencies

Some of the modules that are defined require some setup and an instance to be created. Since the might be expensive we cannot be creating module instances from the other modules, but pass the instance instead _(we inject the module dependency)_. It's exactly the same concept that we use for code but in this case in a higher level and with modules.

> Remember something very important. Your modules should be stateless. Only if needed, instantiate your modules with a setup configuration. And that's all. They should be like a REST APIs, they don't hold any state but send you a representational state of the data that comes from a data source.

Modules must be designed to be _injectable_. **What does it mean?** We have to define a module class that is the entry point of our module. We should then think our module API as a class that we instantiate.

```language-swift
// Offline.swift
class Offline {

  // MARK: - Internal

  internal var storage: Storage


  // MARK: - Init

  public init() {
    self.storage = Storage(modeL: "Offline")
    self.storage.setup()
  }
}
```

Since we have extensions we're not forced to implement the entire API in the same Swift file. We could separate it in multiple files and have everything better organized:

```language-swift
// Offline+API.swift
public extension Offline {
  func isTrackOffline(track: Track) -> Bool
  func downloadTrackIfNeeded(track: Track, completion: (error: NSError?) -> Void)
}
```

# Coupling

Compared to microservices where the communication is performed via network in this case modules know about each other and communicate directly calling the methods from their public APIs. As mentioned earlier it requires some dependencies to be injected that leads to a coupling between these modules. Depending on how we handle that coupling, replacing the framework in the future might be a truly pain in the ass. **How can we prevent it?**

- If framework _A_ depends on framework _B_ that exposes an API, _B_API_. _A_ could define an access protocol for any _B_ framework and could extend _B_API_ to conform that API _(using protocol extensions)_. Since _A_ then depends on the protocol, if the framework is replaced in the future, the new framework API should be extended as we did with _B_ conforming that protocol.
- We could use the [_decorator pattern_](https://en.wikipedia.org/wiki/Decorator_pattern) and decorate the _B_ instance in new instance that exposes another interface. That new instance interface is define and known by _A_ and it'd behave as a _proxy_.

In either cases we might also avoid the coupling with modelss since other frameworks might expose their own models. As we might not be interested in all the exposed properties we can define a simplified version of the models that we'd use from the framework that is depending on another. These models can expose a constructor that takes the model coming from the other framework.

# Versions and dependency graph

The more frameworks you have the more complex the graph becomes. In that regards, keeping a good versioning system is very important, for example [semantic versioning](http://semver.org/). If you are not familiar enough with Semantic Versioning, this is what it states:

- **MAJOR** version when you make incompatible API changes,
- **MINOR** version when you add functionality in a backwards-compatible manner, and
- **PATCH** version when you make backwards-compatible bug fixes.
  Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

Used properly, we notify the modules that rely on our module when we might break the communication with our public API due to important changes.

Since multiple frameworks might depend on another one it's very important, when we bump the major version, for all to be aligned with that version bump. Maybe bump a dependency version number, benefit from the new improvements, but also get a broken module because of the change. Big companies have specialized teams for this, they are responsible of ensuring a good connection between all the frameworks within the app and that all the teams are aware about the state of their dependencies.

# Summing up

Monolithic projects don't scale when used in big or feature teams. The sooner you tackle these conflicts the more straightforward the transition into modules will be.

This is one approach with some ideas, an example of how to do it but this is not the only ones. Think about your app and think about the components that your app has. You could slice it in very small modules or just give your first steps with a few modules. There are great tools out there that help in this regards. Thanks to [CocoaPods](https://cocoapods.org) you can define your modules as pods and integrate them using CocoaPods. Or you can just define your projects in the same Xcode workspace and connect the dependencies manually.

As side advantages of this movement as well as having teams and features atomic, your teams could define their own style guidelines, the private language they use, _Swift, C++, Objective-C++, React Native,..._ As long as they offer a generic interface that everyone can access to, it works. If your company can afford it, a good team organization could include a team that ensures consistency in the contracts between these public interfaces and connection between them.

Are you a big company and you are already doing or trying to move into modules? I'd love to hear about you. At SoundCloud we've already started this transition. And amongst all the benefits, we want to be able to have modularized teams, be able to include features writen in languages such as React Native, and experiment with build tools such as [Buck](https://buckbuild.com/) from [Facebook](https://facebook.com)

# Thanks reviewers

I'd like to thanks people below that helped me reviewing the article:

- [Fran Sevillano](https://github.com/frowing)
- [Gábor Nagy Farkas](https://github.com/gabornagyfarkas)
