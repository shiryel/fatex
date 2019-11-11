defmodule Render.Core.FileHandler do
  @moduledoc """
  Handle the files to exec the pdflatex

  init/1 verify the directorys
  write/2 write the file in the directory of the init/1
  make_latex/1 get the file of the write/2 and exec pdflatex

  TODO:
  - add_image/2
  """
  require Logger

  @spec init(integer | bitstring) :: :ok | {:error, atom}
  def init(unique_name) do
    File.mkdir("maker/")
    File.mkdir("maker/#{unique_name}")
  end

  @spec write(integer | bitstring, bitstring | [bitstring]) :: :ok | {:error, atom}
  def write(unique_name, text) do
    File.write("maker/#{unique_name}/latex.tex", text, [:write])
  end

  @spec make_latex(integer | bitstring) :: :ok
  def make_latex(unique_name) do
    System.cmd("pdflatex", [
      "-interaction",
      "nonstopmode",
      "-output-directory",
      "maker/#{unique_name}/",
      "maker/#{unique_name}/latex.tex"
    ])
    :ok
  end

  @spec add_image(integer | bitstring, any) :: :ok
  def add_image(_unique_name, _image) do
    Logger.info("Add image not implemented yet")
    :ok
  end
end
