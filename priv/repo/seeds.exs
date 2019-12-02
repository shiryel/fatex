# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fatex.Repo.insert!(%Fatex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

configuration = ~S"""
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Artigo segundo as normais mais atualizadas da ABNT
% Adaptado do projeto ABNTeX2 (que nao esta totalmente sincronizada com as normas da ABNT)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\documentclass[article,12pt,oneside,a4paper,english,brazil,sumario=tradicional]{abntex2}
% Pacotes usados
\usepackage{times}%Usa a fonte Latin Modern
\usepackage[T1]{fontenc}%Selecao de codigos de fonte.
\usepackage[utf8]{inputenc}%Codificacao do documento
\usepackage{indentfirst}%Indenta o primeiro parágrafo de cada seção.
\usepackage{nomencl}%Lista de simbolos
\usepackage{color}%Controle das cores
\usepackage{graphicx}%Inclusão de gráficos
\usepackage{microtype}%Para melhorias de justificação
\usepackage{lipsum}%Para geração de dummy text
\usepackage[abnt-emphasize=bf,abnt-and-type=e,alf]{abntex2cite}%Citações ABNT
\usepackage{mathptmx}
\usepackage{natbib}
\usepackage{float}
\usepackage{ragged2e}
\usepackage{epstopdf}
%\usepackage[bottom=2cm,top=3cm,left=3cm,right=2cm]{geometry}

% Configuracoes do documento
\setsecheadstyle{\bfseries \normalsize \uppercase}
\setsubsecheadstyle{\normalsize \uppercase}
\setsubsubsecheadstyle{\bfseries \normalsize}
\setlrmarginsandblock{3cm}{2cm}{*}%Margens esquerda-direita
\setulmarginsandblock{3cm}{2cm}{*}%Margens cima-baixo
\checkandfixthelayout
\setlength{\parindent}{1.25cm}%paragrafo
\OnehalfSpacing%espacamento de 1,5
\setlength{\ABNTEXcitacaorecuo}{4cm}%recuo citacao direta +3

% FIGURE RELATIVE PATH
\graphicspath{ {./maker/1/figures} }
"""

title_start = ~S"""
\title{
"""

title = ~S"""
FATeX Rio Preto - ADS
"""

title_end = ~S"""
}
\date{}
"""

autor_name_start = ~S"""
\author{
"""

autor_name = ~S"""
GONÇALVES Andrey, MOLINA Vinícius, Orientador: Rafael dos Santos Borges
"""

autor_name_end = ~S"""
}
"""

mail_autor_start = ~S"""
\begin{document}
\selectlanguage{brazil} % Seleciona o idioma do documento
\frenchspacing % Retira espaço extra obsoleto entre as frases.
\maketitle

\begin{footnotesize}
    \SingleSpacing
    \noindent
    \small{\textbf{e-mail:}}
    \noindent
    \small
    \centering
"""

mail_autors = ~S"""
andreygo20@gmail.com, vinicius_molina99@hotmail.com, rafael@fatecriopreto.edu.br
"""

mail_autor_end = ~S"""
\noindent
\end{footnotesize}
"""

resumo_start = ~S"""
\begin{footnotesize}
\SingleSpacing
\noindent
\small{\textbf{Resumo:}}
\noindent
\small
"""

resumo = ~S"""
A organização de documentos é uma forma primordial de facilitar a disseminação de conhecimento, atualmente são utilizadas diversas tecnologias 
	para esta finalidade, principalmente aquelas que permitem o design visual. Segundo GROZA (2007), uma ferramenta para edição de texto de alta qualidade 
	é o LaTeX, muito popular entre cientistas e pesquisadores principalmente. Porém, tamanha eficiência vem acompanhada de um empecilho, seu uso requer 
	prévio conhecimento de suas funcionalidades, que por sua vez, são um tanto complexas e em certas ocasiões desmotivam o usuário a utilizá-las. 
	Para tal, este trabalho visa a utilização do design lógico do LaTeX com uma interface e uso mais intuitivos, como resolução deste problema.
"""

keywords_start = ~S"""
\noindent
"""

keywords = ~S"""
<N>Palavras-chave</N>: Ambiente Gráfico, Praticidade e Aprimoramento de UX.
"""

