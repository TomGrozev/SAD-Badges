defmodule BadgesWeb.TestLive.TopicLive.Show do
  use BadgesWeb, :live_view

  alias Badges.Tests

  @impl true
  def mount(%{"test_id" => test_id}, _session, socket) do
    {:ok, assign(socket, :test_id, test_id)}
  end

  @impl true
  def handle_params(%{"topic_id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:topic, Tests.get_topic!(id))}
  end

  defp page_title(:show), do: "Show Topic"
  defp page_title(:edit), do: "Edit Topic"
end
