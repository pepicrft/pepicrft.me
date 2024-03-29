---
title: The exciting adventure of building a web app
tags: ['saas', 'web app', 'rails', 'react']
---

I’ve been playing lately with building a web app that complements [Tuist](https://tuist.io) with some features that require storing state in a server. Since I have a mobile development background, being familiar with Swift, iOS, and very recently React Native, I’m learning a lot along developing both a web app and a backend that exposes a GraphQL API. This blog post is me reflecting on what I’ve learned so far from the technology choices we’ve made.

For the backend, I chose [Rails](https://rubyonrails.org/). It’s easily deployable to [Heroku](https://heroku.com) by simply doing a `git push`. Moreover, I can use a programming language that I love a lot, Ruby, and save a lot of time by adding dependencies that bring functionality that otherwise I’d have to implement myself - we use [Devise](https://github.com/heartcombo/devise) for authentication, [Rolify](https://github.com/RolifyCommunity/rolify) for defining roles, and [CanCanCan](https://github.com/CanCanCommunity/cancancan) to codify permissions when accessing models.

The API is GraphQL. We use the [Ruby GraphQL gem](https://github.com/rmosolgo/graphql-ruby) that makes it so easy to define a schema and translate it to internal business logic. Unlike standard Ruby applications that tend to put the logic in models or controllers, we are using the [service pattern](https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial) heavily. Every unit of business logic is defined in a service that takes the necessary input, performs the operation, and either returns a value or raises an error. That makes those units easy to reuse from other components like controllers. As a result, our models are very lean; they only contain validations and a few callbacks to automatically populate some fields.

I like this setup because I’m learning a lot about GraphQL. I have to say I can’t imagine myself doing REST APIs anymore. There’s one thing that I’d like to read more about, and that’s how to solve the N+1 issue when running queries because, with the GraphQL approach, it’s more likely to happen.
However, it’s not an issue right now if we consider that the amount of data we are sending is minimal and the queries relatively easy.

We only use Rails server-side rendering solution, [ERB](https://guides.rubyonrails.org/layouts_and_rendering.html), for the authentication workflow because it’s provided by Devise out of the box. For everything else, we moved the rendering to the client-side by using [React](https://reactjs.org/) for describing the views and [Apollo](https://www.apollographql.com/) to interact with the GraphQL API and cache the responses. It provides a lovely hooks-based interface that makes interacting with the API a pleasure. Moreover, with use a code generation tool that turns our GraphQL queries and mutations into Typescript code, so we don’t have to write network code at all. Thanks to that, our focus on the frontend is on what data to fetch and how to represent it.

Last but not least, we are styling the UI using [TailwindCSS](https://tailwindcss.com/). Ever since I came across it for the first time, I’ve been using it in every project that involves styling HTML. Styles are applied through classes with semantic meaning, limiting each attribute to a limited set to value. Thanks to it, it’s easier to achieve visual consistency that otherwise wouldn’t be possible if we had to pick values for every new HTML element. And that goes without mentioning the relief of not having to think about naming classes. I got a license for [TailwindUI](https://tailwindui.com), which provides a set of beautiful components built upon TailwindCSS.

I'm enjoying and learning a lot during the process of building this web app, and I'm taking the opportunity to learn about **designing for the web**: patterns, semantic hierarchies, how to create components that look clean and modern.

Do you have experience building web apps? If you don't mind sharing your stack, I'd love to hear about it on [Twitter](https://twitter.com/pepicrft).
