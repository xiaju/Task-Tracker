# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Spatracker.Repo.insert!(%Spatracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Spatracker.Repo
alias Spatracker.Users.User
alias Spatracker.Tasks.Task

pwhash = Argon2.hash_pwd_salt("pass1")

Repo.insert!(%User{name: "justin", password_hash: pwhash})
Repo.insert!(%User{name: "ethan", password_hash: pwhash})

alias Spatracker.Tasks.Task
Repo.insert!(%Task{name: "Rubber Duck", desc: "Yellow",
                      complete: false, time: 15})
Repo.insert!(%Task{name: "Bear", desc: "500lbs; angry",
                      complete: true, time: 30})
