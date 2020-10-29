defmodule BadgesWeb.TestLive.TopicLive.PartLive.Index do
  use BadgesWeb, :live_view

  alias Badges.Tests
  alias Badges.Tests.Part

  @impl true
  def mount(%{"test_id" => test_id, "topic_id" => topic_id}, _session, socket) do
    topic = Tests.get_topic!(topic_id)

    {:ok,
     socket
     |> assign(:test_id, test_id)
     |> assign(:topic, topic)
     |> assign(:parts, list_parts(topic))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"part_id" => id}) do
    socket
    |> assign(:page_title, "Edit Part")
    |> assign(:part, Tests.get_part!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Part")
    |> assign(:part, %Part{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Parts")
    |> assign(:part, nil)
  end

  @impl true
  def handle_event("delete", %{"part_id" => id}, socket) do
    part = Tests.get_part!(id)
    {:ok, _} = Tests.delete_part(part)

    {:noreply, assign(socket, :parts, list_parts(socket.assigns.topic))}
  end

  defp list_parts(topic) do
    Tests.list_parts(topic)
  end
end
