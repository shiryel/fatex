# Fatex

Fatex is a symple visual wrapper of the Latex, creating beautiful texts without all the complexity of the Latex.

![](/maker/1/figures/Tela%20Login%20-%20FATEX.jpeg)

![](/maker/1/figures/Tela%20Inicial%20do%20Projeto%20-%20FATEX.jpeg)

![](/maker/1/figures/Tela%20Editar%20Projeto%20-%20FATEX.jpeg)

## Modules

LiveView:
- Home -> Screen were the user create/delete/select the projects
- Model -> Screen to do the Fatex work, controls the Menu, Step, Section and Render modules
- ModelList -> Screen to create new Models based on other Models (defined in the database [seeds] as templates)
- Menu -> Lateral menu to add images and sub-topics
- Step -> Top menu to choose the step to work
- Section -> Sections of a Step
- Render -> To render the PDF (gen a id to re-render)

Controllers:
- LoginController -> Screen for user login
- UserController -> Screens to create and update users
- ModelShareController -> Screen to share models to other users
- Auth -> User authentication PLUG (used on routers)
- FileController -> To send the rendered PDF to the client

Some modules of the LiveView use the pubsub to update state in another LiveView modules (but need some fixes)

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

## TODO

- [ ] Image Upload (upload on maker per user)
- [ ] Make the PubSub per user
- [ ] Fix bug when you click into the topic and the screen go up
- [ ] Fix share between users
