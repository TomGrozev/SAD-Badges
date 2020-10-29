defmodule Badges.Tests.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :name, :string

    belongs_to :test, Badges.Tests.Test
    has_many :parts, Badges.Tests.Part
    many_to_many :students, Badges.Students.Student, join_through: Badges.Students.TopicsCompleted

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> assoc_constraint(:test)
  end
end
