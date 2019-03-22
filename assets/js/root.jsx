import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';
import $ from 'jquery';
import { Link, BrowserRouter as Router, Route } from 'react-router-dom';
import { connect } from 'react-redux'
import { Provider } from 'react-redux'
import store from './store'

export default function root_init(node, store) {
  let tasks = window.tasks;
  ReactDOM.render(
    <Provider store={store}>
      <Root />
    </Provider>, node);
}

class Root extends React.Component {
  constructor(props) {
    super(props)
    fetch_users();
    fetch_tasks();
  }

  render() {
    return <Router>
      <div>
        <NewHeader />
        <Route path="/edit" exact={true} render={() =>
          <div>
            <NewEditTask />
          </div>
        } />
        <Route path="/users" exact={true} render={() =>
          <div>
            <NewUserList />
            <NewAddUser />
          </div>
        } />
        <Route path="/" exact={true} root={this} render={() =>
          <div>
            <Newtaskslist />
            <Newplist />
          </div>
        } />
      </div>
    </Router>
  }
}

function Header(props) {
  let {session} = props;
  let session_info
  if (session == null) {
    session_info = <div className="form-inline my-2">
      <input type="name" placeholder="name"
        onChange={(ev) => update_login_form({name: ev.target.value})}>
      </input>
      <input type="password" placeholder="password"
        onChange={(ev) => update_login_form({password: ev.target.value})}>
      </input>
      <button className="btn btn-secondary" onClick={() => login()}>Login</button>
    </div>
  } else {
    session_info = <div className="my-2">
      <p>Logged in as {session.user_name}</p>
      <button className="btn btn-secondary" onClick={() => logout()}>Logout</button>
    </div>
  }

  return <div className="row my-2">
    <div className="col-4">
      <h1>Task Tracker</h1>
    </div>
    <div className="col-4">
      <p>
        <Link className="btn btn-info" to={"/"}>Tasks</Link>
        <Link className="btn btn-info" to={"/users"}>Users</Link>
      </p>
    </div>
    <div className="col-4">
      {session_info}
    </div>
  </div>;
}

function login() {
  $.ajax("/api/v1/auth", {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: JSON.stringify(store.getState().login_form),
    success: (resp) => {
      let action = {
        type: 'UPDATE_SESSION',
        data: resp.data,
      }
      store.dispatch(action)
    }
  });
}

function logout() {
  let action = {
    type: 'UPDATE_SESSION',
    data: null,
  }
  store.dispatch(action)
}

function update_login_form(data) {
  let action = {
    type: 'UPDATE_LOGIN_FORM',
    data: data,
  }
  store.dispatch(action)
}

function state2propsheader(state) {
  return {
    login_form: state.login_form,
    session: state.session
  };
}

let NewHeader = connect(state2propsheader)(Header);

function TaskList(props) {
  let tasks = _.map(props.tasks, (t) => <Task key={t.id} task={t} />);
  return <div className="row">
    {tasks}
  </div>;
}

function Task(props) {
  let {task, dispatch} = props;
  return <div className="card col-4">
    <div className="card-body">
      <h2 className="card-title">{task.name}</h2>
      <p className="card-text">{task.desc} <br/>
      complete: {String(task.complete)}<br/>
      assignee: {task.user ? String(task.user) : ""}<br/>
      time: {task.time}<br/></p>
      <button className="btn btn-danger"
        onClick={() => delete_task(task.id)}>Delete
      </button>
      <Link className="btn btn-dark"
        onClick={() => set_cur_task(task)}
        to={"/edit"}>Edit</Link>
    </div>
  </div>;
}

function state2propstasks(state) {
  return {
    tasks: state.tasks,
  };
}

let Newtaskslist = connect(state2propstasks)(TaskList);

function AddTask(props) {
  let task_form = store.getState().task_form
  let {dispatch} = props
  return <div className="my-2">
    <div className="row"><input type="name" placeholder="Title"
      onChange={(ev) => update_task_form({name: ev.target.value}, dispatch)}>
    </input></div>
    <div className="row"><input type="desc" placeholder="Description"
      onChange={(ev) => update_task_form({desc: ev.target.value}, dispatch)}>
    </input></div>
    <div className="row"><input type="assignee" placeholder="Assignee"
      onChange={(ev) => update_task_form({assignee: ev.target.value}, dispatch)}>
    </input></div>
    <div className="row"><label className="label">Complete</label>
    <input type="checkbox"
      onChange={(ev) => update_task_form({complete: (task_form.complete ? false : true)}, dispatch)}>
    </input></div>
    <div className="row"><input type="number" placeholder="Time" step="15"
      min="0"
      onChange={(ev) => update_task_form({time: ev.target.value}, dispatch)}>
    </input></div>
    <button className="btn btn-primary" onClick={() => add_task()}>Add Task</button>
  </div>
}

function update_task_form(data, dispatch) {
  let action = {
    type: 'UPDATE_TASK_FORM',
    data: data,
  }
  dispatch(action)
}


