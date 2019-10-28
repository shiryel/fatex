defmodule Render do
  @moduledoc """
  Use the pdflatex with the nixos.texlive.combined.scheme-full to render a latex pdf and send this to the frontend
  """
  use Task
  require Logger

  def start_link(_) do
    Task.start_link(fn ->
      FatexWeb.PubSub.Live.sub_render()
      init()
    end)
  end

  def init do
    receive do
      model_id ->
        Logger.info("received |#{inspect model_id}| on #{inspect __MODULE__}")
        :ok
    end
    init()
  end
end
