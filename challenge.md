# NuConta Marketplace

A Flutter app where users spend their NuConta balance on awesome products.

The app should interface with a GraphQL server on the following URL:

```
https://staging-nu-needful-things.nubank.com.br/query
```

And should be authorized with the following bearer token:

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhd2Vzb21lY3VzdG9tZXJAZ21haWwuY29tIn0.cGT2KqtmT8KNIJhyww3T8fAzUsCD5_vxuHl5WbXtp8c
```

The user should be able to see their balance and all the offers available to them.
Tapping on a offer should show a detailed view of the product and allow the user
to make a purchase. After a successful purchase, the balance should be updated.

A purchase however, can fail; if an offer is expired, or if the balance available
is insufficient, for instance. In any case, an error message should be displayed.

## Tips

- You can use introspection queries (http://graphql.org/learn/introspection/) to figure out the public API exposed by the GraphQL endpoint.
- You can use a http client with GraphQL support such as insomnia (https://insomnia.rest/) to interact and experiment with the endpoint.

## Final notes

You should deliver a git repository, or a link to a shared private repository on
github, bitbucket or similar, with your code and a short README file outlining
the solution and explaining how to build and run the code. Your solution should be written using Dart and Flutter toolkit

The solution must work correctly on both Android and iOS. If do not have access
to a Mac, you can use https://appetize.io to test the app on iOS.

You do not have to worry about the design of the interface, just keep it simple. Also,
you can keep all data in memory, there's no need to worry about client-side caching.

We also don't want to make you reimplement what already exists, so feel free to use any
libraries/frameworks that are available.

We will evaluate your code in a similar way that we usually evaluate
code that we send to production. Having tests that make sure your code works is a must.
Also, pay attention to code organization and make sure it is readable and clean.

Feel free to ask any questions, but please note that we won't be able to give you
feedback about your code before your deliver. However, we're more than willing to help
you understanding the domain or picking a library, for instance.

Lastly, there is no need to rush with the solution: delivering your exercise earlier than the due date
is not a criteria we take into account when evaluating the exercise: so if you finish earlier than that,
please take some time to see what you could improve. If you think the timeframe may not be enough
by any reason, don't hesitate to ask for more time.
