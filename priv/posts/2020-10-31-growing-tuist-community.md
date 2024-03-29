---
title: Growing Tuist's community
tags: ['tuist', 'open-source', 'community']
description: In this blog post, I share my experience building the Tuist community. I talked about the things that have worked well, and the areas where there's still some room for improvement.
---

As you might already know, I devised and started working on [Tuist](https://tuist.io/) a few years ago. I was motivated by the fact that modular Xcode projects were a nightmare to maintain and that existing project generation solutions were taking a direction that would lead them to surface the same intricacies and complexities present in Xcode projects. I envisioned Tuist as more than just a project generation. I wanted it to be a platform that makes development convenient and removes indirection layers introduced by tools written in different programming languages. Rails was my most massive inspiration. The framework places convention over configuration to provide a great user experience. Rather than installing a handful of tools, like it happens when developing apps with Xcode *(CocoaPods, Carthage, SwiftLint, [Sourcery](https://github.com/krzysztofzablocki/Sourcery), [SwiftGen](https://github.com/SwiftGen/SwiftGen))*, you install one, and it works. I was thrilled to bring the same idea to the Swift community.

When I embarked on that journey, it was clear that the community would play an important role. That's one of the things that makes [Rails](https://rubyonrails.org/) so unique too. It's made by people that have a lasting commitment to the project. This is rarely seen in the Swift land, where it's more common to see people come and go often. Many clickbait-type projects reach a spike of hype and stars on GitHub, and then they are abandoned or barely maintained. Tuist would be different. It'd have a mission, it'd place UX in the first place, and people would be encouraged to show a lasting commitment to the project. It'd help developers with the challenges they face when scaling up projects. Users would be invited to share their challenges to help shape the direction of Tuist.

In this blog post, I'll share what had worked well in building the community and the things that still have room for improvement.

## What has worked

### Documentation for contributors

Joining a community as a contributor might feel intimidating. *Where do I start? *Projects usually place a `CONTRIBUTING.md` file in the repository with some basic guidelines, but that's not enough - people need a walkthrough that explains how the project is architected and how they can clone it and be able to run it locally. We did that on [Tuist's documentation](https://tuist.io/docs/contribution/getting-started/). We realized new contributors appreciate that a lot because they have an exact starting point.

When we see new contributors joining the community, we take the opportunity to engage with them and get some feedback from them to improve the documentation. We don't treat it as a static piece of the project but rather as a dynamic one that needs to evolve alongside the project and the growth of the community.

We'd like to invest more in it and add a tutorial that guides the user through all the features they have access to with Tuist.

### Pairing with newcomers

I learned that introducing people into the project by pairing with them is the most effective way to bring a diversity of ideas to the project and empower them to contribute further to the project. It's hard to explain how energizing it is seeing people contributing for the first time to a project and shipping their first feature after one or a few pairing sessions.

### Build a modularized architecture

If you build the project as a monolith, familiarising yourself with the project means familiarizing yourself with the entire monolith. However, if you split that up into smaller feature domains, it's easy for new contributors to familiarise themselves with a particular area of the project and contribute to it. In the case of Tuist, we invested a lot in that from the very beginning, and it's paying off. Most of our features are modeled following a functional paradigm. Projects are loaded and then passed through a series of mappers representing different features to eventually reach the components that turn them into the Xcode project. Thanks to that, we've been able to introduce mappers that bring support for caching, generate type-safe APIs for accessing resources, or turn your project into a visual graph.

In the case of Tuist, we followed the [uFeatures](https://tuist.io/docs/building-at-scale/microfeatures/) architecture that is detailed here, and it has worked very well.

### Monorepo

One of the areas of projects that is often disregarded is documentation. Getting the documentation out of sync with the project can have a very negative impact on the experience users have with the project. To prevent that from happening in Tuist, documentation (developed as part of a [Gatsby](https://www.gatsbyjs.com/) website) lives alongside the source code of Tuist in the same repository. Developers are required to update it as part of their work on improvements and new features. Moreover, their changes are automatically built by [Netlify](https://www.netlify.com/), which offers a preview automatically.

If we were not using a monorepo, building a new feature would consist of more than one PR with references between them. That leads to *"I'll open a follow-up PR with the documentation update" *which, in the end, it doesn't happen. Thanks to GitHub Actions API, it's straightforward to define which workflows should be triggered based on the file changes.

Every improvement new feature on Tuist must have code changes, unit tests, acceptance tests (if needed), `CHANGELOG` update, and documentation. If any of those elements is missing, the PR is not merged until it has it.

### Having a Slack group

Even though I'm trying to avoid synchronous communication lately because it makes people believe that the answers should be synchronous too, I have to say Slack played an important role in the growth of Tuist's community. Once in a while, people are joining and engaging with other users and contributors. I always take the opportunity to engage with them and ask them what brought them to Tuist. It's fantastic to hear first-hand what features from Tuist motivated them to decide to use it. Interestingly, many users like the idea that they can use Tuist to define workspaces and have excellent documentation that they can follow through.

### Engage through Twitter

Since the inception of the project, we've had a Twitter account that we use to share updates with users and people interested in the project. We share all kinds of Tuist, from new releases to tips. Having the account also allows contributors to tag Tuist whenever they proudly share their contributions to the project. Most of the community of developers that work with Xcode are on Twitter, so it's the place to be if we want them to know about Tuist and give it a try.

### Believe in our ideas

The Xcode community is settled on solidified ideas that have either been established by Apple or the community. This is great because you don't have the fatigue you'd have in Javascript trying to find the solution among many that work best for you, but has the downside that constrains new ideas. We've experienced that from the very beginning when people started comparing Tuist with [XcodeGen](https://github.com/yonaskolb/xcodegen) and [Fastlane](https://github.com/fastlane/fastlane). Yes, we leverage project generation and provide commands that developers would usually define in `Fastfile`. Still, we take a different approach with different goals. It's easy to get distracted by the community opinions, but it hasn't been the case here.\
Tuist's community is not afraid of throwing new ideas and exploring them further. Thanks to that, we have features like project description helpers, module caching, and auto-generation of documentation that wouldn't otherwise be in Tuist.

### Trust people

Shopify has taught me this. One of the best values that you can have in your project/company is trust. It's a value ingrained in Shopify's culture, and wanted it to be part of Tuist's too. Since the beginning, we trusted people to do all sorts of things in the project: *propose and own the implementation of new features, publish new releases, provide support yo the community...* When you do something like that, they feel part of the project and are empowered to contribute further.

This has the downside of trusting people that might end up proving that they are not trustworthy. However, we are lucky that hasn't been the case in Tuist yet. If we happen to have this scenario, we'll handle it.

### Recognize people's work

We take the time to recognize the work that people do, both privately on Slack and through mentions on Twitter. I've noticed some communities have automated through bots on Slack, but honestly, it saddens me that we have reached a point where we need to say thanks through a bot. In some cases, I've gone as far as to send the person a little gift *(e.g., stickers with a hand-written card and a book about open source)*.

## What hasn't work so well

### Delegating

Although there are a few maintainers and contributors, there's still a lot of that falls over me, and that sometimes results in a bottleneck when there's a lot of work in the backlog, and I don't have enough attention after work that I can devote to it.

I'm currently seeking domain owners, but it's hard because Tuist is a side project. They sporadically contribute to the project but can't commit to a role in the project. This is the classic issue with open source projects that we don't know how to approach either. And it concerns me because it can lead some of us to burnout and give up.

I recently started building a companion web app that integrates with GitHub, Discourse, and Slack and provides utilities to make this easier. For instance, one of the ideas that I have in mind is having tweet requests (TR), a way for contributors to propose tweets shared from Tuist's main account. I called this app [Backbone](https://github.com/tuist/backbone). It's in a very early phase, but you can check out the project on this repository.

### Vision

I haven't done a good job sharing what's the vision of the project. I've been hinting it through Slack messages and posts in the community forum. Still, it's hard for someone new to the community to imagine the future of Tuist and how the current projects align with it. I guess it's normal when the project is young. There are many things yet to be defined, but as things start to mature, having a vision makes it easier for teams to align with the upcoming features.

## Final thoughts

Tuist is my baby 👶 - I like working on it a lot. We've built a community of users, contributors, and maintainers that make the project so unique. We have gone from merely being a project generator to a platform that provides streamlined workflows to focus on the most critical tasks. Since I started building Tuist, I was disappointed that only the big companies in the industry could access those features that most projects need to scale up *(e.g., easy modularization, caching)*. I tasked ourselves with democratizing that and making it accessible to anyone.

It's been three years, and the project keeps moving forward, fueled with great minds and creative people. I don't know what'll come next, but I'll indeed say that it'll help projects of any size with the challenges they face or are about to face.
