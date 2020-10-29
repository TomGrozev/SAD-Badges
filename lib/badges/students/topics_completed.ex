defmodule Badges.Students.TopicsCompleted do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics_completed" do
    belongs_to :student, Badges.Students.Student
    belongs_to :topic, Badges.Tests.Topic
    belongs_to :activity, Badges.Activities.Activity

    timestamps()
  end

  @doc false
  def changeset(topics_completed, attrs) do
    topics_completed
    |> cast(attrs, [:student_id, :topic_id, :activity_id])
    |> validate_required([:student_id, :topic_id, :activity_id])
  end
end
