defmodule Render.Core.Parser do
  @moduledoc """
  Parser from Fatex input to Latex
  - "Hide" the default escape caracteres from Fatex
  - Define new escape caracters for Fatex

  New caracteres:
  - <N> text <\/N> -> bold
  - <I> text </I> -> italic
  - <S> text </S> -> underline
  - <L> command </L> -> pure latex
  """

  @doc """
    Run the `escaper/1` and the `parser/1`
    Use this function to render the Fatex to Latex
  """
  @spec exec(bitstring) :: bitstring
  def exec(text) do
    text
    |> escaper()
    |> parser()
  end

  @mapper [
    {"\\", ~S"\textbackslash"},
    {~S"^", ~S"\textasciicircum"},
    {~S"~", ~S"\textasciitilde"},
    {~S"#", ~S"\#"},
    {~S"$", ~S"\$"},
    {~S"%", ~S"\%"},
    {~S"&", ~S"\&"},
    {~S"_", ~S"\_"},
    {~S"{", ~S"\{"},
    {~S"}", ~S"\}"},
    {~S"\textbackslash", ~S"\textbackslash{}"},
    {~S"\textasciicircum", ~S"\textasciicircum{}"},
    {~S"\textasciitilde", ~S"\textasciitilde{}"},
  ]

  @doc """
  "Hide" the defualt escape caracteres from Fatex

      iex> escaper(~S"a\\a")
      ~S"a\\textbackslash{}a"

      iex> escaper("a^a")
      ~S"a\\textasciicircum{}a"

      iex> escaper("a~a")
      ~S"a\\textasciitilde{}a"

      iex> escaper("a#a")
      ~S"a\\#a"

      iex> escaper("a$a")
      ~S"a\\$a"

      iex> escaper("a%a")
      ~S"a\\%a"

      iex> escaper("a&a")
      ~S"a\\&a"

      iex> escaper("a_a")
      ~S"a\\_a"

      iex> escaper("a{a")
      ~S"a\\{a"

      iex> escaper("a}a")
      ~S"a\\}a"
  """
  @spec escaper(bitstring) :: bitstring
  def escaper(text) do
    Enum.reduce(@mapper, text, fn {x, y}, acc ->
      String.replace(acc, x, y)
    end)
  end

  @doc """
  "Unhide" the defualt escape caracteres from Fatex

      iex> unescaper(~S"a\\textbackslash{}a")
      "a\\\\a"

      iex> unescaper(~S"a\\textasciicircum{}a")
      "a^a"

      iex> unescaper(~S"a\\textasciitilde{}a")
      "a~a"

      iex> unescaper(~S"a\#a")
      "a#a"

      iex> unescaper(~S"a\$a")
      "a$a"

      iex> unescaper(~S"a\%a")
      "a%a"

      iex> unescaper(~S"a\&a")
      "a&a"

      iex> unescaper(~S"a\_a")
      "a_a"

      iex> unescaper(~S"a\{a")
      "a{a"

      iex> unescaper(~S"a\}a")
      "a}a"
  """
  def unescaper(text) do
    Enum.reverse(@mapper)
    |> Enum.reduce(text, fn {x, y}, acc ->
      String.replace(acc, y, x)
    end)
  end

  @doc """
  Parse all new caracteres from Fatex to Latex

      iex> parser("a<N>hello</N>a")
      ~S"a\\textbf{hello}a"

      iex> parser("a<I>hello</I>a")
      ~S"a\\textit{hello}a"

      iex> parser("a<S>hello</S>a")
      ~S"a\\underline{hello}a"

      iex> parser("a<L>\\textbf{HOHO, are you aproating me?}</L>a")
      ~S"a\textbf{HOHO, are you aproating me?}a"

      iex> parser("a<l>\\textbf{HOHO, are you aproating me?}</l>a")
      ~S"a\textbf{HOHO, are you aproating me?}a"

      iex> parser("a<l>\\textbf{HOHO, are you aproating me?}</L>a")
      ~S"a\textbf{HOHO, are you aproating me?}a"
  """
  @spec parser(bitstring) :: bitstring
  def parser(text) do
    # s modifier to get all lines (dotall)
    # i modifier to ignore case sensitive
    # ? to non greedly
    
    text =
      text
      |> String.replace(~r|<N>(.*?)</N>|is, "\\textbf{\\1}")
      |> String.replace(~r|<I>(.*?)</I>|is, "\\textit{\\1}")
      |> String.replace(~r|<S>(.*?)</S>|is, "\\underline{\\1}")

    Regex.replace(~r|<L>(.*?)</L>|is, text, fn _, x ->
      unescaper(x)
    end)
  end
end
