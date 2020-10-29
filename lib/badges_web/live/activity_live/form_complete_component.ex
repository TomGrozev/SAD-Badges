defmodule BadgesWeb.ActivityLive.FormCompleteComponent do
  use BadgesWeb, :live_component

  alias Badges.Activities
  alias Badges.Tests
  alias Badges.Students

  @impl true
  def mount(socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Badges.PubSub, "search_results")
    end

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

  def handle_event("set", %{"student" => id}, socket) do
    IO.inspect(id)
    {:noreply, assign(socket, :student, id)}
  end

  def handle_event("set", %{"item" => id}, socket) do
    IO.inspect(id)
    {:noreply, assign(socket, :item, id)}
  end

  def handle_event("add", _params, %{assigns: %{student: student_id, item: item_id}} = socket) when is_nil(student_id) or is_nil(item_id) do
      {:noreply, socket}
  end

  def handle_event("add", _params, %{assigns: %{activity: activity, student: student_id, item: item_id}} = socket) do
    [type, i_id] = String.split(item_id, "_")
    case Tests.mark_complete(activity, student_id, type, i_id) do
      {:ok, _test_completed} ->
        {:noreply,
          socket
          |> put_flash(:info, Phoenix.HTML.Form.humanize(type) <> " marked as complete successfully")
          |> push_redirect(to: socket.assigns.return_to)}

      # TODO: Fix
      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
