import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';
import _ from 'lodash'

/*

this.state = {
  users: [],
  tasks: [],
  cur_task: null,
  session: null,
  login_form: {name: "", password: ""},
  task_form: {name: "", time: "", complete: "", desc:"", id:""},
  user_form: {name: "", password: ""},
}

*/

function users(state = [], action) {
  switch (action.type) {
    case 'USER_LIST':
      return action.data;
    default:
      return state;
  }
  return state;
}

function tasks(state = [], action) {
  switch (action.type) {
    case 'TASK_LIST':
      return action.data;
    default:
      return state;
  }
  return state;
}

let cur_task0 = {name: "", time: "", complete: "", desc:"",
                  id:"", assignee:""};
function cur_task(state = cur_task0, action) {
  switch (action.type) {
    case 'UPDATE_CUR_TASK':
      let state1 = {}
      return _.assign(state1, state, action.data)
    default:
      return state
    }
}

function session(state = null, action) {
  switch (action.type) {
    case 'UPDATE_SESSION':
      return action.data
    default:
      return state
    }
}

let login_form0 = {name: "", password: ""};
function login_form(state = login_form0, action) {
  switch (action.type) {
    case 'UPDATE_LOGIN_FORM':
      let state1 = {}
      return _.assign(state1, state, action.data)
    default:
      return state
  }
}

let task_form0 = {name: "", time: "", complete: "", desc:"",
                  id:"", assignee:""};
function task_form(state = task_form0, action) {
  switch (action.type) {
    case 'UPDATE_TASK_FORM':
      let state1 = {}
      return _.assign(state1, state, action.data)
    default:
      return state
  }
}

let user_form0 = {name: "", password: ""};
function user_form(state = user_form0, action) {
  switch (action.type) {
    case 'UPDATE_USER_FORM':
      let state1 = {}
      return _.assign(state1, state, action.data)
    default:
      return state
  }
}

function root_reducer(state0, action) {
  let reducer = combineReducers({users, tasks, cur_task, session, login_form,
                                 task_form, user_form});
  let state1 = reducer(state0, action);
  return deepFreeze(state1);
}

let store = createStore(root_reducer);
export default store;
