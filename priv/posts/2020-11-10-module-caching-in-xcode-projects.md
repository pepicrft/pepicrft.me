---
title: Module caching in Xcode projects
tags: ['xcode', 'tuist', 'caching', 'build times']
description: Bazel and Buck is the solution large companies have adopted to make Xcode build fast. However, it's complex and not accessible to medium and small companies. In this blog post, I share the approach Tuist is taking and how it's inspired by tools the community is already using.
---

As you might know, we've been working on a new feature for [Tuist](https://tuist.io/), caching, to speed up build times of Xcode projects.

Large companies usually resort to build systems like [Buck](https://buck.build/) or [Bazel](https://bazel.build/) to introduce remote caching into their projects. Those are great build-systems. Apple is bringing talent that has previously worked with them to improve the Xcode and [Swift Package Manager](https://swift.org/package-manager/)'s build-system. However, the build system is not accessible for small and medium-sized companies because they can't afford to have a tooling or infrastructure team to migrate from Xcode's build system. Moreover, using another build system has proven to have significant costs for the infra team and inconveniences for the users. Since Xcode doesn't support replacing its build system, companies have to resort to project-generation in combination with some hacks to get Xcode to compile using Bazel or Buck. Moreover, with every new Xcode update, they have to do some work to ensure their setup doesn't break and that developers can always be in the latest Xcode version. Not ideal, is it?

With Tuist, we have taken a simpler approach to caching that is inspired by solutions that we have already seen in the community. Here's how our implementation relates to tools that you might already be familiar with:

- [Carthage](https://github.com/carthage/carthage): Carthage takes a different approach to dependencies. Rather than integrating the source code through a project and a workspace, it uses dynamic frameworks that can be easily dragged and dropped into a target and Xcode will automatically set the linking build phases. The clear advantage here over CocoaPods is that your clean builds don't compile the source code of those dependencies. However, it requires developers to understand their project's dependency graph, to ensure that the frameworks are copied into the right products. A badly configured project might lead to apps crashing at launch time, or Apple rejecting your bundles because you have copied a framework into another framework. From Carthage, Tuist gets the idea of turning your project targets into binaries.
- [Rome](https://github.com/tmspzz/Rome): Takes Carthage frameworks and store them in a remote storage. Thanks to this, Carthage frameworks are only built once and shared across all the developers in the team. Nothing changes regarding how those frameworks are integrated into the project. From Rome, Tuist gets the idea of reusing binaries by storing them on a remote storage.
- Swift Package Manager: SPM's approach to dependencies is similar to CocoaPods. The main difference is that since it's developed and maintained by Apple, the integration in Xcode projects is more seamlessly. Xcode has built-in workflows for resolving Swift Packages at launch time, and the build system knows how to build and link those dependencies into your app. From the Swift Package Manager Tuist gets the idea of defining your projects using manifest files that are written in Swift.

So how does Tuist combine all the above elements to provide caching?

It generates Xcode projects *(like CocoaPods)*, where the targets that you don't plan to work on are replaced by binaries *(like Carthage)*, that are stored in a remote storage *(like Rome) *that gets populated from CI. All of that happens at project generation time when developers run the following command:

```
tuist focus MyFramework
```

It reads as: I'd like to work on `MyFramework`, please, replace direct and transitive dependencies with binaries, and tree-shake my project to remove elements that are not necessary to work on that target *(e.g. other targets, their schemes)*.

Because what you get in the end is a standard Xcode project, you don't have to worry about future Xcode versions breaking your setup, or using hacks on the Xcode side to make the developers' experience seamlessly.

The image below represents the layers of indirection that are introduced when using alternative build systems. Note that build files have to be translated into another representation that is then passed to a project generator to get an Xcode project. Moreover, the final Xcode projects need to need to trick Xcode into using Bazel or Buck as a build system.

![An image that shows the setup that companies adopt when using Buck or Bazel](/images/posts/module-caching-1.png)

The diagram represents the common setup when using alternative build systems.

In the case of Tuist, there are no layers of indirection. It takes your project definition and generates an Xcode  project ready to be used with Xcode's build system. Because of its simplicity, the setup is easier to reason about, optimize, and debug. Moreover, it makes caching accessible to more users:

![An image that shows how caching works with Tuist](/images/posts/module-caching-2.png)

The diagram represents how the caching works in Tuist.

## Some final words

We'll never be able to build a solution like Bazel and Buck because we are not experts in build systems, nor we think it makes sense to take people away from Xcode's build system. We believe though, that some of the ideas from Bazel and Buck can inspire future improvements in Xcode.

Apple seems to be betting on evolving its build system to be something closer to what Google offers with Bazel. However, it'll be challenging to enable it in existing projects that might have deviated a lot from a standard Xcode project. One of my guesses on how Apple is going to proceed is that they'll first evolve the monolith `.pbxproj` format for projects into a new format that abstracts some of the intricacies that we have been traditionally exposed to *(e.g. linking build phases, build settings) *and is less prone to git conflicts. With a more limited format, it'll be easier for them to reliably enable build caching because they'll have a well-defined set of project flavors that they'd need to optimize for.

I'm very excited to bring this feature to Tuist and democratize caching for medium and small companies. There's a lot we need to improve, and project scenarios to handle gracefully, but it's looking promising, and can't wait to see more projects using it and making their developers productive through Tuist.