keywords_end = ~S"""
\end{footnotesize}
"""

abstract_start = ~S"""
\begin{footnotesize}
	\SingleSpacing
	\noindent
	\small{\textbf{\textit{Abstract:}}}
	\noindent
	\small
"""

abstract = ~S"""
<I>The documents organization is a primordial way to facilitate the knowledge dissemination, today a lot of Technologies are used for that goal, mainly 

those which allow the visual design. According with Groza (2007), a high-quality tool for text formatting is the LaTeX, it is very popular, primarily between 

scientists and researchers. For that, this work aim use the LaTeX logical design together a more intuitive interface as the resolution for this problem.</I>

"""

abstract_keywords_start = ~S"""
\noindent
"""

abstract_keywords = ~S"""
<N><I>Keywords</I></N>: <I>Graphic Environment. Praticity. UX Enhancement.</I>
"""

abstract_keywords_end = ~S"""
\end{footnotesize}
"""

introduction_start = ~S"""
\textual
\pagestyle{simple}
\aliaspagestyle{chapter}{simple}

\section{Introdução}
\label{secIntroducao}
\normalsize
"""

introduction = ~S"""
Desde que a humanidade começou a compartilhar e armazenar conhecimento em formas textuais, sempre foi necessário que ele estivesse organizado de forma adequada parafácil compreensão. 

Na atualidade são utilizadas ferramentas para facilitar este trabalho, principalmente as conhecidas como what you see is what you get (WYSIWYG), que fornecem um design visual para a organização dos textos.

O LaTeX é uma ferramenta que fornece um design lógico, ótimo para documentos complexos (como trabalhos científicos) (LAMPORT, 1994). Porém, esta eficiência é acompanhada por um obstáculo, que em certas ocasiões, desmotiva o uso da ferramenta, este empecilho nada mais é que a sua usabilidade que, por sua vez, requer do usuário um previo conhecimento de suas funcionalidades.

Diante deste cenário, o presente projeto busca permitir o uso do LaTeX para edição de texto de forma eficiente, e voltada para usuários leigos.
"""

justification_start = ~S"""
\section{Justificativa}
"""

justification = ~S"""
Levando em conta que segundo Davis e Walters (2011) a presença de indivíduos que desenvolvem documentos científicos vem sofrendo um grande aumento, a existência de uma plataforma para a edição de documentos complexos de forma eficiente pode trazer grandes benefícios para a comunidade como um todo. O LaTeX permite a escrita de tais documentos com uma formatação facilmente padronizável e distribuível por documentos de configuração, porém necessita de estudo prévio por parte do usuário para uma utilização efetiva.
"""

objective_start = ~S"""
\section{Objetivo}
"""

objective = ~S"""
O objetivo deste projeto é desenvolver um editor LaTeX para a Fatec, que possua uma interface de usuário que seja simples, de fácil aprendizado e que mantenha a eficácia do LaTeX para organização de documentos.

Como um possível adendo a este trabalho, é cogitado disponibilizar e integrar o sistema em duas plataformas diferentes: web e mobile.
"""

fundamentation_start = ~S"""
\section{Fundamentação Teórica}
"""

fundamentation = ~S"""
TeX é um programa de tipografia e fórmulas matemáticas criado por Donal E. Knuth (DONALD, 1989). E conhecido por ser extremamente estável e multiplataforma (OETIKER et al., 2011).

LaTeX é um pacote macro do TeX que permite a profissionais utilizarem layouts pré-definidos. Ele foi originalmente escrito por Leslie Lamport (LAMPORT, 1994) e atualmente é mantido por Frank Mittelbach.

Elixir é uma linguagem de programação dinâmica e funcional, desenvolvida para a construção de aplicações escaláveis e sustentáveis. Foi baseada na linguagem Erlang, uma linguagem famosa por possuir sistemas distribuídos e tolerantes a falhas (PLATAFORMATEC, 2019).

Phoenix LiveView é uma biblioteca que permite o desenvolvimento de aplicações web que proporcionam ao usuário uma rica experiência em “tempo real”, utilizando HTML server-rendered. Esta biblioteca compete com projetos como o React, por também ser uma ferramenta para criação de websites e web apps. Possui uma grande ênfase na simplicidade, fácil usabilidade e funcionalidade (DEBENEDETTO, 2019).

PostgreSQL é um poderoso sistema de banco de dados relacional de código aberto, com mais de 30 anos de desenvolvimento ativo e que recebeu uma forte reputação como confiável, robusto e eficiente.

Argon2 é um pacote da linguagem Elixir para hash de senhas (ZIEGELMAYER, 2019).
"""

