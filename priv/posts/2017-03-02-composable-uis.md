---
title: Composable UIs
description: Build UIs based on reusable components that you can compose in more complex hierarchies.
tags: [swift, components, react, react native, ios, xcode]
---

One important aspect that as developers, we should keep in mind, is trying to reuse the code that we write whenever it's possible. The main reason behind that is saving time. For example, if you write a cell for your app, `TrackCell` and you need the same _(or similar)_ cell in a different collection view, you should try to reuse the one that you already have. However, sometimes the specifications of that cell change a little bit, and we end up with a bunch of properties that are being passed and a lot of if-elses in code updating the layout accordingly. Another approach would be using inheritance, but we'd easily get into a mess, breaking the SOLID principles and spreading the cell logic between the parent and the children. _Have you ever find yourself in that situation?_

Making the matter worse, even if the UI is reusable, the data that feeds the UI comes from a data source that most likely is far from the component. On iOS collection views you'll have a schema similar to the one shown below where a model from the store, is mapped into a plain entity, provided by a data source, that is hooked with the collection view, and passed to the cell by using the collection view presenter.

![An example of a typical collection view presenting data in cells](/images/posts/components-without.png)

If you wanted to reuse any component from that cell you'd be _forced_ to update all components in that hierarchy, **all**. And if you have unit tests for these components, you'd need to update them as well. It doesn't scale well, does it?

Another common issue besides the reusability is the fact that whenever the data changes, we either reload whole collection view, or only the cells that changed. In both cases, we need to do it at the collection view. If your app is very heavy in background operations that might eventually lead to crashes if you don't manage the concurrency properly or performance degradation.

[React](https://facebook.github.io/react/) and React Native have solved this problem nicely. UIs are defined in components, these self-contained components have a lifecycle, and know how to update its state. Moreover, these components can easily be composed in higher hierarchies. The benefit of that components-based approach is that you can easily drag-and-drop these components around. For example, if you come up with a `LikeButton` that you use in a `TrackCell`, you can use the same `LikeButton` in another cell by just inserting it and defining how it should be positioned. Another awesome benefit of using _React_ is that it knows what needs to reload and it only reloads that element in the dom. That's very powerful if you combine it with [Relay](https://facebook.github.io/relay/) and [GraphQL](http://graphql.org/learn/).

> An advantage of using components is that it's easier to **ensure consistency**. The same component is used from different places, and when a change needs to be done, you do it in one place and you get the change in all the places where the component is being used.

Despite you can use _React_ natively with _React Native_, you don't need a framework for that, but just change your mindset when defining app ui-data hierarchies. Companies like [Spotify](https://spotify.com) have come up with a similar approach, the [Hub Framework](https://github.com/spotify/HubFramework), that abstracts you from composition, action handling, and lifecycle management. I like how flexible the framework it but I'm not a big fan of very opinionated frameworks, and Hub Framework is. As soon as you start using it, it influences the architecture of your apps heavily. I recommend you to watch this talk from [John Sundell](https://twitter.com/johnsundell), [Backend-driven UIs](https://www.youtube.com/watch?v=ypk-72mhYBk). It looks magic!

As I pointed out, with a mindset change, you can also have your own component-driven UI, with reusable and composable components:

![An example of UI built with the component-based style](/images/posts/components-with.png)

A component is a **class** that gives you the view and an interface to set up the view. Whoever uses these components shouldn't know anything other than what it needs. Internally the view can use programming patterns like MVP, MVC, MVVM... But these patterns are _invisible_ from the outside.

```language-swift
class LikeComponent {
   typealias TrackId = String
   var view: UIView
   func setup(for: TrackId)
}
```

Components can also respond to **actions**. For example, if you are trying to like a track, that turns into a few background operations to persist the new state into the API and the local store. In case the action response is more complicated and involves some UI, you can delegate de action to the app by using a delegate pattern. As an example, some actions might require a confirmation from the user. That confirmation can be handled from the outside.

Since with this approach, each component brings its state from the data source, so it's important that the access to the data is **fast**. Otherwise, the UI will flicker, and that's terrible for the user experience. One idea to prevent that is having an in-memory data source where the states are indexed, for example using a `Dictionary`. This data source can be filled lazily, fetching the data the first time the data is needed, and ensuring the data keeps synchronized with the store underneath _(Core Data, Realm, serialization into disk..)_

**Compose all the things!**

---

Do you follow a similar approach in your projects? Are you considering moving towards that approach? I'd like to hear about your experience and the problems you found along the way. Reach out to [pedropb@hey.com](mailto://pedropb@hey.com) or leave a comment below.
