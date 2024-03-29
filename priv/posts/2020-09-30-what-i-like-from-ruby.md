---
title: What I like from Ruby and Rails
tags: ['ruby', 'rails', 'development']
---

The more I use Ruby and Rails, the more I like it. I’ve played with [Typescript](https://www.typescriptlang.org/) lately, and it continues to feel heavy: _parenthesis and brackets everywhere, layers on indirection through tools to accommodate the Javascript to the browser or to your preferred way of writing it._ It's a powerful programming language but it doesn't spark the same joy that Ruby does.

[Ruby](https://www.ruby-lang.org/) is lean. There’s an interpreter in your system that you pass your code to. [Bundler](https://bundler.io/) ensures that the directories of your dependencies are loadable and that’s it. No [Babel](https://babeljs.io/), [Webpack](https://webpack.js.org/), Typescript.... It simply works. That’s what you want at the end of the day, not spending time figuring out issues or how to configure underlying tools.

The only reason why I’d use Javascript is to be able to describe a website using [React](https://reactjs.org/)’s approach to represent states and encapsulate dynamic behaviors through [hooks](https://reactjs.org/docs/hooks-intro.html). That’s why I use [Gatsby](https://www.gatsbyjs.com/) for creating statically generated sites over alternatives like [Jekyll](https://jekyllrb.com/), or the so-talked-about in the Swift community, [Publish](https://github.com/JohnSundell/Publish), that would lock myself to Xcode.

Going back to Ruby and Rails, **what do I like about it?:**

- I only need the interpreter and the dependency manager to run a project.
- I can write tests in plain Ruby classes and using the language’s standard library.
- Bundler’s approach to structure dependencies is more sensible and prevents the “delete node_modules” issues.
- There’s less library fatigue. There are fewer options that are better tested, and that makes deciding for a dependency easier.
- Being able to open a Rails console in a remote server with ActiveRecord models loaded is damn amazing.
- Thanks to its dynamism, you can build plugin systems that otherwise wouldn’t be possible with statically compiled languages like Swift.
- Companies like Shopify are using it at scale, and IT WORKS. Some internal tooling to support the scale leverages the dynamism of the language.
- The language and its ecosystem feels more harmonious. Working with Javascript is sometimes stressful because sometimes you need to go deep into an endless rabbit hole of patches over patches.

This is my preferred stack when building software these days:

- **Static websites:** GatsbyJS with Typescript
- **CLI tools:** Swift if it's for macOS environments, and Ruby otherwise.
- **Apps for Apple platforms:** Swift (I'm planning to learn SwiftUI at some point).
- **Web APIs:** Ruby on Rails.

And you? What language/technology do you like the most and why? Let me know on Twitter [Twitter](https://twitter.com/pepicrft).
