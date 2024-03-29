---
title: ViteJS and Rails
tags: ['vite', 'rails', 'open-source']
---

I recently had to set up a React frontend for a Rails app,
and I decided to use [ViteJS](https://github.com/vitejs/vite) instead of [Webpack](https://webpack.js.org/).
What's interesting about ViteJS is that in development,
it uses [ES modules](https://hacks.mozilla.org/2018/03/es-modules-a-cartoon-deep-dive/) instead of smashing all your Javascript into a single file because that's expensive and unnecessary during development.
When building for production,
it uses [ESBuild](https://github.com/evanw/esbuild) for generating a bundle.
Unlike the traditional Webpack setup that uses [Babel](https://babeljs.io/),
ESBuild is significantly faster because it's implemented in Go.

I have to say the process of setting it up was pretty straightforward thanks to [vite_ruby](https://github.com/ElMassimo/vite_ruby),
a Ruby Gem that eases the process of integrating the tool into Rails's asset pipeline.
Moreover, it provides [helpers](https://guides.rubyonrails.org/action_view_helpers.html) to add the necessary helpers to load the generated Javascript and CSS files.
The resulting configuration is leaner than its [Webpacker](https://github.com/rails/webpacker) counterpart and easier to reason about.
Vite is not as mature as Webpack,
but it's already got a good community of [plugins](https://vitejs.dev/guide/api-plugin.html) around it.
For example,
the [legacy plugin](https://www.npmjs.com/package/vite-plugin-legacy) takes the role of [@babel/preset-env](https://babeljs.io/docs/en/babel-preset-env) to polyfill our Javascript to support old browsers.
The [React plugin](https://github.com/vitejs/vite-plugin-react) can reload your component changes instantly to make your development experience smooth.

I really like the amount of utilities one gets when building for the web.
You can choose the one that works best for your project, and accommodate it thanks to the numerous APIs that they expose.
