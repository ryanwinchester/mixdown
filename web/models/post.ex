defmodule Mixdown.Post do
  use Mixdown.Web, :model

  import Mixdown.Slugger, only: [slugify: 1]

  alias Mixdown.Category
  alias Mixdown.CoverPhoto
  alias Mixdown.Photo
  alias Mixdown.Repo
  alias Mixdown.Tag

  @required_fields ~w(title slug published_at)a
  @optional_fields ~w(subtitle description content is_published user_id category_id cover_photo
    cover_photo_upload photo photo_upload)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}

  schema "posts" do
    field :title, :string
    field :slug, :string
    field :subtitle, :string
    field :description, :string
    field :content, :string
    field :cover_photo, :string
    field :cover_photo_upload, :any, virtual: true
    field :photo, :string
    field :photo_upload, :any, virtual: true
    field :is_published, :boolean, default: false
    field :published_at, :naive_datetime

    belongs_to :user, Mixdown.User
    belongs_to :category, Mixdown.Category
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
    |> cast_photo
    |> validate_required(@required_fields)
    |> unique_constraint(:slug)
  end

  @doc """
  Limit posts to published posts.
  """
  def published(post) do
    from p in post,
      where: p.is_published == true,
      order_by: [desc: :published_at],
      preload: [:user, :category, :tags]
  end

  @doc """
  Limit posts to a certain tag.
  """
  def by_tag(post, %{id: tag_id}) do
    from p in post,
      inner_join: p_t in "posts_tags", on: p_t.post_id == p.id,
      inner_join: t in Tag, on: t.id == p_t.tag_id,
      where: t.id == ^tag_id
  end

  @doc """
  Limit posts to a certain category.
  """
  def by_category(post, %{id: category_id}) do
    from p in post,
      where: p.category_id == ^category_id
  end

  # Add slug from title, if no slug exists.
  defp cast_slug(changeset) do
    case get_field(changeset, :slug) do
      nil ->
        title = get_field(changeset, :title)
        put_change(changeset, :slug, slugify(title))
      _ ->
        changeset
    end
  end

  # If post is published and there is no published_at date,
  # make it the current time.
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

  defp cast_photo(changeset) do
    case get_change(changeset, :photo_upload) do
      photo = %Plug.Upload{} ->
        upload_photo(changeset, photo)
      _ ->
        changeset
    end
  end

  defp upload_photo(changeset, photo) do
    post = apply_changes(changeset)
    case Photo.store({photo, post}) do
      {:ok, filename} ->
        put_change(changeset, :photo, filename)
      error ->
        IO.inspect error
        add_error(changeset, :photo_upload, "Error uploading photo.")
    end
  end
end
