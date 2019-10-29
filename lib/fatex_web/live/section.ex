defmodule FatexWeb.SectionLive do
  use FatexWeb, :live
  require Logger

  # TODO: receber um info dizendo oque adicionar em seguida, com isso atualizar o socket e permitir escolher o event (append_child | append | prepend)

  def render(assigns) do
    FatexWeb.SectionView.render("index.html", assigns)
  end

  def mount(%{root_section_id: id, step_id: step_id} = _session, socket) do
    if connected?(socket) do
      PubSub.sub_to_add(step_id)
    end

    root_section =
      LatexConfigs.get_section(id)
      |> LatexConfigs.change_section()

    {:ok, assign(socket, section: root_section, to_add: nil, step_id: step_id)}
  end

  ####################
  # PROCESS MESSAGES #
  ####################

  def handle_info({:to_add, section_id}, socket) do
    {:noreply, assign(socket, to_add: section_id, section: socket.assigns.section)}
  end

  # ERROR HANDLER
  def handle_info(msg, socket) do
    Logger.warn("message dont handled: |#{inspect(msg)}| in |#{__MODULE__}|")
    {:noreply, socket}
  end

  ##########
  # EVENTS #
  ##########

  def handle_event("update_section", %{"section" => section}, socket) do
    LatexConfigs.get_section(section["id"])
    |> LatexConfigs.update_section(section)

    {:noreply, socket}
  end

  def handle_event("remove", %{"section_id" => section_id}, socket) do
    LatexConfigs.get_section(section_id)
    |> LatexConfigs.delete_section()

    # TODO: spawn screen to confirm delete

    # FIXME: find another way to reflesh current view
    {:stop, socket}
  end

  def handle_event("append_child", %{"section_id" => section_id, "to_add" => to_add_id}, socket) do
    this_section = LatexConfigs.get_section(section_id)
    template = LatexConfigs.get_section(to_add_id)

    {:ok, new_section} = LatexConfigs.clone_template_to_section_type(template, "child")

    LatexConfigs.section_append_child(this_section, new_section)
    # FIXME: find another way to reflesh current view
    {:stop, socket}
  end

  def handle_event("append", %{"section_id" => section_id, "to_add" => to_add_id}, socket) do
    this_section = LatexConfigs.get_section(section_id)
    template = LatexConfigs.get_section(to_add_id)

    {:ok, new_section} = LatexConfigs.clone_template_to_section_type(template, "child")

    LatexConfigs.section_append(this_section, new_section)
    # FIXME: find another way to reflesh current view
    {:stop, socket}
  end

  def handle_event("prepend", %{"section_id" => section_id, "to_add" => to_add_id}, socket) do
    this_section = LatexConfigs.get_section(section_id)
    template = LatexConfigs.get_section(to_add_id)

    {:ok, new_section} = LatexConfigs.clone_template_to_section_type(template, "child")

    LatexConfigs.section_prepend(this_section, new_section)
    # FIXME: find another way to reflesh current view
    {:stop, socket}
  end

  # ERROR HANDLER
  def handle_event(event, params, socket) do
    Logger.warn("envent: |#{inspect(event)}| with params: |#{inspect(params)}| is not handled")
    {:noreply, socket}
  end
end
