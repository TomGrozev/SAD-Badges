defmodule BadgesWeb.ActivityLiveTest do
  use BadgesWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Badges.Activities

  @create_attrs %{datetime: "2010-04-17T14:00:00Z", name: "some name"}
  @update_attrs %{datetime: "2011-05-18T15:01:01Z", name: "some updated name"}
  @invalid_attrs %{datetime: nil, name: nil}

  defp fixture(:activity) do
    {:ok, activity} = Activities.create_activity(@create_attrs)
    activity
  end

  defp create_activity(_) do
    activity = fixture(:activity)
    %{activity: activity}
  end

  describe "Index" do
    setup [:create_activity]

    test "lists all activities", %{conn: conn, activity: activity} do
      {:ok, _index_live, html} = live(conn, Routes.activity_index_path(conn, :index))

      assert html =~ "Listing Activities"
      assert html =~ activity.name
    end

    test "saves new activity", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.activity_index_path(conn, :index))

      assert index_live |> element("a", "New Activity") |> render_click() =~
               "New Activity"

      assert_patch(index_live, Routes.activity_index_path(conn, :new))

      assert index_live
             |> form("#activity-form", activity: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#activity-form", activity: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.activity_index_path(conn, :index))

      assert html =~ "Activity created successfully"
      assert html =~ "some name"
    end

    test "updates activity in listing", %{conn: conn, activity: activity} do
      {:ok, index_live, _html} = live(conn, Routes.activity_index_path(conn, :index))

      assert index_live |> element("#activity-#{activity.id} a", "Edit") |> render_click() =~
               "Edit Activity"

      assert_patch(index_live, Routes.activity_index_path(conn, :edit, activity))

      assert index_live
             |> form("#activity-form", activity: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#activity-form", activity: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.activity_index_path(conn, :index))

      assert html =~ "Activity updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes activity in listing", %{conn: conn, activity: activity} do
      {:ok, index_live, _html} = live(conn, Routes.activity_index_path(conn, :index))

      assert index_live |> element("#activity-#{activity.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#activity-#{activity.id}")
    end
  end

  describe "Show" do
    setup [:create_activity]

    test "displays activity", %{conn: conn, activity: activity} do
      {:ok, _show_live, html} = live(conn, Routes.activity_show_path(conn, :show, activity))

      assert html =~ "Show Activity"
      assert html =~ activity.name
    end

    test "updates activity within modal", %{conn: conn, activity: activity} do
      {:ok, show_live, _html} = live(conn, Routes.activity_show_path(conn, :show, activity))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Activity"

      assert_patch(show_live, Routes.activity_show_path(conn, :edit, activity))

      assert show_live
             |> form("#activity-form", activity: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#activity-form", activity: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.activity_show_path(conn, :show, activity))

      assert html =~ "Activity updated successfully"
      assert html =~ "some updated name"
    end
  end
end
