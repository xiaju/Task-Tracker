// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;
import "bootstrap";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
$(function () {
  let start_time = 0

  $('#start-button').click((ev) => {
    let d = new Date();

    start_time = d;
  });

  $('#end-button').click((ev) => {
    let task_id = $(ev.target).data('task-id');
    let d = new Date();

    let text = JSON.stringify({
      time_block: {
        task_id: task_id,
        start: start_time.getTime(),
        end: d.getTime(),
      },
    });

    $.ajax(timeblock_path, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {
        window.location.reload(false)
      },
    });
  });

  $('.edit-timeblock').click((ev) => {
    console.log("clicked")
    let tb_id = $(ev.target).data('tb-id');
    let startVal = $('#start' + tb_id).val();
    let endVal = $('#end' + tb_id).val();
    let path = $(ev.target).data('path');
    let d = new Date();
    console.log(startVal);
    console.log(endVal);
    let text = JSON.stringify({
      time_block: {
        start: startVal,
        end: endVal,
      },
    });
    console.log("here")
    $.ajax(path, {
      method: "put",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {
        window.location.reload(false)
      },
    });
  });
});
