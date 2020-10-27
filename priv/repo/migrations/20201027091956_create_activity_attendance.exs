defmodule Badges.Repo.Migrations.CreateActivityAttendance do
  use Ecto.Migration

  def change do
    create table(:activity_attendance) do
      add :status, :string
      add :reason, :string

      timestamps()
    end
  end
end
