defmodule Badges.Repo.Migrations.TestName do
  use Ecto.Migration

  def change do
    alter table(:tests) do
      add :name, :string
    end
  end
end
