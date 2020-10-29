defmodule Badges.Repo.Migrations.CreateTopicsCompleted do
  use Ecto.Migration

  def change do
    create table(:topics_completed) do
      add :datetime, :utc_datetime
      add :student_id, references(:students)
      add :topic_id, references(:topics)

      timestamps()
    end

  end
end
