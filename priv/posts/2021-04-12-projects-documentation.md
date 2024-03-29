---
title: Migrating documentation to Docusaurus
tags: ['documentation', 'writing']
---

Writing a project's documentation is not as exciting as coding,
but over the years I got to understand the key role of documentation in the developer experience.
Shopify for instance has a team dedicated to maintain our internal documentation ensuring it's well structured and navigatable.

Tuist's documentation website was built as part of Tuist's website,
which is developed using [Gatsby](https://www.gatsbyjs.com/),
and it grew a lot since then.
Because we haven't had a person dedicated to overview the evolution of the documentation,
we ended up with a lack of cohesion and hard-to-navigate documentation.
Developers have a hard time finding what they need,
and getting started on the project.

For that reason,
I set out to improve the documentation website.
As a firm believer of choosing the right tool for the job,
I took the opportunity to move the documentation to [Docusaurus](https://docusaurus.io/),
a [React](https://reactjs.org/)-based utility implemented by Facebook to create static documentation websites.
It provides all the features that we need: [MDX](https://mdxjs.com/), [code snippets](https://docusaurus.io/docs/markdown-features/code-blocks), [search](https://docusaurus.io/docs/search). For the past weeks, I've been working on moving the documentation over to the new website, which is available at https://docs.tuist.io.
As part of the process I set up redirects from `https://tuist.io/...` URLs to the new ones, and fixed a handful of broken links.
It's looking great so far. I'm waiting for Algolia DocSearch's response to enable search on the website.
Once everything is moved over,
I'll work on adding a tutorial along the lines of what [RedwoodJS](https://learn.redwoodjs.com/docs/tutorial/welcome-to-redwood/) does.
It'll be useful for developers that come across the project and decide to give it a shot.
The tutorial will guide them through most important Tuist features that they should be aware of.

It's amazing everything React enables. Trying to achieve this with other static site generators would have taken way more work and the result wouldn't have been the same.
If you have a project that needs documentation, you should definitively consider Docusaurus, even if you have no prior experience on React.
