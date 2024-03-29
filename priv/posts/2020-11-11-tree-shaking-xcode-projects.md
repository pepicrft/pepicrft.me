---
title: Tree-shaking Xcode projects
tags: ['xcode', 'tuist', 'caching', 'build times']
description: Tree-shaking is a concept inspired by Javascript and used by Tuist to generate lean Xcode projects that are processed and compile faster.
---

You might have seen me talking about Xcode projects' tree-shaking with no idea of what I'm talking about. This is a concept inspired by the same concept in the Javascript land. Over there, it refers to the process of stripping away from the resulting Javascript bundle those bits that are not necessary because there are no execution paths that go through them. The goal is to minimize the size of the file that is served that the website opens faster. I liked the idea and made me wonder if something like that would be useful in Xcode projects. It turned out it is.

What's tree-shaking an Xcode project
Have you tried to open a large project in Xcode? Indexing is not immediate, the list of schemes is probably large and hard to navigate through, Xcode's features like searching are slower than usual. This is something we are, in fact, experiencing in Tuist's codebase, and it's very annoying. What if the generated project had a focus on a given target and removed everything that is not necessary to work on that target? In a modular codebase, that's a common thing to do. You work on the Search team, and most of your work is done in Search.framework. There'll be scenarios when you need to work on core frameworks, but most of the time, it's not the case. Well... that's what Tuist does when you run the following command:

```language-bash
tuist focus Search
```

We traverse your project's dependency graph and remove the elements you don't need to work on Search. Let's look at the example below:

![An image that shows how the tree-shaking of projects works with Tuist](/images/posts/tree-shake.png)

We have a simple modular app with a layer of feature frameworks and another layer of utility frameworks. When we focus on Search we get that target and its dependant targets (e.g. SearchExample, SearchTests, SearchUITests) as sources, and its dependencies as binaries (if they exist in the cache). This means Xcode doesn't have to index anything related to App, Settings, and Home, and clean builds of the framework will only have to compile Search. For the user, that also means that they can safely clean their environment (i.e. deleting DerivedData) without feeling concerned about leading to a slow build.

As part of the tree-shaking process, we also delete from the workspace the projects that have no targets after deleting the unnecessary targets, and update the schemes to remove the references to no-longer-existing targets.

What if I wanted to modify something in Core? We thought about that too, tuist focus supports a list of targets you'd like to focus on. You can run the following command, and you'll get the sources of Core too:

tuist focus Search Core
Neat! Isn't it? I think tree-shaking is a powerful idea that will boost developers' productivity working with large Xcode projects. I can't stress enough how much value this brings to Tuist's project generation functionality compared to other solutions out there whose main focus is having a new language for .pbxproj files that is not prone to Git conflicts. Tuist goes beyond that and puts itself in the shoes of teams that need a tool to optimize these optimizations to make their developers productive and focus on building features.
