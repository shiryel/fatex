defmodule Render do
  @moduledoc """
  Use the pdflatex with the nixos.texlive.combined.scheme-full to render a latex pdf and send this to the frontend
  """
  use Task
  require Logger
  alias Render.Core.{DataHandler, FileHandler}

  # Started in the Fatex application
  def start_link(_) do
    Task.start_link(fn ->
      FatexWeb.PubSub.Live.sub_render()
      init()
    end)
  end

  def init do
    receive do
      {:render, model_id} ->
        data = DataHandler.concat_all(model_id)
        FileHandler.init(model_id)
        FileHandler.write(model_id, data)
        FileHandler.make_latex(model_id)
        :ok
    end

    init()
  end
end
