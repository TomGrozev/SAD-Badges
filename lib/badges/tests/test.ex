defmodule Badges.Tests.Test do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tests" do
    field :planned_date, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(test, attrs) do
    test
    |> cast(attrs, [:planned_date])
  end
end
