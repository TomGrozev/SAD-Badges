defmodule BadgesWeb.ActivityLive.Complete do
  use BadgesWeb, :live_view

  alias Badges.Tests
  alias Badges.Activities
  alias Badges.Activities.Activity

  @impl true
  def mount(%{"activity_id" => activity_id}, _session, socket) do
    activity = Activities.get_activity!(activity_id)

    {:ok,
      socket
      |> assign(:activity, activity)
      |> assign(:complete, list_complete(activity))}
end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Mark Item as Complete")
    |> assign(:completed, %Activity{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Completed Items")
    |> assign(:completed, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id, "type" => type}, socket) when type in ["test", "topic", "part"] do
    item =
      String.to_atom(type)
      |> Tests.get_completed!(id)

    {:ok, _} = Tests.delete_completed(item)

    {:noreply, assign(socket, :complete, list_complete(socket.assigns.activity))}
  end

  @impl true
  def handle_event("delete", _params, socket) do
    {:noreply,
        socket
        |> put_flash(:danger, "Error deleting completed item.")}
  end

  defp list_complete(activity) do
    Activities.list_completed(activity)
  end
end
