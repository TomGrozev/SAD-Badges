defmodule BadgesWeb.TestLive.TopicLive.Index do
  use BadgesWeb, :live_view

  alias Badges.Tests
  alias Badges.Tests.Topic

  @impl true
  def mount(%{"test_id" => test_id}, _session, socket) do
    test = Tests.get_test!(test_id)

    {:ok,
     socket
     |> assign(:test, test)
     |> assign(:topics, list_topics(test))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"topic_id" => id}) do
    socket
    |> assign(:page_title, "Edit Topic")
    |> assign(:topic, Tests.get_topic!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Topic")
    |> assign(:topic, %Topic{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Topics")
    |> assign(:topic, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    topic = Tests.get_topic!(id)
    {:ok, _} = Tests.delete_topic(topic)

    {:noreply, assign(socket, :topics, list_topics(socket.assigns.test))}
  end

  defp list_topics(test) do
    Tests.list_topics(test)
  end
end
