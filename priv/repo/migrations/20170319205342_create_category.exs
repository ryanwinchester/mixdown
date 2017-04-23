defmodule Mixdown.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :slug, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:categories, [:slug])

  end
end
