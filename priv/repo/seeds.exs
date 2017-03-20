# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mixdown.Repo.insert!(%Mixdown.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Mixdown.Repo

user = Repo.insert!(%Mixdown.User{
  email: "test@test.com",
  username: "tester",
  name: "Testy McTesterton",
  password_hash: Comeonin.Bcrypt.hashpwsalt("password123"),
})

Repo.insert!(%Mixdown.Post{
  title: "Test Post",
  subtitle: "Something Great Here",
  slug: "test-post",
  user_id: user.id,
  is_published: true,
  published_at: Timex.parse!("2016-12-31", "{YYYY}-{0M}-{0D}"),
  content: """
This is some markdown content

- Some
- Stuff
- Here

```elixir
defmodule Foo do
  def hello_world, do: "hello world!"
end
```

""",
})

Repo.insert!(%Mixdown.Post{
  title: "Test Post 2",
  subtitle: "This is Super Awesome",
  slug: "test-post-2",
  user_id: user.id,
  is_published: true,
  published_at: Timex.parse!("2017-01-15", "{YYYY}-{0M}-{0D}"),
  content: """
This is some more markdown content

- Some
- Stuff
- Here

```elixir
defmodule Foo do
  def hello_world, do: "hello world!"
end
```

""",
})
