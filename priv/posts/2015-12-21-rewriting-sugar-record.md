---
title: 'Rewriting SugarRecord, 2.0'
description: 'I explain in this post how was the process of rewriting SugarRecord, a CoreData/Realm wrapper for Swift.'
tags: [sugarrecord, realm, coredata]
---

[SugarRecord](https://github.com/swiftreactive/sugarrecord) is one of the libraries I'm most proud of. It has currently 1.155 favs and 98 forks on Github and a couple of issues opened. I wrote this library when the first version of Swift was released since I wanted to learn the language and I thought that writing a library could be a great idea for learning.

### SugarRecord 1.x, suffering Swift evolution

Swift changed very fast with every new version, moreover we didn't have [CocoaPods](https://cocoapods.org) support yet so all the integration steps were manual. Realm was still giving its first steps and my knowledge about CoreData was quite limited. I had used [MagicalRecord](https://github.com/magicalpanda/MagicalRecord) and I used it as inspiration to implement the Swift equivalent. The structure was quite similar but taking advantage of Swift features like generics. One of the most difficult things by that time was designing an abstraction layer that could wrap both, [Realm](https://realm.io) and CoreData simultaneously. The interface of Realm was much more fresh than CoreData and I was trying a to achieve a similar approach with SugarRecord.

> The power of CoreData and Realm but with a nice to use interface.

I released the first version of SugarRecord and kept updating and adding new features according to developers requests. However, a few months later I had to left the project because I didn't have enough time to invest, I spent most of my time with my full-time job and I was simultaneously working on another project in my free time. I tweeted if someone could be interested in continuing with the project and make it a great reference in the Swift community. With some help a few versions were launched after I abandoned the project but there was a lack of motivation in the team that handed-over the project and it remained outdated for some months. Developers started forking, solving the bugs on their own repositories, and some amount of issues opened in the repository increased.

### Swift 2.0, time to update

I still had the SugarRecord account active and I saw how people were tweeting about SugarRecord and reporting issues on Github. Swift 2.0 was launched by that time and people were asking for support for that new version. SugarRecord was completely broken in that version and people needed a new version of SugarRecord for their Swift 2.0 projects.

_"I born that project and helped it growing, couldn't leave it abandoned"_ I thought, and then took the decision to start working in SugarRecord 2.0. Here's the tweet I published notifying the developers that the next version was in the oven:

<blockquote class="twitter-tweet" lang="es">
  <p lang="en" dir="ltr">
    We&#39;ve started working on SugarRecord 2.0 with Swift 2.0 compatibility
    and an improved API, stay tuned{" "}
    <a href="https://twitter.com/hashtag/swift2?src=hash">#swift2</a>
  </p>
  &mdash; Sugar Record (@sugar_record) <a href="https://twitter.com/sugar_record/status/635682614012194816">agosto 24, 2015</a>
</blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

I decided not to continue with the same codebase which was strongly inspired in MagicalRecord but starting from the scratch. Take all the good practices, new Swift 2.0 features, and problems that developers reported with the previous version and try to do something better, more robust, safe and actively supported. I started working on it. It was a few months of development since I didn't have much time, but I was able to finish it and publish the first version of SugarRecord 2.0 whose features are listed below:

### Features

- **Carthage & CocoaPods**: With the first version I had to explain developers how to install it manually. All of them were used to use CocoaPods and it was kind of difficult to do it manually _(although it wasn't at all)_. When CocoaPods finally launched its version with support for Dynamic Frameworks _(yes, it's popular `use_frameworks!`)_ I couldn't update because Realm wasn't giving support yet, so had to keep the manual process at least for Realm. With this version 2.0 I could finally give support to CocoaPods, adding the external dependencies like [Realm](https://github.com/realm/realm-cocoa), [ReactiveCocoa](https://github.com/reactivecocoa/reactivecocoa) and [RxSwift](https://github.com/reactivex/rxswift) as pod dependencies of the library. I also added support to the recently popular dependency manager [Carthage](https://github.com/carthage/carthage). Now it's up to you to choose the solution that fits into your project, SugarRecord supports it.

- **Realm inspired**: These months I've been using Realm more and more and I wanted to inspire the SugarRecord interface in Realm. I built a fluent interface for building fetch requests and also operations methods that you can use to perform saving/updating/deleting tasks. Mapping that API with Realm was relatively easy but it was a bit complicated in case of CoreData. I could manage to solve it creating the concept of `Context` and `Storage` that behaves as a proxy class for accessing the database.

- **Reactive interface**: I've also been playing recently with Reactive Programming and I thought it would be a great idea to expose SugarRecord methods as `Observable` entities. Then if you're app is based on Reactive, you can have the same paradigm in your data layer, fetch requests and operations turn into `Observable` entities that are executed once you subscribe to them. I also added **fetch in background** with a fetch method that takes a map function, fetches your entities using a request in background, and return the _thread-safe_ entities to be used from the thread you need _(e.g. Main thread for presenting in UI)_.

- **Storage protocol**: Although SugarRecord offers two predefined storages, `CoreDataDefaultStorage` and `RealmDefaultStorage` you can add your own. The only requirement is that they conform the protocol `Storage`. Although the default storage will be enough for the 90% of the cases, you might need something extra that the default storage doesn't provide. You can extend it and add a non-existing functionality. If you come up with a new storage, propose a PR so that we can include it as a `Storage` of the library.

- **Fully Tested**: I wanted the library to be robust and the best way to ensure that is through unit tests. I ensured that every of the methods provided behaves as expected and that the designed storages don't throw unexpected errors that might cause instability in developers apps. Thanks to [Quick](https://github.com/quick/quick) and [Nimble](https://github.com/quick/nimble) for its great Swift testing and mocking frameworks.

### Things learned with SugarRecord

- **Developers want an example project:** Event if you fill the README with a lot of examples they want to see a project working where you show all the things they can do with your library.
- **Developers don't read**: Use _cursive_, **bold** or quotes. They won't read, they want to install it using `CocoaPods` and start using it. You'll find developers that even don't know anything about CoreData and think that the magic of your library is the only thing they have to learn.
- **Developers prefer requesting instead of proposing**: It's hard to find developers that want to contribute with your library, if they find a bug they will report it, if they need a feature, they'll ask you for it. They want to be _consumers_ of your _product_.

> With SugarRecord it's the first time I see someone creating an issue that starts with **I need an example project......**. It made me feel like a servant.

- **Building a team around an Open Source project is not easy**: It's hard to find developers that want to actively contribute with the project, and if you find them it's difficult to keep them as motivated as you are. I couldn't find people that actively continued the first version of 1.0 and I still haven't found the team for the version 2.0.
- **Developers will ask you for a lot of features, but you decide**: They want to do everything with your library, but you, designer of code, are the responsible to decide if that requested feature is in the scope of your library. _You don't always have to say YES if it doesn't make sense for your library_.
- **Make it easy:** Try to make everything easy, from the _setup_ to the _use_ of your library. If a developer finds your library and thinks it is too complex for him, he/she won't use it.

  - Integrate it with the most popular dependency managers.
  - Design a friendly API. Avoid complexity.
  - If they ask you doubts about how to use your library, your design can be improved.

  <blockquote class="twitter-tweet" lang="es">
    <p lang="en" dir="ltr">
      SugarRecord is listed in the RxSwiftCommunity webpage after our last
      update. <a href="https://t.co/YCNoeQkdb8">https://t.co/YCNoeQkdb8</a>
    </p>
    &mdash; Sugar Record (@sugar_record) <a href="https://twitter.com/sugar_record/status/678665283813441536">diciembre 20, 2015</a>
  </blockquote>
  <script
    async
    src="//platform.twitter.com/widgets.js"
    charset="utf-8"
  ></script>

SugarRecord is [available](https://cocoapods.org/?q=sugarrecord) for your Swift projects. If you don't want to save time setting up your CoreData/Realm stack, you can use it. I'm also looking for contributors that want to contribute with the project, help fixing bugs, adding new features, and definitively making SugarRecord better every day. If you're interested, drop me a line [pedropb@hey.com](mailto://pedropb@hey.com)
