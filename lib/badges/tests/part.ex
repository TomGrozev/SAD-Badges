defmodule Badges.Tests.Part do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parts" do
    field :name, :string
    field :required, :boolean, default: false

    belongs_to :topic, Badges.Tests.Topic
    many_to_many :students, Badges.Students.Student, join_through: Badges.Students.PartsCompleted

    timestamps()
  end

  @doc false
  def changeset(part, attrs) do
    part
    |> cast(attrs, [:name, :required])
    |> validate_required([:name, :required])
    |> assoc_constraint(:topic)
  end
end
