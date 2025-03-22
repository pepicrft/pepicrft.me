---
title: "Tuist is evolving"
description: "In this blog post I talk about how Tuist is evolving and how some mental models are transitioning."
tags: ["Tuist", "Business", "Open Source"]
---

As we continue to build a company around [Tuist](https://tuist.dev) to build more open source sustainably, we are transitioning mental models that solidified in the minds of developers. It’s a natural part of evolving a product, but it might be confusing if you are not close to the evolution. Here’s a summary of what’s happening:

- Tuist is not just a project generator. Project generation is one of the solutions that we offer along many others. **We see project generation as a component**–a commodity that we might extract from Tuist once we have the resources to execute on it.
- The CLI is becoming more of a frontend to a development platform, but it’ll not be the only one. There’s a web-based dashboard and a macOS app, and thanks to our [documented REST API](https://tuist.dev/api/docs) other frontends might emerge.
- We are removing the dependency on generated projects to benefit from the Tuist solutions. Our long-term goal is that **you can plug Tuist into your Xcode projects or Swift packages as they are.**
- Our focus continues to be on development productivity, although there are early thoughts about supporting teams more directly with the quality of the apps that they build. We are also expanding our focus to support developers from the moment they have an idea, until they publish it on the store.
- We started with a strong focus on the Apple ecosystem, but the problems that we solve span other ecosystems, so we might expand onto Android, React Native, and Flutter in the near future.
- There continues to be an appetite to make the server code source available. We might execute on it if the business thrives. We believe this model will lead to shaping the best and more diverse solution in the space.

Tuist will look more like [Vercel](https://vercel.com) or [Expo](https://expo.dev). Because developers will expend a lot of time in the dashboard understanding, interacting, and optimizing their development, we deem crucial to provide them with the best experience there. Therefore we are designing a beautiful design system, Noora, that all the features will build upon. We want to build the best DX and most beautiful developer tool for all developers, while building a company around it that embraces innovation and openness in ways that we haven’t seen before in the ecosystem.
