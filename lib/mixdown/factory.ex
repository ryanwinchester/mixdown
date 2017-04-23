defmodule Mixdown.Factory do
  use ExMachina.Ecto, repo: MyApp.Repo

  def post_factory do
    %Mixdown.Post{
      title: "Test Post",
      subtitle: "Something Great Here",
      slug: "test-post",
      # user_id: user.id,
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

        """}
  end
end
