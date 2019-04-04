# Design Choices
Spatracker is divided into 3 react routes - tasks, users, and edit tasks. When entering Spatracker, 
a user starts off on the tasks page. On this page, a user can create tasks with a title, description, 
assignee, time, and status. Due to the fact that I had to manually generate input boxes instead of relying 
on elixir forms, my input boxes do minimal error checking. An error in an input box will result in the 
change not going through, but there will be no error message. This was a design choice to simplify the 
code and the user must ensure that they enter information correctly themselves. 

Clicking "edit" on a task will take a user to the edit task page. Here, users can edit tasks that they
previously entered. Fitting with the requirements of the assignment, and to simplify programming, anyone
can edit any task.

Additionally, there is a "users" page with 2 parts. At the top of the page, all users are listed. Users
are listed by name and can be deleted. Below that list, there is an input form to add a new user using
a name and password. As passwords are required for login, both fields are required.

To login, users enter their username and password in the input form at the top right corner of the page.
Logins persist only per page load and dissapear after a user refreshes a page. This design decision was
made because users in SPAs should not need to refresh the page while visiting.

# Spatracker

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
