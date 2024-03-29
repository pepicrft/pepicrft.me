---
title: 'Data-driven open source'
tags: ['tuist', 'open source']
---

Yesterday, we announced that Tuist has now [stats](https://stats.tuist.io) that allows us to understand how users use the tool and therefore, invest our time working on Tuist more wisely.

As expected, there were some negative reactions to this:

- Oh! I’m glad that I can opt out.
- And yet another tool that succumbs to the data-driven method...

If I put myself on their shoes and after seen what large corporations have done with the data I’d react the same way.

However, there’s a subtle difference. We are an open-source project, and such, the time can we can devote to the project is limited. It’s people working outside of their usual working hours to make the tool better. If we don't know how the tool is being used, we don't know if the limited time that we have is well-invested. It's not about us using the data to sell them something, **it's about us using the data to make the tool better**.

Interestingly, there are more tools out there that they might be using without realizing that they are also collecting data for the same purposes: [Homebrew](https://brew.sh) and [CocoaPods](https://cocoapods.org/). Every `pod install` they've run, has sent data to CocoaPods to better understand how frequently Pods are used. Every `brew install X` has sent data to Google Analytics to know what formulas are used the most. And yes, [Fastlane](https://github.com/fastlane/fastlane/blob/48151291f2c4949c3b1b9919ba2cc81a7cc33293/fastlane_core/lib/fastlane_core/analytics/analytics_session.rb#L7) does it too.

Because we know this is concerning, we have taken the approach of not only having all the code for collecting and sending events public, but we've built our own [Rails app](https://github.com/tuist/stats) with its own database on Heroku to store the data. Tuist's data is our data, not Google's. It stays within our domain. And because we own it, we'll apply the same values to it that we've already applied to the code that users are already using.
