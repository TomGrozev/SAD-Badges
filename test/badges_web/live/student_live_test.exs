defmodule BadgesWeb.StudentLiveTest do
  use BadgesWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Badges.Students

  @create_attrs %{dob: ~D[2010-04-17], first_name: "some first_name", last_name: "some last_name"}
  @update_attrs %{
    dob: ~D[2011-05-18],
    first_name: "some updated first_name",
    last_name: "some updated last_name"
  }
  @invalid_attrs %{dob: nil, first_name: nil, last_name: nil}

  defp fixture(:student) do
    {:ok, student} = Students.create_student(@create_attrs)
    student
  end

  defp create_student(_) do
    student = fixture(:student)
    %{student: student}
  end

  describe "Index" do
    setup [:create_student]

    test "lists all students", %{conn: conn, student: student} do
      {:ok, _index_live, html} = live(conn, Routes.student_index_path(conn, :index))

      assert html =~ "Listing Students"
      assert html =~ student.first_name
    end

    test "saves new student", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.student_index_path(conn, :index))

      assert index_live |> element("a", "New Student") |> render_click() =~
               "New Student"

      assert_patch(index_live, Routes.student_index_path(conn, :new))

      assert index_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#student-form", student: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.student_index_path(conn, :index))

      assert html =~ "Student created successfully"
      assert html =~ "some first_name"
    end

    test "updates student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, Routes.student_index_path(conn, :index))

      assert index_live |> element("#student-#{student.id} a", "Edit") |> render_click() =~
               "Edit Student"

      assert_patch(index_live, Routes.student_index_path(conn, :edit, student))

      assert index_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#student-form", student: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.student_index_path(conn, :index))

      assert html =~ "Student updated successfully"
      assert html =~ "some updated first_name"
    end

    test "deletes student in listing", %{conn: conn, student: student} do
      {:ok, index_live, _html} = live(conn, Routes.student_index_path(conn, :index))

      assert index_live |> element("#student-#{student.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#student-#{student.id}")
    end
  end

  describe "Show" do
    setup [:create_student]

    test "displays student", %{conn: conn, student: student} do
      {:ok, _show_live, html} = live(conn, Routes.student_show_path(conn, :show, student))

      assert html =~ "Show Student"
      assert html =~ student.first_name
    end

    test "updates student within modal", %{conn: conn, student: student} do
      {:ok, show_live, _html} = live(conn, Routes.student_show_path(conn, :show, student))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Student"

      assert_patch(show_live, Routes.student_show_path(conn, :edit, student))

      assert show_live
             |> form("#student-form", student: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#student-form", student: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.student_show_path(conn, :show, student))

      assert html =~ "Student updated successfully"
      assert html =~ "some updated first_name"
    end
  end
end
