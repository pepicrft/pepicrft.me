---
title: 'The beauty of a standard command line interface'
tags: ['reaxt-native', 'open-source', 'mobile']
---

There's something beautiful in entering a directory that contains a project and knowing how to interact with it.
It's like being part of a communication where the terminal is the channel and you both know the language.
You know that **build** will turn your code into binary,
that **test** will validate that your code does what's supposed to do,
and **run** will show you what the code does.
Since all the projects speak the same language, you can move between projects freely and being able to interact with them seamlessly.

Unfortunately, such beauty hasn't existed for years in the Swift community.
[Fastlane](https://fastlane.tools) gives you the tools to define the lanuage;
you get words, but you are the one coming up with the language.
The reality has proved that defining a coherent language while building an app it's not easy.
Teams end up with complex and hard to optimize logic that is a nightmare to maintain.
It's not Fastlane,
their building blocks are great,
but their approach naturally leads to this.

When people ask me why [Tuist](https://tuist.io) provides now commands like **build** and **test**,
my answer is simply that there's the need in the Swift community for a different approach to interact with projects.
An approach where we write the language, we make it simple and enjoyable to use, and you focus on building great apps.

You describe us the projects, and we do the rest.
