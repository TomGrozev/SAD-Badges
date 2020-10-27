defmodule Badges.Repo.Migrations.AttendanceBelongsToActivity do
  use Ecto.Migration

  def change do
    alter table(:activity_attendance) do
      add :activity_id, references(:activities)
    end
  end
end
