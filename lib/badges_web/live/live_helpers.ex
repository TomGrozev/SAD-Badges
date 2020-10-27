defmodule BadgesWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  import Phoenix.HTML.Tag
  import Phoenix.HTML.Form, only: [humanize: 1, label: 3, radio_button: 4]

  @doc """
  Renders a component inside the `BadgesWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, BadgesWeb.StudentLive.FormComponent,
        id: @student.id || :new,
        action: @live_action,
        student: @student,
        return_to: Routes.student_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, BadgesWeb.ModalComponent, modal_opts)
  end

  @doc """
  Creates a radio button and label

  The label value is based on the value of the radio button.

  Takes a `:class` option for the surrounding div and a `:class_radio`
  for the radio button.
  """
  def radio_button_label(form, field, value, opts \\ []) do
    {class, opts} = take_class_radio(opts)

    opts =
      opts
      |> field_name(form, field)
      |> field_id(form, field, value)

    content_tag :div, class: class do
      [
        label(form, field_value_name(field, value), humanize(value)),
        radio_button(form, field, value, opts)
      ]
    end
  end

  def field_name(opts, form, field) do
    name = get_prefix(form, opts) <> "[#{field}]"
    Keyword.put(opts, :name, name)
  end

  def field_id(opts, form, field, value \\ false) do
    id = get_prefix(form, opts) <> (if value, do: "_" <> value, else: "")
    Keyword.put(opts, :id, id)
  end

  defp field_value_name(field, value) do
    String.to_atom(to_string(field) <> "_" <> to_string(value))
  end

  defp take_class_radio(opts) do
    class = Keyword.get(opts, :class, "")
    class_radio = Keyword.get(opts, :class_radio, "")

    {class,
     opts
     |> Keyword.drop([:class, :class_radio])
     |> Keyword.put(:class, class_radio)}
  end

  defp get_prefix(%{name: name}, opts) do
    name <> "_" <> to_string(Keyword.get(opts, :state_id))
  end
end
