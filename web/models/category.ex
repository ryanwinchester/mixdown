defmodule Mixdown.Category do
  use Mixdown.Web, :model

  schema "categories" do
    field :name, :string
    field :slug, :string
    field :description, :string

    has_many :posts, Mixdown.Post

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :slug, :description])
    |> validate_required([:name, :slug, :description])
    |> unique_constraint(:slug)
  end
end
