defmodule Badges.Tests.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :name, :string

    belongs_to :test, Badges.Tests.Test
    has_many :parts, Badges.Tests.Part

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
