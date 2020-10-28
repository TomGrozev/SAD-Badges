defmodule Badges.Repo.Migrations.TeacherTests do
  use Ecto.Migration

  def change do
    alter table(:tests) do
      add :teacher_id, references(:teachers, on_delete: :delete_all)
    end
  end
end
