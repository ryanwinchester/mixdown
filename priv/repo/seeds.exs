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

alias Ecto.Changeset
alias Mixdown.Repo

Repo.transaction(fn ->
  user = Repo.insert!(%Mixdown.User{
    email: "test@test.com",
    username: "tester",
    name: "Testy McTesterton",
    password_hash: Comeonin.Bcrypt.hashpwsalt("password123"),
  })

  cat_gaming = Repo.insert!(%Mixdown.Category{
    name: "Gaming",
    slug: "gaming",
    description: "Video games and stuff",
  })

  cat_software = Repo.insert!(%Mixdown.Category{
    name: "Software",
    slug: "software",
    description: "Software and stuff",
  })

  tag1 = Repo.insert!(%Mixdown.Tag{
    name: "randomness",
    slug: "randomness",
    description: "Randomg things",
  })

  tag2 = Repo.insert!(%Mixdown.Tag{
    name: "cool stuff",
    slug: "cool-stuff",
    description: "Stuff that is super cool",
  })

  post_content = """
  This is some markdown content

  - Some
  - List
  - Here

  #### Code blocks

  Here is some elixir

  ```elixir
  defmodule Foo do
    def bar, do: "baz"
  end
  ```

  and how about some php?

  ```php
  <?php

  class Foo {
      function bar()
      {
          return "baz";
      }
  }
  ```

  1. Okay, maybe an ordered list
  2. Of stuff

  And how about some `inline code` element.

  ##### The End.
  """


  Repo.insert!(%Mixdown.Post{
    title: "Test Post",
    subtitle: "This is Super Awesome",
    slug: "test-post",
    user_id: user.id,
    is_published: true,
    published_at: Timex.parse!("2017-04-15", "{YYYY}-{0M}-{0D}"),
    content: post_content,
  })


  for i <- 1..20 do
    Repo.insert!(%Mixdown.Post{
      title: "Test Post #{i}",
      subtitle: "Something Great Here",
      slug: "test-post-#{i}",
      user_id: user.id,
      category_id: Enum.random([cat_gaming.id, cat_software.id]),
      is_published: true,
      published_at: Timex.parse!("2016-12-31", "{YYYY}-{0M}-{0D}") |> Timex.shift(days: i),
      content: post_content})
    |> Repo.preload([:tags])
    |> Changeset.change
    |> Changeset.put_assoc(:tags, [tag1, tag2])
    |> Repo.update!
  end

end)
