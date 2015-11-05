# Week 6

We are going to continue our flight arrivals board by adding OAuth login functionality and credit card processing.

Do the usual dance (`bundle install`, `rake db:setup`, etc.) to get going.

Together in class, we will try to accomplish the following:

1. Let users sign in with Twitter (or another OAuth-compliant provider)
1. Let Javascript clients access our API

### OmniAuth

* https://github.com/intridea/omniauth
* https://dev.twitter.com
* https://dev.twitter.com/overview/documentation
* https://dev.twitter.com/rest/tools/console
* https://github.com/intridea/omniauth/wiki/List-of-Strategies

STEP 1: Register Your App (Twitter Example)

1. Register your app: https://apps.twitter.com/
1. Use this as your callback url: `http://127.0.0.1/auth/twitter/callback/`
1. Find your API Keys.  You'll need them in the next step.

STEP 2: Prepare your application to use OAuth (Twitter Example)

1. Create a Rails initializer file in order to configure your API key settings.
1. Setup environment variables on your machine instead of hardcoding the API keys.

Refer to https://github.com/intridea/omniauth

STEP 3: Setup an HTTP callback

`get '/auth/:provider/callback', to: 'sessions#create'`

When the `create` action is triggered, you can retrieve the user's information:

`request.env['omniauth.auth']`

If your provider uses `POST` to call you back, Rails will expect a form authenticity
token.  You can suppress this requirement in your `SessionsController` with:

`# skip_before_action :verify_authenticity_token, only: :create`

* https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema

STEP 3: Local Database Management

Once you have the user's login information:

* Is this the first time this user has accessed your app? If so, store the user's unique
identifier in your database. This is the "Sign Up" scenario.
* Does this user's unique identifier already exist in your database? If so, this is the "Sign In" scenario.

STEP 4: Error Handling

Try running through the OAuth flow to trigger different kinds of error cases, and make sure your code can handle them.


### CORS

Here's how to add headers to your HTTP responses in Rails.

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
