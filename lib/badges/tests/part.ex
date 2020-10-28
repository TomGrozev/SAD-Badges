defmodule Badges.Tests.Part do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parts" do
    field :name, :string
    field :required, :boolean, default: false

    belongs_to :topic, Badges.Tests.Topic

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
