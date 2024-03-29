---
title: 'Focusing on the problems'
tags: ['problems', 'open-source', 'tooling', 'tuist']
---

One of the things that I noticed when building tools for developers, either through Tuist or my work at Shopify, is that we developers tend to get incredibly excited about what our new idea would enable, and put the need or problem aside. I believe that’s the source the complexity and the configuration over convention that we see in many tools.

While working on [Tuist](https://tuist.io), it’s common to see users creating issues saying they need something without giving context on why they need it. And it’s also common to see other contributors and maintainers moving the discussion along without figuring out the reason that prompted them to create the issue in the first place. **We can’t design great solutions if we don’t understand the needs very well.**

My role as lead at Shopify and core maintainer at Tuist often comes down to reminding people about the importance of understanding the need or problem. In the case of Tuist, this is done through discussions on GitHub issues, and at Shopify we often do it through user interviews. It sometimes requires a few whys until the developer surfaces their motivation. In some odd cases, it leads to the realization that they don't know the need or that there's already a solution for it.

Once identified, I nudge people to find the simplest solution that solves the problem. Still during this phase developers think far ahead and imagine how developers would use the feature and why that usage justifies the level of configuration they want to introduce into the feature. **But do they need it?** Most of the times the answer is **not now**.

In the space of Xcode project generators, this mindset is a key and highly-appreciated differenciator compared to other alternatives. Although they turn the `.pbxproj` into a more readable and shorter version of it in a YAML file, it's still the same complex concepts and configuration that makes the process of evolving Xcode projects a difficult task. With Tuist, every request to port an Xcode feature into Tuist's APIs is looked from the angle of **what are you trying to achieve with it**. I like how DHH calls it on [his keynote talk from RailsConf 2018](https://www.youtube.com/watch?v=zKyv-IGvgGE), **conceptual compression**. If we, crafters of tools, own complexity to provide simplicity, the resulting tools will noticeably spark more joy when using them.

And last but not least, I the process of turning a problem into a solution requires a thorough thinking. We should let the idea sit in our mind for days, explore different solutions, and very importantly, understand how they fit into the project and aligns with its direction. That sometimes means saying no to the idea. I think taking **this process as a marathon and not a sprint** can make a huge difference in developer experience. If you treat your GitHub issues as an inbox where you goal is to get down to zero and implement everything you've been asked for, there'll be plenty of interesting ideas, but that they don't know how to talk to each other.
