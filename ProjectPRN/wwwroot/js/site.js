// Please see documentation at https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
"use strict";

var connection = new signalR.HubConnectionBuilder().withUrl("/productHub").build();

connection.on("ReceiveProduct", function () {

    location.href = "/Products/Index";
});

connection.start().then(() => {
    console.log("SignalR Connected.");
}).catch(function (err) {
    console.error("SignalR connection error: " + err.toString());
});