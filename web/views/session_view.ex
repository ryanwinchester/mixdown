defmodule Mixdown.SessionView do
  use Mixdown.Web, :view

  def get_token(conn) do
    Mixdown.Auth.get_token(conn)
  end
end
