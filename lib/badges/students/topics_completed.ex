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
    |> unique_constraint([:topic_id, :student_id], name: :topics_completed_topic_id_student_id_index, message: "Topic already completed")
  end
end
