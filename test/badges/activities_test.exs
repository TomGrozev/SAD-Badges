defmodule Badges.ActivitiesTest do
  use Badges.DataCase

  alias Badges.Activities

  describe "activities" do
    alias Badges.Activities.Activity

    @valid_attrs %{datetime: "2010-04-17T14:00:00Z", name: "some name"}
    @update_attrs %{datetime: "2011-05-18T15:01:01Z", name: "some updated name"}
    @invalid_attrs %{datetime: nil, name: nil}

    def activity_fixture(attrs \\ %{}) do
      {:ok, activity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Activities.create_activity()

      activity
    end

    test "list_activities/0 returns all activities" do
      activity = activity_fixture()
      assert Activities.list_activities() == [activity]
    end

    test "get_activity!/1 returns the activity with given id" do
      activity = activity_fixture()
      assert Activities.get_activity!(activity.id) == activity
    end

    test "create_activity/1 with valid data creates a activity" do
      assert {:ok, %Activity{} = activity} = Activities.create_activity(@valid_attrs)
      assert activity.datetime == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert activity.name == "some name"
    end

    test "create_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activities.create_activity(@invalid_attrs)
    end

    test "update_activity/2 with valid data updates the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{} = activity} = Activities.update_activity(activity, @update_attrs)
      assert activity.datetime == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert activity.name == "some updated name"
    end

    test "update_activity/2 with invalid data returns error changeset" do
      activity = activity_fixture()
      assert {:error, %Ecto.Changeset{}} = Activities.update_activity(activity, @invalid_attrs)
      assert activity == Activities.get_activity!(activity.id)
    end

    test "delete_activity/1 deletes the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{}} = Activities.delete_activity(activity)
      assert_raise Ecto.NoResultsError, fn -> Activities.get_activity!(activity.id) end
    end

    test "change_activity/1 returns a activity changeset" do
      activity = activity_fixture()
      assert %Ecto.Changeset{} = Activities.change_activity(activity)
    end
  end
end