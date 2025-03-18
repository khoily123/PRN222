using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Authorization;
using ScoreManagement.Models;
using Microsoft.EntityFrameworkCore;


namespace ScoreManagement.Pages.AdminMenu
{
    [Authorize(Roles = "ADMIN")]
    public class AdminDashboardModel : PageModel
    {
        private readonly Project_PRN222Context _context;

        public AdminDashboardModel(Project_PRN222Context context)
        {
            _context = context;
        }

        // Properties for storing statistics
        public int TotalStudents { get; set; }
        public int TotalLecturers { get; set; }
        public int TotalCourses { get; set; }

        public int TotalClasses { get; set; }   
        public int TotalAccounts { get; set; }  
        public int TotalMajors { get; set; }

        // Properties for storing statistics
        public int PassedCount { get; set; }
        public int FailedCount { get; set; }

        // OnGet method to populate statistics
        public async Task OnGetAsync()
        {
            // Query the database to get the count for each statistic
            TotalStudents = await _context.Students.CountAsync();
            TotalLecturers = await _context.Lecturers.CountAsync();
            TotalCourses = await _context.Courses.CountAsync();

            TotalClasses = await _context.Classes.CountAsync();    
            TotalAccounts = await _context.Accounts.CountAsync();  
            TotalMajors = await _context.Majors.CountAsync();

            // Query the database to get the count of passed and failed students
            PassedCount = await _context.Grades.CountAsync(g => g.Status == "Pass");
            FailedCount = await _context.Grades.CountAsync(g => g.Status == "Not Pass");
        }
    }
}
