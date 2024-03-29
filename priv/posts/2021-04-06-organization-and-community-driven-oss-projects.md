---
title: Community-driven and organization-driven open source
tags: ['apple', 'open source', 'rust', 'cargo', 'swift']
---

Yesterday,
while reading about [Rust](https://www.rust-lang.org/) and its package manager,
[Cargo](https://crates.io/),
I realized how diverse the list of Crates _(packages)_ for building CLIs is compared to Swift,
and made me think about the connection between that and how Rust and Swift are driven.

On one side there's **Apple**,
a large business whose final goal is to sell hardware.
They announced Swift and everyone got excited not only because it was a new and more modern programming language,
but because it was open source.
Since then,
we've seen more open source work coming from Apple:
_[swift-log](https://github.com/apple/swift-log),
[swift-metrics](https://github.com/apple/swift-metrics),
[swift-nio](https://github.com/apple/swift-nio),
and [swit-collections](https://github.com/apple/swift-collections)._
It's great to see work being done in the open,
the community gets excited about it,
but the one who steers the boat is Apple,
and the ultimate decision on what goes into Swift is made by Apple and not the community.
There's nothing wrong with it.
It's just another approach to open source where there's a business that needs a strong ownership to ensure the open source work supports the business.
The caveat though is that the community around it doesn't flourish as much as it'd do in community-driven projects like Rust.
Everyone is hoping for that next thing that will solve their problems and help them with their needs.
Reactive programming is not new in Swift,
yet they made everyone think [Combine](https://developer.apple.com/documentation/combine) is the way.
Nowadays, no one thinks about exploring new reactive programming approaches.
Similarly,
no one thinks about exploring new solutions to package management.
In fact, we are neglecting community work done in the past.
This inevitably leads to a slightly authoritarian open source environment where diversity can't find its space.

On the other side, Rust is entirely [community-driven](https://www.rust-lang.org/governance).
Even though it was born within Mozilla,
it became a community project.
Because of that,
there are plenty of utilities, packages, and resources to build great software upon it.
One might see such large list of options as something negative,
but I'm getting to appreciate after having done years of Swift and iOS development.
It's easy to find a community utility that suits your needs best,
or explore new alternatives because the project welcomes those.

I think both are valid approaches with understandable motivations behind them.
Personally, I'm enjoying a lot the freedom more community-driven projects like Rust, Javascript, and Ruby provide.
