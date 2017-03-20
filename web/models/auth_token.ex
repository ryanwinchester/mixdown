defmodule Mixdown.AuthToken do
  use Mixdown.Web, :model

  alias Mixdown.Repo
  alias Mixdown.Auth.Serializer

  @primary_key {:jti, :string, []}
  @derive {Phoenix.Param, key: :jti}

  schema "auth_tokens" do
    field :aud, :string
    field :iss, :string
    field :sub, :string
    field :exp, :integer
    field :jwt, :string
    field :claims, :map

    timestamps()
  end

  def for_user(user) do
    case Serializer.for_token(user) do
      {:ok, aud} ->
        (from t in Mixdown.AuthToken, where: t.sub == ^aud)
          |> Repo.all
      _ -> []
    end
  end
end
