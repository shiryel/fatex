# Fatex

Fatex is a symple visual wrapper of the Latex, creating beautiful texts without all the complexity of the Latex.

![](/maker/1/figures/Tela%20Login%20-%20FATEX.jpeg)

![](/maker/1/figures/Tela%20Inicial%20do%20Projeto%20-%20FATEX.jpeg)

![](/maker/1/figures/Tela%20Editar%20Projeto%20-%20FATEX.jpeg)

## To Run

Dependencies:
 * TexLive (complete)
 * Docker (for postgres)

To start the server:

  * `sudo docker-compose up -d`
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
