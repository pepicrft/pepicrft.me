---
title: Tuist 2.0 and next
tags: ['tuist', 'open-source']
---

As we are approaching the release of Tuist 2.0,
I started thinking what's next for the project.
The focus until 1.0 was around project generation.
We provided developers with a graph-based project generation that abstracts away Xcode's intricacies.
As we passed that milestone,
we started thinking about building workflows and optimizations built upon project generation.
The graph was a powerful project element that other tools lacked so we felt we needed to leverage it further.
We added `tuist focus` to generate projects that are optimized for developers' intents.
`tuist signing` made it easy to configure the environment and the generated projects for signing,
and `tuist cache warm` allowed caching project targets as binaries for later usage when generating projects.
We also started exploring the idea of standardizing and integration of third-party dependencies through a new manfiest file,
`Dependencies.swift`,
and we just released support for defining tasks defined in `.swift` file that get compiled and executed.
Quite a ride, isn't it?
Along the process we met many talented developers that joined on on this ride,
and became the fuel that makes the project move forward.

After releasing tasks and overhauling our website to reflect the new brand,
we'll start working towards 3.0.
**What does that mean for the project?**
Besides improving project generation,
for example by making it faster and handling more project scenarios,
I think we should focus on the following elements:

- **Thinning Tuist:** We built many commands into Tuist that should be opt-in and extracted from Tuist. For example, the `tuist doc` command doesn't necessarily have to be implemented by Tuist. Our work on [plugins](https://docs.tuist.io/plugins/using-plugins) and tasks will allow that. Those commands will be distributed as plugins and live in different repositories.
- **Dependencies.swift:** We should continue investing in this project and have great support for Pods, Packages, and Carthage frameworks. How to integrate third-party dependencies into Tuist project is a recurrent theme and therefore we should provide first-class support for it.
- **Cross-repository dependencies:** At the moment, a `Project.swift` can't define a dependency with a `Project.swift` that lives in another repository. Because of that, teams end up creating a `Package.swift` alongside the `Project.swift` to be able to consume that dependency as a package. Although this works, it prevents developers from leveraging graph optimizations such as `tuist focus`. I think we could build a decentralized dependency resolution logic into Tuist inspired by the SPM and step into SPM's domain. Just a tiny bit 😁.
- **Lab:** If graph is a cornerstone component in Tuist, a server would take Tuist to a whole new level. Lab would be that server. Developers would have the option to self-host it, or use our paid hosted instance, and therefore financially support the project. Lab would allow things like:
  - Reporting build insights on PRs
  - Define tripwires and alert teams on Slack or PRs when they hit them.
  - Cache your project's binaries remotely and share them across the teams.
  - Have an internal registry of frameworks and libraries that you can reference from your projects.

I'm sure more ideas will pop up down the road,
but the ones that I shared above will most likely be our focus as we enter this new chapter.
We'll continue to listen developers,
their challenges,
needs,
and collaborate to figure out how Tuist can help them the best way possible.

Thanks for reading.
