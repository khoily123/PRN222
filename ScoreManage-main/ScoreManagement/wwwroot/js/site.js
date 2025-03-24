// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
"use strict";
//console.log(" Bắt đầu kết nối SignalR...");
//var connection = new signalR.HubConnectionBuilder()
//    .withUrl("/signalr")
//    .build();

//connection.start().then(() => {
//    console.log(" SignalR đã kết nối thành công!");
//}).catch(function (err) {
//    console.error(" Lỗi khi kết nối SignalR:", err);
//});

var connection = new signalR.HubConnectionBuilder().withUrl("/signalr").build();

connection.on("ReceiveAccount", function () {
    location.href = "/AdminMenu/AccountManage";
});
connection.on("ReceiveClassCourse", function () {

    location.href = "/AdminMenu/ClassCourseManage";
});
connection.on("ReceiveClass", function () {

    location.href = "/AdminMenu/ClassesManage";
});
connection.on("ReceiveCourse", function () {

    location.href = "/AdminMenu/CoursesManage";
});
connection.on("ReceiveGrade", function () {

    location.href = "/AdminMenu/GradeManage";
});
connection.on("ReceiveLecturer", function () {

    location.href = "/AdminMenu/LecturersManage";
});
connection.on("ReceiveStudent", function () {

    location.href = "/AdminMenu/StudentsManage";
});
connection.on("ReceiveMajor", function () {

    location.href = "/AdminMenu/MajorManage";
});
connection.on("ReceiveSemester", function () {

    location.href = "/AdminMenu/SemestersManage";
});
connection.on("ReceiveStudentClass", function () {

    location.href = "/AdminMenu/StudentClassesManage";
});
connection.on("ReceiveStudentCourse", function () {

    location.href = "/AdminMenu/StudentsCoursesManage";
});
connection.on("ReceiveDashboard", function () {

    location.href = "/AdminMenu/AdminDashboard";
});
connection.start().then(() => {
    console.log("SignalR Connected.");
}).catch(function (err) {
    console.error("SignalR connection error: " + err.toString());
});