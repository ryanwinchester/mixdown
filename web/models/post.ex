defmodule Mixdown.Post do
  use Mixdown.Web, :model

  @required_fields ~w(title slug published_at)a
  @optional_fields ~w(subtitle content is_published user_id)a

  schema "posts" do
    field :title, :string
    field :subtitle, :string
    field :slug, :string
    field :content, :string
    field :is_published, :boolean, default: false
    field :published_at, :naive_datetime

    belongs_to :user, Mixdown.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> cast_published
    |> validate_required(@required_fields)
  end

  defp cast_published(changeset) do
    post = apply_changes(changeset)
    if post.is_published and not post.published_at do
      put_change(changeset, :published_at, Timex.now)
    else
      changeset
    end
  end
end
