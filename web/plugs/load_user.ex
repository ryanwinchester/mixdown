defmodule Mixdown.Plugs.LoadUser do
  import Plug.Conn

  alias Mixdown.Auth
  alias Mixdown.Repo

  def init(default), do: default

  def call(conn, _options) do
    assign(conn, :user, Auth.user(conn))
  end

end
