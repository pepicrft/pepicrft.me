---
title: 'Scaling up an open-source project'
tags: ['engineering', 'open-source', 'tuist', 'github']
---

One thing that I've been struggling a lot with lately is the amount of distractions that come with the growth of an open-source project.
In the case of [Tuist](https://tuist.io),
those distractions have come in the shape of notifications on GitHub,
mentions on PRs,
direct messages on Slack,
and interesting conversations happening on Slack channels.
Working on Tuist lately has felt more like running on a treadmill.
I don't like it.
I like being able to craft new features and improvements with no distractions.
Just me and Xcode.

To regain the focus that I used to have then the project was small and only a few people I started taking action.
First I'm **time-boxing** the time I use checking notifications, Slack messages, and pings on PRs.
I think spending between 15' and 30' minutes per day is enough.
If something comes up after that daily time it has to wait until the next day.
Moreover, I'm trying to document and automate as much as I can.
I introudced a **new tool** into the project, `fourier`, that will become the place for all utilities necessary to work on the project.
Most of the answers on how to do things will be in either the tool or the documentation so people shouldn't need me to answer "how do I do X"?
Also, I'm encouraging people to use asynchronous discussion channels like GitHub PRs and issues.
Unlike Slack where people feel the freedom to catch your attention,
it's you who decides when is the time to read the discussion on GitHub.
You are the one controlling your attention.

Let's see how that goes.
One of the reasons why some maintainers give up on open-source projects is because they can't cope with the maintenance burden.
I don't want the same to happen in Tuist and I'll work towards that.
