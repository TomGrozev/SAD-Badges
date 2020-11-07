defmodule BadgesWeb.ActivityLive.FormCompleteComponent do
  use BadgesWeb, :live_component

  alias Badges.Tests
  alias Badges.Students

  @impl true
  def mount(socket) do
    {:ok,
     socket
     |> assign(:items, [])
     |> assign(:students, [])
     |> assign(:item, nil)
     |> assign(:student, nil)}
  end

  @impl true
  def update(%{query: {:students, query}}, socket) do
    students = if query == "", do: [], else: Students.search_students(query)

    {:ok, assign(socket, :students, students)}
  end

  @impl true
  def update(%{query: {:tests, query}}, socket) do
    items = if query == "", do: [], else: Tests.search_all(query)

    {:ok, assign(socket, :items, items)}
  end

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def handle_event("set", %{"student" => id}, socket) do
    {:noreply, assign(socket, :student, id)}
  end

  @impl true
  def handle_event("set", %{"item" => id}, socket) do
    {:noreply, assign(socket, :item, id)}
  end

  @impl true
  def handle_event("add", _params, %{assigns: %{student: student_id, item: item_id}} = socket)
      when is_nil(student_id) or is_nil(item_id) do
    {:noreply, socket}
  end

  @impl true
  def handle_event(
        "add",
        _params,
        %{assigns: %{activity: activity, student: student_id, item: item_id}} = socket
      ) do
    [type, i_id] = String.split(item_id, "_")

    case Tests.mark_complete(activity, student_id, type, i_id) do
      {:ok, _test_completed} ->
        {:noreply,
         socket
         |> put_flash(
           :info,
           Phoenix.HTML.Form.humanize(type) <> " marked as complete successfully"
         )
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{errors: errors}} ->
        message =
          List.first(errors)
          |> elem(1)
          |> elem(0)

        {:noreply,
          socket
          |> put_flash(:error, message || "Error marking item as complete.")}
    end
  end
end