function fetch_tasks() {
    $.ajax("/api/v1/tasks", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        store.dispatch({
          type: 'TASK_LIST',
          data: resp.data,
        })
      },
    });
  }

function add_task() {
  let state = store.getState();
  $.ajax("/api/v1/tasks", {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: JSON.stringify({task: state.task_form}),
    success: (resp) => {
      fetch_tasks();
    }
  });
}

function state2props(state) {
  return {
    task_form: state.task_form,
  };
}

let Newplist = connect(state2props)(AddTask);

function delete_task(task_id) {
  $.ajax(`/api/v1/tasks/${task_id}`, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: (resp) => {
      fetch_tasks();
    }
  });
}

function edit_task(task) {
  $.ajax(`/api/v1/tasks/${task.id}`, {
    method: "put",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: JSON.stringify({task: task}),
    success: (resp) => {
      fetch_tasks();
    }
  });
}

function set_cur_task(task) {
  let taskCopy = _.clone(task)

  Object.keys(taskCopy).map(function(key, index) {
    if (taskCopy[key] == null) {
      taskCopy[key] = ""
    }
  })

  let action = {
    type: 'UPDATE_CUR_TASK',
    data: _.assign({}, taskCopy, {assignee: taskCopy.user})
  }
  store.dispatch(action)
}


function update_cur_task(attr) {
    let form1 = _.assign({}, store.getState().cur_task, attr);
    let action = {
      type: 'UPDATE_CUR_TASK',
      data: form1,
    }
    store.dispatch(action)
  }

function state2propsedittask(state) {
  return {
    cur_task: state.cur_task,
  };
}

let NewEditTask = connect(state2propsedittask)(EditTask);

function fetch_users() {
  $.ajax("/api/v1/users", {
    method: "get",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: (resp) => {
      store.dispatch({
        type: 'USER_LIST',
        data: resp.data,
      })
    },
  })
}

function add_user() {
  $.ajax("/api/v1/users", {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: JSON.stringify({user: store.getState().user_form}),
    success: (resp) => {
      fetch_users();
    }
  });
}

function delete_user(user_id) {
  $.ajax(`/api/v1/users/${user_id}`, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: (resp) => {
      fetch_users();
    }
  });
}

function update_user_form(data, dispatch) {
  let action = {
    type: 'UPDATE_USER_FORM',
    data: data,
  }
  dispatch(action)
}

function state2propsuserform(state) {
  return {
    user_form: state.user_form,
  };
}

let NewAddUser = connect(state2propsuserform)(AddUser)

function UserList(props) {
  let rows = _.map(store.getState().users, (uu) => <User key={uu.id} user={uu} />);
  return <div className="row">
    <div className="col-12">
      <table className="table table-striped">
        <thead>
          <tr>
            <th>name</th>
          </tr>
        </thead>
        <tbody>
          {rows}
        </tbody>
      </table>
    </div>
  </div>;
}

function User(props) {
  let {user} = props;
  return <tr>
    <td>{user.name}</td>
    <td>
      <button className="btn btn-danger"
        onClick={() => delete_user(user.id)}>Delete
      </button>
    </td>
  </tr>;
}

function state2propsuserlist(state) {
  return {
    users: state.users,
  };
}

let NewUserList = connect(state2propsuserlist)(UserList)

function AddUser(props) {
  let {dispatch} = props
  return <div className="my-2">
    <div className="row"><input type="name" placeholder="name"
      onChange={(ev) => update_user_form({name: ev.target.value}, dispatch)}>
    </input></div>
    <div className="row"><input type="password" placeholder="password"
      onChange={(ev) => update_user_form({password: ev.target.value}, dispatch)}>
    </input></div>
    <button className="btn btn-primary" onClick={() => add_user()}>Add User</button>
  </div>
}

function EditTask(props) {
  let cur_task = store.getState().cur_task
  return <div className="my-2">
    <div className="row"><input type="name" placeholder="Title"
      value={cur_task.name}
      onChange={(ev) => update_cur_task({name: ev.target.value})}>
    </input></div>
    <div className="row"><input type="desc" placeholder="Description"
      value={cur_task.desc}
      onChange={(ev) => update_cur_task({desc: ev.target.value})}>
    </input></div>
    <div className="row"><input type="assignee" placeholder="Assignee"
      value={cur_task.assignee}
      onChange={(ev) => update_cur_task({assignee: ev.target.value})}>
    </input></div>
    <div className="row"><label className="label">Complete</label>
    <input type="checkbox" checked={cur_task.complete}
      onChange={(ev) => update_cur_task({complete: !cur_task.complete})}>
    </input></div>
    <div className="row"><input type="number" placeholder="Time" step="15"
      value={cur_task.time} min="0"
      onChange={(ev) => update_cur_task({time: ev.target.value})}>
    </input></div>
    <button className="btn btn-primary"
      onClick={() => edit_task(cur_task)}>Edit Task
    </button>
  </div>
}
