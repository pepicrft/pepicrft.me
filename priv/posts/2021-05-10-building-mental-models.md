---
title: Building mental models
tags: ['buildify', 'open-source']
---

As you probably know,
I started building [Buildify](https://github.com/buildifydev),
an open-source and AGPL-3-based tool for deployments.
Like I did with [Tuist](https://tuist.io),
I'm in the process of building mental models around the business domain.
It's one of the hardest steps,
and the most important one for the viability of the project.
If those models are not solid enough the application might become unusable,
and if it's not flexible enough it might limit the development of future features.

As I keep thinking about the problem, some ideas are starting to emerge.
For example, providers like [Google Cloud](https://cloud.google.com) and [AWS](https://aws.amazon.com),
offer a serverless solution for containarized apps.
In other words, you can provide them with your Rails application in a Docker image and they'll take care of scaling the resources are needed.
This simplifies things a lot on our side because we are mostly responsible for building deployable artifact that can then be handed over to the cloud provider.
For long-running services those deployable artifacts will be Docker images.
In the case of lambda functions and static websites it'll be a tar file containing the HTML, JS, and CSS following a conventional structure.
And for mobile apps, it'll be the Android App Bundle or app archive without signing.
The signing will be done server-side.

I'm also planning to abstract away the provider through an interface.
That way contributors can add support for more cloud providers.
Looking at Google Cloud and AWS,
they both have similar offering,
but with different names.
The initial version will have the implementation for AWS.
Since AWS offers Mac minis,
we can use those to run certain tasks that can only run in macOS environments,
like signing an iOS app.

A tool, `buildify-runner`,
will take care of running deployment tasks.
I'll write it in Rust so that it can be run in any hosts without requiring anything else to be installed in the system.
It'll pull the build [DAG](https://en.wikipedia.org/wiki/Directed_acyclic_graph),
and execute it trying to parallelize as much as possible.
For example,
when deploying a [RedwoodJS](https://redwoodjs.com/),
the runner will install the NPM dependencies,
and build the static files and the functions separately.
For reproducibility reasons and stability,
the runner will use [Nix](https://nixos.org/).
Thanks to that, we get caching of dependencies out-of-the-box.
I believe using a tool like Nix for setting up the environment will be crucial for providing a great developer experience.

The concept of previews that got popularized by platforms like [Netlify](https://netlify.com) and [Vercel](https://vercel.com),
will be present in Buildify too but with some enhancements.
It'll work with databases and mobile apps too.
In a nutshell,
we'll create disposable databases whose lifecycle is tied to the lifecycle of a repository branch.
When the branch gets merged or becomes stale,
the database will be dropped automatically.

The process of onboarding new apps must be as seamless as possible.
People that have never deployed a project before should have a running app without having to familiarize themselves with infrastructure and deployment concepts.
To achieve that,
the runner will have a command for cloning a repo,
parsing its content,
and reporting to the backend all the projects found in the repository.
For example,
if it's a Rails app,
Buildify will detect it and create the database and a Redis instance for being able to run background jobs.

And last but not least,
because my background is mainly mobile development and tooling,
I think this platform should work for mobile apps too.
The release process will be a bit different though because continuous deployment cannot be extrapolated to mobile apps.
In this case we'll use release branches where each commit will represent a releasable candidate that can be uploaded to the App Store and Google Play Store.

I'm very excited to kick off this project.
I've been reading a lot lately about projects like [Ghost](https://ghost.org/) and [Plausible](https://plausible.io/),
whose revenue is re-invested in the project to make it better and continue to help their users.
I feel we need to take back from VCs the problem of easing deploys,
and build a community-driven and open-source project that goes hand in hand with those great open-source web frameworks that we've seen over the years.

As you can imagine,
I'll be less active on [Tuist](https://tuist.io),
although I'll continue to provide advice and direction on the project.
