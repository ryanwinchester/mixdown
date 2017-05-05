defmodule Mixdown.Admin.PostController do
  use Mixdown.Web, :controller

  alias Ecto.Changeset
  alias Mixdown.Post
  alias Mixdown.Tag

  @doc """
  List all posts.
  """
  def index(conn, _params) do
    posts = Repo.all(Post) |> Repo.preload([:user, :tags])
    render(conn, "index.html", posts: posts)
  end

  @doc """
  Sow the form for creatign a new post.
  """
  def new(conn, _params) do
    changeset = Repo.preload(%Post{}, :tags) |> Post.changeset()

    render(conn, "new.html", changeset: changeset)
  end

  @doc """
  Create a new post.
  """
  def create(conn, %{"post" => post_params}) do
    tag_ids = Map.get(post_params, "tags")
    tags = Repo.all(from t in Tag, where: t.id in ^tag_ids)

    changeset =
      %Post{}
      |> Repo.preload(:tags)
      |> Post.changeset(post_params)
      |> Changeset.put_assoc(:tags, tags)
      |> Changeset.put_assoc(:user, conn.assigns[:user])

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: admin_post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @doc """
  Show the form to edit a post.
  """
  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.preload(:tags)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  @doc """
  Update a post.
  """
  def update(conn, %{"id" => id, "post" => post_params}) do
    tag_ids = Map.get(post_params, "tags")
    tags = Repo.all(from t in Tag, where: t.id in ^tag_ids)

    changeset =
      Post
      |> Repo.get!(id)
      |> Repo.preload(:tags)
      |> Post.changeset(post_params)
      |> Changeset.put_assoc(:tags, tags)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: admin_post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  @doc """
  Delete a post.
  """
  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: admin_post_path(conn, :index))
  end
end
