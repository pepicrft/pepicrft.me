---
title: "If a business can be open source, it'll be open source"
description: "In this blog post I share why open source businesses are the most thriving and long-lasting companies."
tags: ["OSS", "Business"]
redirect_from: /blog/2025/04/24/open-source-business
---

If you’ve been following me for a while, you might already know that I’m a huge advocate of open source. My relationship with it has evolved as the project gained popularity, most recently becoming the foundation upon which we are building an open core company. In this post, I’d like to share what’s so special about it and why I believe it’s the foundation for building the most thriving and long-lasting companies. Let’s dive right in.

## What is open-source?

Open source is a philosophy of releasing software that embraces a set of principles to grant users more freedoms than their closed-source counterparts. The definition of open source is maintained by the [Open Source Initiative (OSI)](https://opensource.org/), which determines which licenses comply with it. These licenses include a series of clauses that the distributed software must follow. Some are very permissive, like the [MIT license](https://opensource.org/license/mit), which only requires you to credit the project, while others, like the [AGPL](https://en.wikipedia.org/wiki/GNU_Affero_General_Public_License), fall into a copyleft category, requiring your distributed software to adopt the same license.

Much of the software and infrastructure we build today runs on open source. From the many [Shopify](https://www.shopify.com/) stores powered by [Ruby on Rails](https://rubyonrails.org/) to the countless servers in data centers running Linux-based distributions, it’s everywhere. From a business perspective, it’s a tool to reduce costs and attract developers. For developers, it’s an altruistic endeavor and a way to build their resumes.

Open source is unique because when people gather to create something for fun, wonderful things can happen—especially when contributors join from around the world. [Linus Torvalds](https://de.wikipedia.org/wiki/Linus_Torvalds) explored this in his book [*Just for Fun*](https://www.goodreads.com/book/show/160171.Just_for_Fun). The challenge, however, is that doing something for fun often requires a financial safety net, which many lack. If you’re fortunate enough to have spare time after work, you might dedicate some to it. Doing so as part of your full-time job is rare, and it can even backfire—you might be hired for the reputation your open source project brings, only to be told you can keep working on it in your free time. I’ve seen examples of this already, but I’ll save that for a future post.

If your project succeeds, you might find yourself grappling with the economic dynamics of open source. This can feel uncomfortable, as if you’re betraying your community by not initially sharing that it could become the foundation for a business. Money is something everyone needs to make a living, yet it’s a topic we often shy away from—especially in the context of a project that was open and “free.” But in many cases, monetization is necessary to avoid burnout or letting the project stagnate.

As a developer, business is often framed around sustainability, but what about from a founder’s or business-oriented perspective? What makes open source companies so unique?

## Building thriving & long-term businesses

In a traditional business—tech or otherwise—the production and capture of value strongly correlate with your investment in your workforce (human or AI) or marketing campaigns. Moreover, the diversity of ideas is limited to the diversity of talent within your organization. For global companies, this can be complicated, so many restrict themselves to the country where their legal entity is based, significantly limiting diversity. This is why so many founders are keen on creating a “network effect”—a topic I’ll explore in future articles. Value capture often balloons due to social dynamics, as we are status-seeking creatures.

Open source changes that. The talent pool becomes the entire world. GitHub laid the foundation for this by offering free services to open source projects and recently even made [GitHub Copilot agents](https://github.com/features/copilot) available to review code, further reducing the investment needed to maintain the open source layer.

This has several implications. First, it diversifies ideas. Friction is removed from proposing solutions and sharing problems—it’s just an issue away. Second, developers enjoy contributing to open source, and that excitement naturally evolves into a network effect. If you don’t believe me, look at how people gather worldwide to discuss the open source project Supabase. Finally, your brand can outshine competitors through developers’ appreciation of your contributions to the commons, fostering more innovation in your business domain.

## Rethinking business with open-source

If you come from a traditional business background, opening up one of your assets might seem daunting. But trust me—despite how scary it sounds, you can dominate a market with it. Look at [Grafana](https://grafana.com/) if you need proof.

This clicked for me recently after watching [a talk by the CEO of Penpot](https://www.youtube.com/watch?v=gyog9RJ2jHs&t=3100s), Pablo Ruiz-Múzquiz, who discussed the business model they’re embracing for their open source project. Businesses are about producing value and capturing some of it back. Closed-source companies focus on capturing as much value as possible—especially when they hit a ceiling and struggle to produce more. This is why many are excited about AI: it opens new opportunities to create and capture value. Producing more value requires creativity and innovation, which can stall if you’re limited to your internal talent pool. That’s why you see CEOs pushing their teams to experiment with AI. It’s more involved than that, though—it requires a culture of innovation and experimentation, something open source communities excel at.

In contrast, open source captures little to no value compared to closed source. However, it can produce significantly more. Even if you capture less, the net gain is often higher than that of closed-source counterparts. Plus, your ability to produce new forms of value is far more agile. This is why more businesses are embracing open source foundations with curiosity, challenging well-established industries.

Capturing value requires drawing a line—what will people pay for? If you study open source companies or watch the Penpot talk, you’ll see several models. Choosing one depends on your product’s nature and the company you want to build. Some charge for services; others, like Sentry, charge for hosting because self-hosting is complex. Most people prefer paying for expertise—and supporting the project—over managing it themselves. This model often leads to fairer pricing, as exorbitant rates would drive users to self-host or spawn competing hosting services, undermining your business.

## The 20/80 principle

The [Pareto principle](https://en.wikipedia.org/wiki/Pareto_principle) can help you decide where to draw the line. In companies, 80% of revenue often comes from 20% of customers. This is why many products eventually focus heavily on B2B offerings—large enterprises have the capital and willingness to pay for tailored solutions. With this in mind, you can use the principle to determine what should be paid: the needs of large enterprises.

Where that line falls depends on your customer. At Tuist, we’re still figuring ours out. Some draw it between simple and advanced features, like [GitLab](https://gitlab.com/), which offers community and enterprise versions. Paid features might include single sign-on, for example. [Cal.com](https://cal.com/) follows a similar model, often placing enterprise features in a separate directory (e.g., `/ee`) with a different license. It’s still open, but hosting it requires payment—otherwise, you’d face legal liability.

In other cases, value lies not in the software but in the infrastructure. Take Supabase: the complexity is in running and scaling databases automatically, so you don’t have to think about it. This only works if your project’s nature aligns—for instance, [Tuist](https://tuist.dev/) is easy to host, so this model would jeopardize our business.

Some opt for licenses outside OSI’s definition. [Sentry](https://sentry.io/), for example, proposed the Fair license, which restricts competition to protect against free-riders. While complex hosting might deter individual users, it’s trivial for giants like [AWS](https://aws.amazon.com/) or [Google Cloud](https://cloud.google.com/gcp), who could outscale you. We nearly faced this with Bitrise offering caching for Tuist as a service. The downside? Non-OSI licenses—or projects requiring a [Contributor License Agreement (CLA)](https://en.wikipedia.org/wiki/Contributor_License_Agreement)—may deter developer contributions, as they feel less “open.”

One intriguing model is [Penpot](https://penpot.app/)’s Open Nitrate Model, which embraces “charging the controller.” Instead of gating advanced features, they believe everyone should access them, and you only pay for a certain level of control. It’s called the Open Nitrate Model because a feature becomes paid if you can answer “No” to these three questions (forming a “NO3” element):

1. Will this capability limit new users from discovering and using Glossia?
2. Will this capability particularly benefit advanced users?
3. Is this capability relatively trivial to build?

The paid version is a closed-source extension of an extensible open source foundation—first by you, then by anyone else interested.

## Let's talk about the 20%

What about the 20% who self-host and don’t pay? That might feel uncomfortable, right? But here’s the thing: they wouldn’t have paid anyway. Instead, they contribute differently—sharing ideas, reporting bugs, fixing issues, and spreading the word. Not all contributions are financial, and these are incredibly valuable. They’re what set you apart from competitors. For those from traditional business backgrounds, this is the hardest shift. When you view everything through a financial lens, non-paying users seem illogical. But in tech, intangible contributions often outweigh everything else.

## Some things you should keep in mind

Regardless of the model you choose—which depends entirely on your context—here are a few key considerations.

First, over-communicate your thinking about the open source side, the community, and the business. The more transparent you are, the better your decisions will be received. At Tuist, we waited too long to socialize our maintenance struggles. By the time we proposed building a business to sustain the project, some didn’t like it. Even with clear communication, there’ll be churn—and that’s okay. Free is always better, but a dedicated team improving the project daily is even more valuable.

Second, own your trademark. In an open source company, much of your intangible value ties to your brand and community. Protect this asset to prevent free-riders from exploiting it. While code can be forked, building a brand and community takes years and can’t be easily replicated.

## Closing words

In the coming years, I believe we’ll see more open source businesses offering alternatives to closed-source incumbents. They take longer to establish, requiring community and brand-building through human interaction—no shortcuts there. Supabase is an impressive example of rapid community growth, but it’s an outlier. Ever heard the saying, “If something can be built in JavaScript, it’ll eventually be built in JavaScript”? I think the same applies to open source: if a company *can* be open source, it *will* be. The longer you delay embracing it in your domain, the more disruptive the open source alternative will be when it arrives.
