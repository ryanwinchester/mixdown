defmodule Mixdown.Post do
  use Mixdown.Web, :model

  import Slugger, only: [slugify: 1]

  alias Mixdown.CoverPhoto
  alias Mixdown.Repo
  alias Mixdown.Tag
  alias Mixdown.Thumbnail

  @required_fields ~w(title slug published_at)a
  @optional_fields ~w(subtitle content is_published user_id cover_photo cover_photo_upload
    thumbnail thumbnail_upload)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "posts" do
    field :title, :string
    field :subtitle, :string
    field :slug, :string
    field :content, :string
    field :cover_photo, :string
    field :cover_photo_upload, :any, virtual: true
    field :thumbnail, :string
    field :thumbnail_upload, :any, virtual: true
    field :is_published, :boolean, default: false
    field :published_at, :naive_datetime

    belongs_to :user, Mixdown.User
    many_to_many :tags, Mixdown.Tag, join_through: "posts_tags", on_replace: :delete

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> cast_slug
    |> cast_published
    |> cast_cover_photo
    |> cast_thumbnail
    |> validate_required(@required_fields)
    |> unique_constraint(:slug)
  end

  defp cast_slug(changeset) do
    title = get_field(changeset, :title)
    put_change(changeset, :slug, slugify(title))
  end

  defp cast_published(changeset) do
    post = apply_changes(changeset)
    if post.is_published and post.published_at === nil do
      put_change(changeset, :published_at, Timex.now)
    else
      changeset
    end
  end

  defp cast_cover_photo(changeset) do
    case get_change(changeset, :cover_photo_upload) do
      photo = %Plug.Upload{} ->
        upload_cover_photo(changeset, photo)
      _ ->
        changeset
    end
  end

  defp upload_cover_photo(changeset, photo) do
    post = apply_changes(changeset)
    case CoverPhoto.store({photo, post}) do
      {:ok, filename} ->
        put_change(changeset, :cover_photo, filename)
      error ->
        IO.inspect error
        add_error(changeset, :cover_photo_upload, "Error uploading cover photo.")
    end
  end

  defp cast_thumbnail(changeset) do
    case get_change(changeset, :thumbnail_upload) do
      photo = %Plug.Upload{} ->
        upload_thumbnail(changeset, photo)
      _ ->
        changeset
    end
  end

  defp upload_thumbnail(changeset, photo) do
    post = apply_changes(changeset)
    case Thumbnail.store({photo, post}) do
      {:ok, filename} ->
        put_change(changeset, :thumbnail, filename)
      error ->
        IO.inspect error
        add_error(changeset, :thumbnail_upload, "Error uploading thumbnail.")
    end
  end

end
