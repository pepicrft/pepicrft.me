---
title: Project generation
description: This blog post describes the advantages of dynamic over static Xcode projects, and how Tuist leverages project generation to help teams overcome the challenges associated to scaling up projects.
tags: [tuist, swift, xcode, ios]
---

Last week I published a [thread](https://twitter.com/pepicrft/status/1153252000685072384) on Twitter in which I shared what I think is the value of generated Xcode projects.
I've been a huge advocate of generated Xcode projects since I worked at SoundCloud,
where I realized the maintenance cost that modular Xcode projects bring.

In this blog post,
I'd like to extend each of the advantages that were mentioned in the thread,
and relate them with the features that we are building into [Tuist](https://tuist.io).

## 1 - Focus

Large apps often resort to modularization to scale up.
Codebases are broken down into smaller modules with clear boundaries and responsibilities.
In my experience seeing modular Xcode codebases,
they are usually organized in multiple directories and Xcode projects.
Each them is **manually maintained**.

The more Xcode projects you have,
the more time you will need to spend **maintaining** them and **figuring out issues** that might arise as a result of the accidental complexity.

Tuist abstracts the low-level intricacies and handles them for you.
For example,
the dependencies are described semantically and not in terms of build phases or build settings:

```language-swift
let app = Target(name: "App", product: .application, dependencies: [
  .target("Profile")
])
let profile = Target(name: "Profile", product: .framework, dependencies: [
  .target("Utilities")
])
let utilities = Target(name: "Utilities", product: .staticLibrary)
```

Furthermore,
it generates Xcode projects with just the pieces that the developer needs to do their work.
The distractions are taken away to help developers have more **focus** and bring joy scaling their project up.

## 2 - Environment

_How often have you tried to compile an app,
and after some time,
it fails because a necessary certificate is not present in your Keychain?_
The more dependencies the project has with the environment,
the more likely that scenario is to happen.
Using [SwiftGen](https://github.com/SwiftGen/SwiftGen) to generate code from our resources,
or [Carthage](https://github.com/Carthage/Carthage) to embed dynamic frameworks,
is an implicit dependency.
If they don't exist,
the compilation might fail.

Teams overcome this problem by including in the project `README.md` a list of steps that they need to execute before opening the project in Xcode. There are two caveats with this approach: it's hard to ensure that developer environments are configured consistently _(e.g. the same version of a tool)_ and notify them when one of the dependencies requires an update _(e.g. a new certificate to be installed in the Keychain)_.

Tuist provides a command,
`tuist up`,
to verify and configure the environment.
Teams just need to describe the configuration in a `Setup.swift` file:

```language-swift
import ProjectDescription

let setup = Setup([
    .homebrew(packages: ["swiftlint", "SwiftGen", "Carthage"]),
    .carthage(platforms: [.iOS])
])
```

Moreover,
and this is not implemented yet,
it'll provide an interface to describe the signing.
It'll use that description to install the right certificates in the Keychain,
place the provisioning profiles in the right directory,
and configure the Xcode during the project generation.

Tuist is more strict than Xcode with the validation of the projects and the environment.
**If it knows that the project won't compile, it fails immediately.** Developers time is precious and shouldn't be wasted.

## 3 - Misconfigurations

The growth of Xcode projects come with complexity,
and when things become complex,
it's easier to make mistakes.
A wrong build settings flag
or a missing argument in a script build phase
can be the source of compilation and App Store validation errors.

Xcode runs weak validations on projects.
It assumes the developers know what they are doing,
and heavily relies on components like the build system or the app uploader to catch issues. There are two drawbacks with that approach:

- It might take some time.
  For example, if a dynamic
  framework is being copied into another framework.
  The error will show up when the app is being uploaded to the store.
- Most of the times,
  the errors say nothing about the source of the error.
  For instance,
  if you try to link a iOS framework against a macOS's _(something that Xcode allows)_,
  the compilation will fail with a `framework not found` error message.

Tuist is more strict in this regards and runs validations during the project generation.
If it knows something won't compile,
it'll fail and tell developers why.
We understand configuring a large project can be a hard task,
and we want developers to do it right **at any scale.**

## 4 - Consistency

Consistency is crucial to scale up apps.
Without it,
the work across multiple projects becomes more difficult.
Jumps between projects require an extra effort to understand how projects differ from each other. Moreover, inconsistent projects are more error prone.

Although ensuring consistency is easier when all the Xcode projects are part of the same repository,
Xcode doesn't help much with it.
The only feature that helps with consistency by reusing build settings across projects are the `.xcconfig` files.

Consistency can also manifest in:

- The list of targets of each of the projects.
- The list of target build phases and their names.
- The list of project schemes and their configuration.

The way Tuist helps making the projects more consistent is by having a programmable interface where developers can leverage Swift features like functions.
The definition of a project can be the result of calling a function:

```language-swift
func frameworkProject(name: String) -> Project {
  // Targets
  let framework = Target(name: name, product: .framework)
  let unitTests = Target(name: "\(name)Tests", product: .unitTests)
  let uiTests = Target(name: "\(name)UITests", product: .uiTests)
  let targets = [framework, unitTests, uiTests]

  return Project(name: name, targets: targets)
}

let searchFramework = frameworkProject(name: "Search")
let coreFramework = frameworkProject(name: "Core")
```

_How beautiful is that?_
Using Swift over declarative formats like YAML makes it possible without having to re-invent the well.

## 5 - Complexities

One of the most important lessons that a developer can learn for coding is KISS _(keep it simple and stupid)_.
I believe the same applies to Xcode projects.
In this case,
the complexity is hard to avoid because it's Xcode the one exposing it.

After the creation of projects,
Xcode leaves the developers with the responsibility of maintaining and keeping them up to date.
That's proven not to be an easy job.
For instance,
with the recent introduction of support for Swift Packages in Xcode,
many developers are still [figuring out how the new Tetris piece fits their overly complex projects](/2019/06/23/the-tale-xcode-projects-complexity/),
that are perhaps already using CocoaPods or Carthage.

Tuist has taken a stance similar to the one Rails has in the web ecosystem:
_complex tasks are abstracted and made easier,
and only if necessary,
developers can manage intricacies by themselves._
It defaults to simplicity and prevents the complexity of the projects' structure from growing proportionally with the number and size of the projects.

Believe me,
seeing how easy it is to describe the structure of a large project also makes scaling apps a enjoyable task.

## 6 - Workflows

Many projects depend on tools like [CocoaPods](https://cocoapods.org),
[SwiftGen](https://github.com/SwiftGen/SwiftGen),
or [Sourcery](https://github.com/krzysztofzablocki/Sourcery) to be run before opening the project.
If developers forget to run them,
they might end up getting errors.
They are sometimes obvious errors, like your `Podfile.lock` is out of sync,
but other times they are not.
Some teams decide to automate all these tasks using Fastlane lanes,
which calls underlying system commands:

```language-ruby
lane :bootstrap do
  cocoapods
  swiftgen
  sourcery
end
```

Installing the team's certificates and provisioning profiles is another example.
Many teams in the industry decided to use Fastlane for that,
but again,
we are putting the developer in the position of having to remember running `fastlane match`,
and knowing which certificates/provisioning profiles they need for the job at hand.

_What if if all those tasks where beautifully integrated into the process of generating a project?_
That's what Tuist aims for.
It determines which tasks need to be executed,
and executes them as part of the project generation.
The idea is the developer doesn't have to think about all of that.
They can just remember one and easy to remember command:

```language-bash
tuist generate
```

## 7 - Conflicts

Having many Git conflicts is perhaps one of the most annoying things of working on large Xcode projects.
The likeliness of having conflicts is proportional to the amount of people contributing to the project,
and in the case of Xcode,
to the size of the project.
Xcode projects have a monolithic structure;
most of their content lives in a file, the `project.pbxproj`.
Any change to the project through Xcode gets reflected in that file.

If there are many branches being merged in your project,
having to rebase often to solve git conflicts can be very annoying,
even more if the CI takes long every time we rebase and push the changes to remote.

Tuist diminishes the conflicts because Xcode projects don't need to be part of the repository.

## 8 - File patterns

Xcode projects have references to the files and folders that are part of it.
Because of that,
it was very common to end up with a project files and folders hierarchy that was inconsistent with the structure in the filesystem.
This has improved with the recent Xcode versions,
but it's still certainly annoying having to drag & drop files to the Xcode projects to use them from targets.

Tuist makes that way easier by using glob patterns.
Rather than individually referencing files,
we can define a glob pattern,
for example `Sources/**/*.swift`,
and Tuist will unfold the pattern and add the resolved paths to the project.
This makes it easier to define conventions in regards to the folders structure.
For example,
the example below is a function that ensures that all the targets,
regardless of the project they belong to,
have the sources in the same directory.

```language-swift
func target(name: String) -> Target {
  return Target(name: name,
               sources: "Sources/**/*.swift")
}
```

## 9 - CLI

Xcode provides `xcodebuild`, a command line tool to interact with the project.
Both,
its input and and output are so verbose that most developers wrap them with tools like [Gym](https://docs.fastlane.tools/actions/gym/) or [xcpretty](https://github.com/xcpretty/xcpretty).
Moreover,
there are common use cases like building, signing, and publishing the app to the App Store,
that require the interaction with other CLIs besides `xcodebuild`.
Most projects solve this issue by using [Fastlane](https://fastlane.tools/),
but that creates a new contract between the `Fastfiles` and your projects that can break easily,
and as a consequence,
present developers with failing lanes that they need to debug and fix.
_Have you ever experienced trying to release an app,
and running into issues because someone changed something in the signing settings of the project and forgot to update that lane that configures the environment for signing?_

Tuist knows your projects and will leverage that information to offer a simple set of commands.
Being positioned in a directory where there's a project defined,
I could execute something like:

```language-bash
tuist build
```

And that'd build all the targets from the project in the current directory.
If building requires installing CocoaPods dependencies,
or generating code for your resources using SwiftGen,
Tuist will do it as part of the command execution.
The idea here is removing the need of having to use a tool like Fastlane,
which in my experience,
results in complex Fastiles that grow proportionally with the number of Xcode projects.
Tuist embraces [KISS](https://en.wikipedia.org/wiki/KISS_principle).

## 10 - Caching

At some point in the growth of a projects,
build times start affecting developers' productivity.
They push code to GitHub and it takes over 20 minutes to compile.
We consider using [Carthage](https://github.com/Carthage/Carthage) to precompile the dependencies,
and that gives us a bit of breath that is insignificant compared to the compilation time of the project.
We heard that [Buck](https://github.com/facebook/buck) and [Bazel](https://bazel.build/) help mitigate the issue,
but our team is so small that we can't invest time and resources into replacing our build system entirely.
We hope for Apple to release new versions of the Swift compiler and magic flags that speed up our builds,
but that's being too hopeful;
they optimize for the majority of their userbase,
and that's small-medium sized apps.

One of Tuist's goals is to help with this need projects have when they scale.
The idea is very simple.
All the modules,
being a module a framework or a library,
are hashed,
compiled,
and uploaded to a cloud storage.
That's done for every commit that is built on CI.
When developers want to work with the project locally,
Tuist generates the dependency graph,
and generates the project by using pre-compiled modules for those targets that we don't plan to work on.
For instance,
let's say we have an App that depends on a dynamic framework `Search`,
which depends on another framework called `Core`.
Since we only plan to work on the app at the moment,
Tuist will give us a project hat contains a target with the source code of the app,
which links against `Search`,
and copies both `Search` and `Core` into the product directory.

---

All of that makes me very excited when I work on Tuist.
I believe working on a large Xcode project has to be as fun as working on small ones.
Over the years,
I've seen tools like Fastlane helping small/medium projects,
and tools like Buck and Bazel helping large ones,
but there's space in the middle of that spectrum where projects end up hacking their way through to scale.
I dream with the Rails for the development of apps using Xcode.
A tool that provides simple abstractions and makes it easier to enforce practices at any level of the project.

If that sounds exciting,
and would like to take part on this journey,
you can start by joining our [Slack channel](http://slack.tuist.io/) and reading [the documentation](https://docs.tuist.io).
