defmodule Mixdown.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :subtitle, :string
      add :slug, :string
      add :content, :text
      add :is_published, :boolean, default: false, null: false
      add :published_at, :naive_datetime

      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:slug])
    create index(:posts, [:user_id])

  end
end
