defmodule BadgesWeb.PartLiveTest do
  use BadgesWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Badges.Tests

  @create_attrs %{name: "some name", required: true}
  @update_attrs %{name: "some updated name", required: false}
  @invalid_attrs %{name: nil, required: nil}

  defp fixture(:part) do
    {:ok, part} = Tests.create_part(@create_attrs)
    part
  end

  defp create_part(_) do
    part = fixture(:part)
    %{part: part}
  end

  describe "Index" do
    setup [:create_part]

    test "lists all parts", %{conn: conn, part: part} do
      {:ok, _index_live, html} = live(conn, Routes.part_index_path(conn, :index))

      assert html =~ "Listing Parts"
      assert html =~ part.name
    end

    test "saves new part", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.part_index_path(conn, :index))

      assert index_live |> element("a", "New Part") |> render_click() =~
               "New Part"

      assert_patch(index_live, Routes.part_index_path(conn, :new))

      assert index_live
             |> form("#part-form", part: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#part-form", part: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.part_index_path(conn, :index))

      assert html =~ "Part created successfully"
      assert html =~ "some name"
    end

    test "updates part in listing", %{conn: conn, part: part} do
      {:ok, index_live, _html} = live(conn, Routes.part_index_path(conn, :index))

      assert index_live |> element("#part-#{part.id} a", "Edit") |> render_click() =~
               "Edit Part"

      assert_patch(index_live, Routes.part_index_path(conn, :edit, part))

      assert index_live
             |> form("#part-form", part: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#part-form", part: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.part_index_path(conn, :index))

      assert html =~ "Part updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes part in listing", %{conn: conn, part: part} do
      {:ok, index_live, _html} = live(conn, Routes.part_index_path(conn, :index))

      assert index_live |> element("#part-#{part.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#part-#{part.id}")
    end
  end

  describe "Show" do
    setup [:create_part]

    test "displays part", %{conn: conn, part: part} do
      {:ok, _show_live, html} = live(conn, Routes.part_show_path(conn, :show, part))

      assert html =~ "Show Part"
      assert html =~ part.name
    end

    test "updates part within modal", %{conn: conn, part: part} do
      {:ok, show_live, _html} = live(conn, Routes.part_show_path(conn, :show, part))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Part"

      assert_patch(show_live, Routes.part_show_path(conn, :edit, part))

      assert show_live
             |> form("#part-form", part: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#part-form", part: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.part_show_path(conn, :show, part))

      assert html =~ "Part updated successfully"
      assert html =~ "some updated name"
    end
  end
end
