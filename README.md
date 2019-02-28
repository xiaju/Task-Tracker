# Tasktracker

When users enter the index page, they are directed to a page that prompts
them to either log in or register. I put those features in first because
this app is a task tracking app and a user can't track their tasks before
logging in.

Upon logging in, users are directed back to the index page where they view
their remaining tasks on a floating sidebar as well as a log out. In order to
not pollute the sidebar, users will only be able to see the title, status,
and links to show or delete the task. Additionally, the index page will change 
to display the number of tasks a user has remaining. If a user wants to edit
one of their own tasks, they can click on the show link and then click on the
edit link. I chose to omit an edit link from the sidebar in an effort to 
conserverve page space.

Users can click on the Tasks link on the navbar to view the list of all tasks.
From here they can view, edit, or delete any task they choose. To change any
task property, users can user the edit link. Additionally, users can choose to
create a new task on this page. While I opted to make all fields available for
convenience as a user might immediately want to make a task complete or assign
a task, I left those fields as optional as per the assignment instructions. 
The only fields that have to be filled out when adding or editting a task are 
title and description.

The other link on the navbar, Users allows users to view and edit other users
as well as view other users. This part is fairly straightforward, but one
design decision I had to make was to show the ID as a number. Unfortunately,
even though displaying tasks requires that a task can have a user reference,
a task in my implementation does not hold user names. Since we don't have
ajax calls in this assignment, displaying a task with it's associated
user name is impossible. In lieu of this, I opted to make ID a public number and allow
users to create associations between their ID and tasks themselves.

A logged in user will additionally have a "profile" link to view their user
and a "logout" link in a dropdown menu from the navbar to make accessing
those pages easier.



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