other_works_start = ~S"""
\section{Trabalhos Similares}
"""

other_works = ~S"""
Considerado por muitos o melhor editor LaTeX existente, o TeXMarker se encontra disponível para Windows, MAC e Linux (onde mais é utilizado). Possuindo diversas funcionalidades (BRACHET, 2003).

TeXstudio é um competidor “sucessor” e sucessor direto do TeXMarker, desenvolvido para ser um editor com um processo de desenvolvimento transparente opondo- se a seu antecessor. Está presente em todas as principais plataformas e é tão funcional e completo quanto TeXMaker (ZANDER, 2019).

Segundo a Google Play (2019) uma companhia que trouxe seu editor LaTeX, agora nomeado VerbTex para as plataformas mobile e obteve grande sucesso é a VERBOSUS conquistando mais de 100 mil downloads e nota média de 4,4 pontos de um total de 5 na loja de aplicativos do Android, a Google Play.

Outro editor LaTeX que faz sucesso é o neutriNote, que por sua vez possui mais de 10 mil downloads e nota média de 4,4 pontos na Google Play.

Mais dois editores que ainda estão em crescimento na loja são o LawTex que vem como sucessor do TEXPortal prometendo melhorias e novas funcionalidades, e o TeX Writer – LaTeX On the Go que é único dos aqui mencionados que possui apenas a versão paga, ambos possuem mais de 1000 downloads e notas médias de 3,5 e 3,7 respectivamente na Google Play.
"""

metodology_start = ~S"""
\section{Metodologia}
"""

metodology = ~S"""
Este trabalho será realizado de forma exploratória, sendo primeiramente planejado e desenvolvido um produto viável mínimo (MVP), utilizando os princípios do Scrum que visa trazer valor para o produto ao expô-lo de forma periódica ao público alvo (SUTHERLAND, 2016). O público alvo será inicialmente composto por pessoas inseridas no meio acadêmico, para tal, disponibilizaremos o MVP online e realizaremos pesquisas de campo na FATEC de São José do Rio Preto. O valor do produto será medido pelo tempo transcorrido em um intervalo de tempo que o público alvo passará utilizando a solução em comparação com outras soluções do estilo WYSIWYG. A coleta de dados será realizada através de formulários presenciais e online.

Para a realização deste projeto foi utilizado como infraestrutura o Linux, com servidor distribuído construído em Elixir, e interfaces de usuário desenvolvidas com Phoenix LiveView. Para realizar o armazenamento de dados de usuários é utilizado o PostgreSQL.
"""

development_start = ~S"""
\subsection{Desenvolvimento}
"""

