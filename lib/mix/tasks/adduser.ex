defmodule Mix.Tasks.Mixdown.Adduser do
  use Mix.Task

  alias Mixdown.Repo
  alias Mixdown.User

  @shortdoc "Create a new mixdown user."

  def run(_args) do
     Application.ensure_all_started(:mixdown)
    create_user %{
      email: get_input("email: "),
      username: get_input("username: "),
      name: get_input("full name: "),
      password: get_input("password: ")}
  end

  defp create_user(params) do
    %User{}
    |> User.registration_changeset(params)
    |> Repo.insert!
  end

  defp get_input(prompt \\ "") do
    prompt
    |> IO.gets
    |> String.trim
  end

end