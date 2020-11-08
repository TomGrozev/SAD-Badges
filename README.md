# Badges

## Dev

To run locally, elixir needs to be ialled which can be found at [Elixir Install Instructions](https://elixir-lang.org/install.html).

To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Production / No Dependencies

To run in production, simply run the following commands:
(Make sure docker is running, also may need to run commands as root if docker is running as root).
```sh
$ chmod +x build.sh
$ ./build.sh
$ docker-compose up
```

For the nginx proxy server in another shell:
```sh
$ cd nginx
$ docker-compose up
```

Now you can access the website at `http://127.0.0.1`

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
