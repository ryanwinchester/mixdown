defmodule Mixdown.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Guardian.Plug, only: [sign_in: 2, sign_out: 1, current_resource: 1]
  import Plug.Conn, only: [put_resp_header: 3]

  alias Mixdown.Repo
  alias Mixdown.User

  @doc """
  Attempt to log a user in.
  """
  def attempt(conn, email, password) do
    user = Repo.get_by(User, email: email)
    cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, login(conn, user), user}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  @doc """
  Log in the user.
  """
  def login(conn, user) do
    sign_in(conn, user)
  end

  def logout(conn), do: sign_out(conn)
  def user(conn), do: current_resource(conn)

  @doc """
  Add the Authorization token to the header.
  """
  def add_auth_header(conn, _params) do
    jwt = Guardian.Plug.current_token(conn)
    put_resp_header(conn, "authorization", "Bearer #{jwt}")
  end

  @doc """
  Get the current token.
  """
  def get_token(conn) do
    Guardian.Plug.current_token(conn)
  end
end