development = ~S"""
Para a identificação das tags utilizadas no LaTeX, verificando casos isolados e regras de aninhamento das mesmas, para assim especificar as regras básicas de comportamento dos containers. Isso foi realizado ao adicionar o LaTeX e modelos de formatação previamente montados à base de dados do sistema, os quais determinam a formatação de todo o texto.

A User Experience (UX) foi desenvolvida através do aprimoramento de um protótipo, discutindo melhorias ao longo do projeto com os colegas e professores.

<L>
\begin{figure}[H]
  \centering
  \caption{Layout do Sistema.}
  \includegraphics[width=16cm]{figures/Tela Editar Projeto - FATEX.jpeg}
  \textual{Fonte: Dos Autores (2019).}
\end{figure}
</L>

A implementação da plataforma base foi inicialmente desenvolvida com Elm, uma linguagem funcional que compila para Java Script, utilizada no desenvolvimento de websites e web apps. Em um momento já avançado do desenvolvimento, notou-se que o mesmo se tornou ineficiente e trabalhoso, devido a certas regras e limitações impostas pela linguagem de programação anteriormente citada.

Como resolução, mesmo com o desenvolvimento já avançado, trocamos o Elm pelo Elixir e seu PHOENIX - LiveView, um framework que permite a implementação de funcionalidades em tempo real, de forma simplificada e performática, sem o uso de Java Script.

A troca se mostrou extremamente positiva, já que ao utilizar os conceitos previamente desenvolvidos em conjunto com a facilidade proporcionada pelo Phoenix – LiveView, conseguimos refazer todo o trabalho de 2 meses em apenas 3 dias, e também resolver nosso problema, ao tornar o desenvolvimento novamente efetivo e simples.

Na integração com banco de dados, foi utilizado o PostgreSQL, e para possibilitar o consumo do mesmo foi utilizado o Phoenix Framework com Elixir.

Para a visualização do PDF com texto formatado em tempo real, foi implementado através do sistema de channels do Phoenix. Para obter o seguinte resultado:

<L>
  \begin{figure}[H]
    \centering
    \caption{PDF Renderizado em Tempo Real.}
    \includegraphics[width=15cm]{figures/PDF Render.jpg}
    \textual{Fonte: Dos Autores (2019).}
  \end{figure}
</L>

O projeto possui sistema de Login e autenticação, para que os usuários possam ter seus próprios projetos e compartilhá-los com outras pessoas.

<L>
  \begin{figure}[H]
    \centering
    \caption{Tela de Login.}
    \includegraphics[width=16cm]{figures/Tela Login - FATEX.jpeg}
    \textual{Fonte: Dos Autores (2019).}
  \end{figure}

  \begin{figure}[H]
    \centering
    \caption{Tela de Edição de Cadastro de Usuário.}
    \includegraphics[width=16cm]{figures/Tela Criar Usuario - FATEX.jpeg}
    \textual{Fonte: Dos Autores (2019).}
  \end{figure}
</L>

O usuário também pode editar as informações de sua conta.

<L>
  \begin{figure}[H]
    \centering
    \caption{Tela de Edição de Edição de Usuário.}
    \includegraphics[width=16cm]{figures/Tela Editar Usuario - FATEX.jpeg}
    \textual{Fonte: Dos Autores (2019).}
  \end{figure}
</L>

Após fazer login, o usuário tem acesso a todos os seus documentos já desenvolvidos e compartilhados.

<L>
  \begin{figure}[H]
    \centering
    \caption{Tela Inicial do Sistema.}
    \includegraphics[width=16cm]{figures/Tela Inicial - FATEX.jpeg}
    \textual{Fonte: Dos Autores (2019).}
  \end{figure}
</L>

O usuário pode criar documentos definindo nome e template.

<L>
  \begin{figure}[H]
    \centering
    \caption{Tela de Criação de Documentos.}
    \includegraphics[width=16cm]{figures/Tela Adicionar Projeto - FATEX.jpeg}
    \textual{Fonte: Dos Autores (2019).}
  \end{figure}
</L>

Ao abrir um documento ou criar um novo, é exibido um simples tutorial do uso do sistema.

<L>
  \begin{figure}[H]
    \centering
    \caption{Tela Inicial dos Documentos.}
    \includegraphics[width=16cm]{figures/Tela Inicial do Projeto - FATEX.jpeg}
    \textual{Fonte: Dos Autores (2019).}
  \end{figure}

  \begin{figure}[H]
    \centering
    \caption{Tela de Edição de Documentos.}
    \includegraphics[width=16cm]{figures/Tela Editar Projeto - FATEX.jpeg}
    \textual{Fonte: Dos Autores (2019).}
  \end{figure}
</L>

Também é possível compartilhas seus documentos com outros usuários permitindo-os editar e comentar.

<L>
  \begin{figure}[H]
    \centering
    \caption{Tela de Compartilhamento.}
    \includegraphics[width=16cm]{figures/Tela Compartilhar Projeto - FATEX.jpeg}
    \textual{Fonte: Dos Autores (2019).}
  \end{figure}
</L>
"""

results_and_discussions_start = ~S"""
\section{Resultados e Discussões}
"""

results_and_discussions = ~S"""
Resultados Resultados Resultados Resultados Resultados Resultados Resultados Resultados Resultados Resultados Resultados Resultados Resultados.
"""

final_considerations_start = ~S"""
\section{Conclusões}
"""

