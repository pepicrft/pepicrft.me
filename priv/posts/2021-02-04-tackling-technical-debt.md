---
title: 'Tackling technical debt in Tuist'
tags: ['engineering', 'open-source', 'tuist', 'xcode', 'swift']
---

I've recently spent a lot of time in [Tuist](https://tuist.io) tackling technical debt. It'd been a while since the last time I have to pause some other work for weeks to do something that would be beneficial for the long-term of the project.

This time the work was replacing models that are very core to Tuist's domain: the graph and all the models associated to it. When I built the first graph structure, I didn't put too much thought into how it should be. I was led by intuition. I added a reference here, a subclass there, and everything seemed to work. It worked so well
that we have built the majority of the features on top of it.

We could have continued building upon that graph, but the further we moved, the clearer it was that we needed more flexibility, safety, and an easier to reason about graph. Unlike the old graph that used in-memory references to represent dependencies, we implemented the new one as a `struct`.

The edges of the graph are represented by dictionary key-value relantionships, and the nodes by enums. Everything is defined in a model so at a glance you can see its format. Moreover, we built a traverser that wraps it and provides efficient methods to traverse it. Those are useful when generating the projects because the logic needs to traverse the graph a few times to obtain information like what linking build phases should be added.

The new graph is already used by many components, but there are still some left. Doing this work made me realize how core this model is and why it makes Tuist's project generation so unique. It's certainly not as interesting work as building new features, but I'm motivated by the fact that this refactor will enable so many future improvements and new features.

If you see me not talking too much about new Tuist features is because I'm
spending most of my time making this possible.
