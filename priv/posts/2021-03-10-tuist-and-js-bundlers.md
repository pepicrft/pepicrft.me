---
title: 'Tuist and JS bundlers'
tags: ['javascript', 'tuist', 'open source']
---

I think there are a lot of similarities between Tuist and JS bundlers.
First,
they both are functions that take input and return an output.
In the case of a JS bundler,
it takes Javascript or any variation of it,
and converts it into Javascript that is compatible with the target platform (e.g. browser).
In the case of Tuist,
it takes your project definitions, and generates an Xcode project that you can use to build your apps.
What's beautiful about putting a function in between,
is that it opens the door for optimizations and transformations that otherwise wouldn't be possible.
Javascript bundlers use it to transform code,
for example JSX syntax into plain Javascript,
or minifying the output Javascript so that it can be downloaded faster when users open a website.
What's great about those Javascript bundlers is that they all have the concept of plugins.
They allow developers participate in that transformation process with their own functions.
Tuist is no different.
We take you definition of projects and figure out what optimizations we can apply to ensure that the resulting Xcode project is fast in Xcode and compiles fast.
One of the transformations that we apply is caching.
We transform some of the targets into their binary representation.

The difference between the Javascript bundlers and us is that we don't allow developers to define their custom transformations.
Fortunately, that's going to change soon thanks to [plugins](https://tuist.io/docs/plugins/using-plugins/).
Developers will be able to encapsulate their transformations into a plugin that they'll be able to distribute to Tuist users.
How cool is that?
We took a very closed and monolith project format, `.pbxproj` files.
And we are turning it into a more open format that developers can extend and optimize.

This is the beauty of Tuist.
