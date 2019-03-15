# Tasktracker

When users enter the index page, they are directed to a page that prompts
them to either log in or register. I put those features in first because
this app is a task tracking app and a user can't track their tasks before
logging in.

Upon logging in, users are directed back to the index page where they view
their remaining tasks on a floating sidebar as well as a log out button.
Additionally, users can view the status of their underlings' tasks here
In order to not pollute the sidebar, users will only be able to see the title, 
status, and links to show or delete the task. Also, the index page will change 
to display the number of tasks a user has remaining. If a user wants to edit
one of their own or underling's tasks, they can click on the show link and 
then click on the edit link. I chose to omit an edit link from the sidebar 
in an effort to conserverve page space.

Users can click on the Tasks link on the navbar to view the list of all tasks.
From here they can view, edit, or delete any task they choose. To change any
task property, users can user the edit link. Additionally, users can choose to
create a new task on this page. While I opted to make all fields available for
convenience as a user might immediately want to make a task complete or assign
a task, I left those fields as optional as per the assignment instructions. 
The only fields that have to be filled out when adding or editting a task are 
title and description. If a user is logged in, they'll have access to an
"assignee" selection field which allows them to choose which of their underlings
to assign the task to. Having "assignee" as a selection field instead of text
input allowed me to restrict any invalid input and simplify server logic

Additionally, by showing a task, users will have access to a task's timeblocks.
Start and Stop can be used to create a new timeblock. Time blocks also
are input fields that can be editted, so a time block can be changed once
it's created. To change a time block, edit the input to the desired value and
click the edit button next to that input. Times are written as and displayed
in POSIX time because my times are represented in POSIX time on the server
and this representation made the translation from server side to client side
easiest. 

The other link on the navbar, Users allows users to view and edit other users


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
