defmodule Mixdown.User do
  use Mixdown.Web, :model

  schema "users" do
    field :email, :string
    field :username, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :name, :username, :password_hash])
    |> validate_required([:email, :name, :username, :password_hash])
  end
end
