defmodule FatexWeb.SectionLive do
  use FatexWeb, :live
  require Logger
  # TODO: receber um info dizendo oque adicionar em seguida, com isso atualizar o socket e permitir escolher o event (append_child | append | prepend)

  def render(assigns) do
    FatexWeb.SectionView.render("index.html", assigns)
  end

  def mount(%{root_section_id: id} = _session, socket) do
    root_section = 
      LatexConfigs.get_section(id)
      |> LatexConfigs.change_section()

    {:ok, assign(socket, root_section: root_section, to_add: nil)}
  end

  def handle_event("update_section", %{"section" => section}, socket) do
    LatexConfigs.get_section(section["id"])
    |> LatexConfigs.update_section(section)

    {:noreply, socket}
  end

  def handle_event("append_child", %{"section_id" => section_id, "to_add" => to_add_id}, socket) do
    this_section = LatexConfigs.get_section(section_id)
    new_section = LatexConfigs.get_section(to_add_id)
    LatexConfigs.section_append_child(this_section, new_section)

    step = LatexConfigs.get_step(socket.assigns.step.id)

    {:noreply, update(socket, :step, fn _ -> step end)}
  end

  def handle_event("append", %{"section_id" => section_id, "to_add" => to_add_id}, socket) do
    this_section = LatexConfigs.get_section(section_id)
    new_section = LatexConfigs.get_section(to_add_id)
    LatexConfigs.section_append(this_section, new_section)

    step = LatexConfigs.get_step(socket.assigns.step.id)

    {:noreply, update(socket, :step, fn _ -> step end)}
  end

  def handle_event("prepend", %{"section_id" => section_id, "to_add" => to_add_id}, socket) do
    this_section = LatexConfigs.get_section(section_id)
    new_section = LatexConfigs.get_section(to_add_id)
    LatexConfigs.section_prepend(this_section, new_section)

    step = LatexConfigs.get_step(socket.assigns.step.id)

    {:noreply, update(socket, :step, fn _ -> step end)}
  end
end
