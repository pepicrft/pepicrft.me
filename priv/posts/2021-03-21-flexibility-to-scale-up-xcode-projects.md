---
title: The role of flexibility in scaling up Xcode projects
tags: ['tuist', 'open source', 'xcode', 'swift']
---

I often wonder why Apple continues to build features that are closed into Xcode,
for example Swift Package Manager's integration.
While some developers might see that as something positive,
because that means it can be seamlessly integrated into Xcode's UI and workflows,
I see it as a **complication for scaling up Xcode projects.**
Let me unfold this last thought in this post.

**You can't build a tool that satifies every team's needs.**
You can't design Xcode to work for the tiny startup that is building a simple app,
as well as for a company like Facebook that has a complex project with many inter-dependent targets.
Apple optimizes for one type of app,
the one that is the most common across all the projects:
a mono-target app that might have extensions and support for multiple platforms.
In that setup, Xcode works fine.
You create your project using Xcode's menus,
add a new target when needed to _extend_ your app,
and add third-party dependencies through the Swift Package Manager integration.
Xcode, the project format, its build system, Swift, and all the surrounding tools are designed for that.
There's nothing wrong with that,
except that those developers that need more are left out of the equation.
Their projects take a long time to compile,
tiny changes cause the build to break,
and Xcode is not as responsive as it used to be.
Companies like Uber [have suffered a lot from this](https://twitter.com/StanTwinB/status/1336890442768547845).
Others have adopted [Bazel](https://bazel.build/) as a build system to escape the problem,
and need dedicated resources to keep it working with every Xcode/Swift update.

_There must be a better way to scale_.
Finding an answer to this question is what fuels me to build [Tuist](https://tuist.io).
I think the answer to this comes down to **flexibility**.
The flexibility to extend, optimize and even replace the build process without having to leave Xcode.
The flexibility to declare my project's graph, optimize it and validate it early to prevent errors down the road that cause developers' frustration.
That flexibility could be achieved with Xcode opening more APIs instead of building inside itself and treating it as a black box.
However, that's not the direction Apple is taking, and we are seeing that with Swift Package Manager's integration into Xcode.
One of the reasons why other programming languages are used over Swift when building software at scale is the flexibility of their tooling.
In [Ruby](https://www.ruby-lang.org/en/), you can customize your test-running logic andd add [types](https://sorbet.org/) to the language. In Javascript, you can [implement plugins](https://esbuild.github.io/plugins/) that extend your build process and that add new [linting rules](https://eslint.org/docs/developer-guide/working-with-plugins) that integrate seamlessly with the editor.
Having a [Language Server Protocol (LSP)](https://nshipster.com/vscode/) is a good step forward, but it's not enough.

Because Apple doesn't open those APIs, Tuist is taking the role of opening them for developers.
We are doing that by leveraging Xcode project generation.
We abstract the `project.pbxproj` format with a more declarative format that can be extended easily.
Developers love that,
and the fact that Apple doesn't change their mindset is positive for Tuist because they create a room for the project to thrive.
