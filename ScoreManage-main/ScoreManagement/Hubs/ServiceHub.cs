using Microsoft.AspNetCore.SignalR;

namespace ScoreManagement.Hubs
{
    public class ServiceHub : Hub
    {
        public async Task SendAccount()
        {
            await Clients.All.SendAsync("ReceiveAccount");
        }
        public async Task SendClassCourse()
        {
            await Clients.All.SendAsync("ReceiveClassCourse");
        }
        public async Task SendClass()
        {
            await Clients.All.SendAsync("ReceiveClass");
        }
        public async Task SendCourse()
        {
            await Clients.All.SendAsync("ReceiveCourse");
        }
        public async Task SendGrade()
        {
            await Clients.All.SendAsync("ReceiveGrade");
        }
        public async Task SendLecturer()
        {
            await Clients.All.SendAsync("ReceiveLecturer");
        }
        public async Task SendStudent()
        {
            await Clients.All.SendAsync("ReceiveStudent");
        }

        public async Task SendMajor()
        {
            await Clients.All.SendAsync("ReceiveMajor");
        }
        public async Task SendSemesters()
        {
            await Clients.All.SendAsync("ReceiveSemester");
        }
        public async Task SendStudentClass()
        {
            await Clients.All.SendAsync("ReceiveStudentClass");
        }
        public async Task SendStudentCourse()
        {
            await Clients.All.SendAsync("ReceiveStudentCourse");
        }
    }
}
