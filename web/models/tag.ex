defmodule Mixdown.Tag do
  use Mixdown.Web, :model

  schema "tags" do
    field :name, :string
    field :slug, :string
    field :description, :string

    many_to_many :posts, Mixdown.Post, join_through: "posts_tags"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :slug, :description])
    |> validate_required([:name, :slug])
  end
end
