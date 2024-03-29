---
title: 'Owning your workflows'
tags: ['tooling', 'software', 'developer productivity', 'javascripts']
---

The more I work with Javascript and Ruby,
the more I realize how empowering it is to design your workflows.
Having worked with Xcode and Swift for many years,
I was used to Apple dictating your working style.
_You need to debug an issue?_ This is how you do it.
_Is your app is not performing?_ Here's instruments to trace your app performance.
_Need to do something custom at build time?_ Here's a script build phase to extend the build process.

Sure, by doing that,
Apple has stronger control over the ecosystem,
and therefore,
over the developers' apps.
However,
there are situations when the proposed method doesn't work for your scale.
Then you need to come up with creative ways to accommodate Apple's processes to your needs.
An excellent example of that is replacing Xcode's build system with Bazel and figuring out how to get Xcode to compile with Bazel instead of using its build system.
The result of that setup looks more than a hack.
It's brittle.
One day it works; the day after, it doesn't.
And because Apple is so distant from many real challenges developers face,
they continue building around their utopian vision of app development.
That one where apps are small, a few targets, and dependencies are seamlessly distributed via Swift Package Manager.

The reality is far from that. The day-to-day is way more convoluted than what Apple thinks. And because Apple doesn't embrace that and provides more flexibility to customize processes, teams have no choice other than to wait for the next WWDC to see if Apple decides to tackle the issues they are facing.

In Javascript,
you can choose your build tool.
You feel like using [Webpack](https://webpack.js.org/)? Go for it.
Is it too slow? You can use alternatives like [esbuild](https://github.com/evanw/esbuild).
You need to lint some code? There's [eslint](https://eslint.org/).
Don't you have the rule that you need? You can implement [your custom rules](https://www.kenneth-truyers.net/2016/05/27/writing-custom-eslint-rules).
You need to generate code at build time? You can use Babel and [implement your own macros](https://github.com/kentcdodds/babel-plugin-macros).
Would you love to extend VSCode's interface to show useful debugging information? You can use the [Extension API](https://code.visualstudio.com/api).

And because of all of that,
Ruby and Javascript are excellent as general-purpose programming languages,
while Swift remains that language for building apps for Apple's ecosystem that dreams of becoming something more than that.
