defmodule Badges.Repo.Migrations.AttendanceBelongsToActivity do
  use Ecto.Migration

  def change do
    alter table(:activity_attendance) do
      add :activity_id, references(:activities, on_delete: :delete_all)
    end
  end
end
