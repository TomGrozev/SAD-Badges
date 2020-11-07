defmodule Badges.Repo.Migrations.CreateTestsCompleted do
  use Ecto.Migration

  def change do
    create table(:tests_completed) do
      add :datetime, :utc_datetime
      add :student_id, references(:students, on_delete: :delete_all)
      add :test_id, references(:tests, on_delete: :delete_all)

      timestamps()
    end
  end
end
