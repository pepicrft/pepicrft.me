---
title: Generating Typescript code from a GraphQL schema
tags: ['graphql', 'typescript', 'api']
---

Today, I learned about a tool called [GraphQL Code Generator](https://graphql-code-generator.com/) turns a GraphQL schema into typed models and utilities for interacting with a GraphQL API. In my case, I'm using it in a React application where I'm using [Apollo](https://www.apollographql.com/) as the client. Using the tool is as simple as adding a configuration YAML at the root of the project:

```yaml
schema: schema.graphql
generates:
  app/javascript/graphql/types.ts:
    documents: 'app/javascript/**/*.graphql'
    plugins:
      - typescript
      - typescript-operations
      - typescript-react-apollo
    config:
      reactApolloVersion: 3
```

And then running `yarn graphql-codegen`. The tools outputs a `.ts` that contains all the necessary code for interacting with the API. For example, the snippet below shows how to fetch the current user by using the generated code:

```language-jsx
import { useMeQuery } from 'graphql/types';

const MyComponent = () => {
	const { data, loading, error } = useMeQuery();
	return <div>{data}</div>;
};
```

In the past are those days with Objective-C and Swift when I had to write the client-side models manually using the API documentation. Who wants to do that again after seeing such a powerful workflow? By the way, Shopify has a similar tool that generates models in Swift & Kotlin - it's called [Syrup](https://github.com/shopify/syrup) and it's open source.
