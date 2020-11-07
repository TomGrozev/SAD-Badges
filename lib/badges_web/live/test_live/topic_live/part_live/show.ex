defmodule BadgesWeb.TestLive.TopicLive.PartLive.Show do
  use BadgesWeb, :live_view

  alias Badges.Tests

  @impl true
  def mount(%{"test_id" => test_id, "topic_id" => topic_id}, _session, socket) do
    {:ok,
     socket
     |> assign(:test_id, test_id)
     |> assign(:topic_id, topic_id)}
  end

  @impl true
  def handle_params(%{"part_id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:part, Tests.get_part!(id))}
  end

  defp page_title(:show), do: "Show Part"
  defp page_title(:edit), do: "Edit Part"
end
