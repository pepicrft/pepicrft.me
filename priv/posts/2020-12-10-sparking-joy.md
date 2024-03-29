---
title: Sparking joy working with Xcode
tags: ['xcode', 'tuist', 'complexity']
---

I learned by working with Ruby and Ruby on Rails during my time at Shopify that using tools and programming languages that spark joy is crucial for developers' motivation. Even though we developers love to understand complexities, **we enjoy working with simplicities and conveniences day-to-day**.

In the Swift community, we've seen a proliferation of tools to help developers with different needs _(e.g. generation of Swift interfaces from resources, code linting, dependency management)_ that inevitably led to a non-cohesive and complex developer experience where [Fastlane](https://github.com/fastlane) acted as the glue. On top of that, the authority bias is nudging teams to have more than one dependency manager in their projects to stick to Apple's recommendations.

Below there's a common Xcode project setup with all the elements that are part of it and how they depend on each other. Note the estensive list of elements that you need to work on the project. There are a lot of caveats in such setup:

- **Reproducibility** is harder that might result in developers spending their time debugging inconsistent results across environments. This can happen for instance if [Homebrew](https://brew.sh) decides to install a new version of a tool on CI that introduces breaking changes.
- The setup is **difficult to reason about** for a new person joining the project. Only the people that have been part of the design can have such an overview. It results in a terrible [bus factor](https://en.wikipedia.org/wiki/Bus_factor), which in large companies translates to the infra team or the go-to person that knows everything about the project setup.
- **Optimizations** are not easy. Different pieces are so coupled to each other that introducing optimizations that have a significantly affect on developers' workflows is a challenging task.
- Because there are many potential points of failure, when errors arise, they are harder to **debug**. _Is this failing because of my CocoaPods version? Is it because of this pod lane that I'm using? Might it be related to the version of Ruby I'm using?_

![The diagram shows an example of a complex Xcode project setup](/images/posts/complex-setup.png)

That's a setup prone to errors and stress for developers with which I'd never want to work. We've spent most of our time building great tools but not that much thinking about providing a **cohesive experience when bringing them together**.

For this reason, we continue investing in [Tuist](https://tuist.io). We believe there's an opportunity for providing a Rails-like experience for developers building apps with Xcode. An experience that combines primitives from Apple like `xcodebuild` and tools from the community.

**Anyone can and should be a project architect**. To make this possible, developers need simple setups and APIs to describe their projects. Having an infrastructure team is useful to steward the project's growth, but there shouldn't be any strong dependency between feature teams and them. The trap many companies fall into is building this strong dependency where every time you need to do something that touches the architecture, you have to do it through the infra team. The setup must be **simple**. Embracing complexity is the formula for creating an environment in which developers don't want to work. Tuist owns complexity and the optimization of workflows to provide a simple and efficient workflows through the CLI. A more straightforward setup will make the environments more **reproducible**, and thus developers will have to spend less time debugging issues when they arise. To work with Tuist, teams only need to install Tuist, and that's it. No dependency on Ruby, Homebrew, nor Fastlane. It's you, Xcode, your project, and Tuist.

Developers might see this setup as rigid like many companies saw and continue to see Rails. But look at companies like [GitHub](https://github.com) and [Shopify](https://shopify.com) that were able to build excellent products in part thanks to the fact that developers could focus on building the product and not fighting the underlying tooling and frameworks. As apps become larger, the need for a Rails-like foundation becomes more important, and that's the place I think Tuist can take in the community.
