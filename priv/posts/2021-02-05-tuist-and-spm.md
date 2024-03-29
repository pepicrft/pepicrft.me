---
title: 'Tuist and the Swift Package Manager'
tags: ['tuist', 'open-source', 'github', 'swift', 'xcode']
---

It's common to see developers wondering why they should use [Tuist](https://tuist.io) instead of the Swift Package Manager (SPM) for modeling their projects.
I think it's normal. It happened to me a few times too. Some of them even made me wonder if I should continue investing time into Tuist.
There are some ideas and principles that are common to both tools.
One can use Tuist to define a CLI tool like you'd do with SPM in the same way SPM could be used to to define the targets of your project.
However, there's a fundamental difference that is worth bringing up in this tiny blog post.

**The Swift Package Manager is dependencies-oriented while Tuist is projects-oriented.** SPM does a good job resolving and pulling dependencies, and providing a standard CLI to build and test your packages. The developer experience integrating it with Xcode is questionable good, but it works in most cases. I say it's questionably good because when used at scale, like it's the case in Tuist's codebase, it's a bit frustrating seeing Xcode very often invalidating the dependency graph, or failing to resolve it and having a project that can't compile. Because SPM is dependencies-oriented, the workflows are designed around that. This might change depending on the direction that Apple takes with the tool, but if that doesn't change, I doubt we'll improvements that projects need at scale.

On the other side, Tuist is designed as a tool to **make the experience of maintaining, interacting and scaling up your projects the best**. Because the people behind Tuist maintains large-scale projects, we are building features that can make a huge difference in developers productivity: _project description helpers_, _focused projects_, _caching_, and _standard interface for third-party dependencies (not only packages)_. If Apple is that giant corporation that come up with utopian visions of developer experience towards which many teams are biased _(i.e. authoritative bias)_, we are the tiny startup that stays close to the developers and their pains and solves the problems that they bring up. And because we don't have to align our ideas with any business's direction, it's easier to explore and execute ideas.

That being said, it's possible that Apple changes the direction of the Swift Package Manager and turns it into a project manager. However, and as we've seen in the past, I think they'll continue distant from the real problems that developers face. The future of developer tooling around managing your Xcode projects is exciting.