final_considerations = ~S"""
Conclusões Conclusões Conclusões Conclusões Conclusões Conclusões Conclusões Conclusões Conclusões Conclusões Conclusões Conclusões Conclusões.
"""

references_start = ~S"""
\section{Referências}
\raggedright
"""

references = ~S"""
<L>
BRACHET, Pascal. \textbf{TEXMARKER: Free cross-platform LaTeX editor since 2003.} [S. l.], 2003 - 2019. Disponível em: https://www.xm1math.net/texmaker/download.html. Acesso em: 10 jul. 2019.

DAVIS, Philip M.; WALTERS, William H. \textbf{The impact of free access to the scientific literature: a review of recent research.} Journal of the Medical Library Association: JMLA, v. 99, n. 3, p. 208, 2011.

DEBENEDETTO, Sophie. \textbf{Walk-Through of Phoenix LiveView: What is LiveView?} [S. l.], 19 mar. 2019. Disponível em: https://elixirschool.com/blog/phoenix-live-view/. Acesso em: 20 out. 2019.

DONALD, E. K. \textbf{The TEXbook, volume A of Computers and Typesetting.} [S. l.]: Addison-Wesley, Reading, Massachusetts” 1989.

GROZA, Tudor et al. \textbf{SALT-Semantically Annotated {LaTeX} for Scientific Publications.} In: European Semantic Web Conference. Springer, Berlin, Heidelberg, 2007. p. 518-532.

GOOGLE PLAY. \textbf{VerbTeX LaTeX Editor.} [S. l.], 2 abr. 2019. Disponível em: https://play.google.com/store/apps/details?id=verbosus.verbtex&hl=pt-BR. Acesso em: 20 maio 2019a.

GOOGLE PLAY. \textbf{NeutriNote.} [S. l.], 8 jun. 2019. Disponível em: https://play.google.com/store/apps/details?id=com.appmindlab.nano. Acesso em: 24 jun. 2019b.

GOOGLE PLAY. \textbf{LawTeX.} [S. l.], 12 dez. 2018. Disponível em: https://play.google.com/store/apps/details?id=law.tex. Acesso em: 24 jun. 2019c.

GOOGLE PLAY. \textbf{TeX Writer - LaTeX On the Go.} [S. l.], 28 nov. 2017. Disponível em: https://play.google.com/store/apps/details?id=com.litchie.texwriter. Acesso em: 24 jun. 2019d.

LAMPORT, L. \textbf{LATEX: a document preparation system: user’s guide and reference manual.} [S. l.]: Addison-wesley, 1994.

MARCIAL, E. C. O. \textbf{Megatendências mundiais 2030: o que entidades e personalidades internacionais pensam sobre o futuro do mundo?: contribuição para um debate de longo prazo para o brasil.} Instituto de Pesquisa Econômica Aplicada (Ipea), 2015.

THE POSTGRESQL GLOBAL DEVELOPMENT GROUP. \textbf{PostgreSQL: The World‘s Most Advanced Open Source Relational Database: New to PostgreSQL?.} [S. l.], 2019. Disponível em: https://www.postgresql.org/. Acesso em: 18 ago. 2019.

MUNDIAL, B. \textbf{Relatório sobre o desenvolvimento mundial de 2012, visão geral: Igualdade de gênero e desenvolvimento.} Washington: Banco Internacional de Reconstrução e Desenvolvimento e Banco Mundial, 2011.

PLATAFORMATEC. \textbf{Elixir.} [S. l.], 2019. Disponível em: https://elixir-lang.org/. Acesso em: 1 nov. 2019.

OETIKER, T. et al. \textbf{The not so short introduction to latex 2.} Or LATEX 2d in, Citeseer, v. 69, 2011.

SUTHERLAND, J. \textbf{Scrum: a arte de fazer o dobro do trabalho na metade do tempo.} [S. l.]: Leya, 2016.

ZANDER, Benito van der. \textbf{TeXstudio: LaTeX made comfortable. 2.12.16.} [S. l.], 19 maio 2019. Disponível em: https://www.texstudio.org/. Acesso em: 11 jul. 2019.
ZIEGELMAYER, Friedel. \textbf{Argon2_elixir: Argon2. 2.1.2.} [S. l.], 2019. Disponível em: https://hexdocs.pm/argon2-elixir/Argon2.html. Acesso em: 20 nov. 2019.
</L>
"""

