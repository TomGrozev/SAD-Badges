defmodule BadgesWeb.TeacherLiveTest do
  use BadgesWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Badges.Teachers

  @create_attrs %{first_name: "some first_name", last_name: "some last_name"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
  @invalid_attrs %{first_name: nil, last_name: nil}

  defp fixture(:teacher) do
    {:ok, teacher} = Teachers.create_teacher(@create_attrs)
    teacher
  end

  defp create_teacher(_) do
    teacher = fixture(:teacher)
    %{teacher: teacher}
  end

  describe "Index" do
    setup [:create_teacher]

    test "lists all teachers", %{conn: conn, teacher: teacher} do
      {:ok, _index_live, html} = live(conn, Routes.teacher_index_path(conn, :index))

      assert html =~ "Listing Teachers"
      assert html =~ teacher.first_name
    end

    test "saves new teacher", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.teacher_index_path(conn, :index))

      assert index_live |> element("a", "New Teacher") |> render_click() =~
               "New Teacher"

      assert_patch(index_live, Routes.teacher_index_path(conn, :new))

      assert index_live
             |> form("#teacher-form", teacher: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#teacher-form", teacher: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.teacher_index_path(conn, :index))

      assert html =~ "Teacher created successfully"
      assert html =~ "some first_name"
    end

    test "updates teacher in listing", %{conn: conn, teacher: teacher} do
      {:ok, index_live, _html} = live(conn, Routes.teacher_index_path(conn, :index))

      assert index_live |> element("#teacher-#{teacher.id} a", "Edit") |> render_click() =~
               "Edit Teacher"

      assert_patch(index_live, Routes.teacher_index_path(conn, :edit, teacher))

      assert index_live
             |> form("#teacher-form", teacher: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#teacher-form", teacher: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.teacher_index_path(conn, :index))

      assert html =~ "Teacher updated successfully"
      assert html =~ "some updated first_name"
    end

    test "deletes teacher in listing", %{conn: conn, teacher: teacher} do
      {:ok, index_live, _html} = live(conn, Routes.teacher_index_path(conn, :index))

      assert index_live |> element("#teacher-#{teacher.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#teacher-#{teacher.id}")
    end
  end

  describe "Show" do
    setup [:create_teacher]

    test "displays teacher", %{conn: conn, teacher: teacher} do
      {:ok, _show_live, html} = live(conn, Routes.teacher_show_path(conn, :show, teacher))

      assert html =~ "Show Teacher"
      assert html =~ teacher.first_name
    end

    test "updates teacher within modal", %{conn: conn, teacher: teacher} do
      {:ok, show_live, _html} = live(conn, Routes.teacher_show_path(conn, :show, teacher))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Teacher"

      assert_patch(show_live, Routes.teacher_show_path(conn, :edit, teacher))

      assert show_live
             |> form("#teacher-form", teacher: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#teacher-form", teacher: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.teacher_show_path(conn, :show, teacher))

      assert html =~ "Teacher updated successfully"
      assert html =~ "some updated first_name"
    end
  end
end