references_end = ~S"""
\end{document}
"""

alias Fatex.Repo
alias Fatex.LatexConfigs.{Model, Step, Section}
alias Fatex.Accounts.User

# Em tabelas root o nome é ignorado caso latex_name_start ou latex_name_end não for contiverem algo, em tabelas filhas o nome é usado com o begin{NAME} caso não houver os dados acima

# TODO: adicionar no meno possibilidade de imagens
# %Section{
#  name: "Image",
#  content: "",
#  type: "template"
# }
Repo.insert!(%User{
  name: "vinicius",
  email: "vinicius_molina@hotmail.com",
  password_hash: Argon2.add_hash("test")[:password_hash],
  models: [
    %Model{
      name: "Fatec Rio Preto TG",
      is_template: true,
      steps: [
        %Step{
          name: "Informações",
          sections: [
            %Section{
              name: "Titulo",
              content: title,
              latex_start: configuration <> title_start,
              latex_end: title_end,
              type: "root"
            },
            %Section{
              name: "Nome autores",
              content: autor_name,
              latex_start: autor_name_start,
              latex_end: autor_name_end,
              type: "root"
            },
            %Section{
              name: "Email autores",
              content: mail_autors,
              latex_start: mail_autor_start,
              latex_end: mail_autor_end,
              type: "root"
            }
          ]
        },

        %Step{
          name: "Resumo",
          sections: [
            %Section{
              name: "Resumo",
              content: resumo,
              latex_start: resumo_start,
              type: "root"
            },
            %Section{
              name: "Palavras chaves",
              content: keywords,
              latex_start: keywords_start,
              latex_end: keywords_end,
              type: "root"
            },
            %Section{
              name: "Abstract",
              content: abstract,
              latex_start: abstract_start,
              type: "root"
            },
            %Section{
              name: "Abstract keywords",
              content: abstract_keywords,
              latex_start: abstract_keywords_start,
              latex_end: abstract_keywords_end,
              type: "root"
            }
          ]
        },

        %Step{
          name: "Introdução",
          sections: [
            %Section{
              name: "Introdução",
              content: introduction,
              latex_start: introduction_start,
              type: "root"
            },
            %Section{
              name: "Justificativa",
              content: justification,
              latex_start: justification_start,
              type: "root"
            },
            %Section{
              name: "Objetivo",
              content: objective,
              latex_start: objective_start,
              type: "root"
            },
            %Section{
              name: "Fundamentação Teorica",
              content: fundamentation,
              latex_start: fundamentation_start,
              type: "root"
            },
            %Section{
              name: "Trabalhos Similares",
              content: other_works,
              latex_start: other_works_start,
              type: "root"
            }
          ]
        },

        %Step{
          name: "Desenvolvimento",
          sections: [
            %Section{
              name: "Metodologia",
              content: metodology,
              latex_start: metodology_start,
              type: "root"
            },
            %Section{
              name: "Plano de Trabalho",
              content: "",
              type: "root"
            },
            %Section{
              name: "Cronograma",
              content: "",
              type: "root"
            },
            %Section{
              name: "Desenvolvimento",
              content: development,
              latex_start: development_start,
              type: "root"
            }
          ]
        },

        %Step{
          name: "Testes e Resultados",
          sections: [
            %Section{
              name: "Resultados",
              content: results_and_discussions,
              latex_start: results_and_discussions_start,
              type: "root"
            }
          ]
        },

        %Step{
          name: "Discussão e Conclusão",
          sections: [
            %Section{
              name: "Conciderações Finais",
              content: final_considerations,
              latex_start: final_considerations_start,
              type: "root"
            }
          ]
        },

        %Step{
          name: "Referencias",
          sections: [
            %Section{
              name: "Referencia Bibliografica",
              content: references,
              latex_start: references_start,
              latex_end: references_end,
              type: "root"
            }
          ]
        }
      ]
    }
  ]
})

# Second user for tests
Repo.insert!(%User{
  name: "vinicius2",
  email: "vinicius_m@hotmail.com",
  password_hash: Argon2.add_hash("test")[:password_hash],
  models: []
})
