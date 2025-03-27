using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Hubs;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.StudentsCoursesManage
{
    public class BulkCreateModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        private readonly IHubContext<ServiceHub> _signalRServices;

        public BulkCreateModel(ScoreManagement.Models.Project_PRN222Context context, IHubContext<ServiceHub> signalRServices)
        {
            _context = context;
            _signalRServices = signalRServices;
        }

        public IActionResult OnGet()
        {
            ViewData["Classes"] = new SelectList(_context.Classes, "ClassId", "ClassCode");
            ViewData["Courses"] = new SelectList(_context.Courses, "CourseId", "CourseName");
            return Page();
        }

        // API lấy danh sách sinh viên theo lớp
        public async Task<JsonResult> OnGetGetStudentsByClass(int classId)
        {
            var students = await _context.StudentClasses
                .Where(sc => sc.ClassId == classId) // Lọc theo classId
                .Select(sc => new
                {
                    sc.Student.StudentId,
                    sc.Student.StudentCode,
                    sc.Student.FullName
                })
        .ToListAsync();

            return new JsonResult(students);
        }

        [BindProperty]
        public List<int> SelectedStudents { get; set; } = new List<int>();

        [BindProperty]
        public int ClassId { get; set; }

        [BindProperty]
        public int CourseId { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            ViewData["Classes"] = new SelectList(_context.Classes, "ClassId", "ClassCode");
            ViewData["Courses"] = new SelectList(_context.Courses, "CourseId", "CourseName");

            if (SelectedStudents == null || SelectedStudents.Count == 0)
            {
                ModelState.AddModelError("", "No students selected.");
                return Page();
            }
            var classInfo = await _context.Classes
        .Where(c => c.ClassId == ClassId)
        .Select(c => new { c.SemesterId }) // Lấy SemesterId từ Classes
        .FirstOrDefaultAsync();

            if (classInfo == null)
            {
                ModelState.AddModelError("", "Selected class does not exist.");
                return Page();
            }

            if (CourseId == 0)
            {
                ModelState.AddModelError("", "Please select a course.");
                return Page();
            }
            //  Lấy danh sách StudentId đã có trong StudentCourse
            var existingStudentCourses = await _context.StudentsCourses
                .Where(sc => sc.ClassId == ClassId && sc.CourseId == CourseId)
                .Select(sc => sc.StudentId)
                .ToListAsync();
            //  Lọc sinh viên chưa có trong StudentCourse và thêm SemesterId
            var newStudentCourses = SelectedStudents
                .Where(studentId => !existingStudentCourses.Contains(studentId)) // Chỉ thêm sinh viên chưa có trong bảng
                .Select(studentId => new StudentsCourse
                {
                    StudentId = studentId,
                    ClassId = ClassId,
                    CourseId = CourseId,
                    SemesterId = classInfo.SemesterId,
                    LecturerId = _context.ClassCourses
                        .Where(cc => cc.ClassId == ClassId && cc.CourseId == CourseId)
                        .Select(cc => cc.LecturerId)
                        .FirstOrDefault()
                }).ToList();

            if (newStudentCourses.Count > 0)
            {
                _context.StudentsCourses.AddRange(newStudentCourses);
                await _context.SaveChangesAsync();
                await _signalRServices.Clients.All.SendAsync("ReceiveStudentCourse");
            }

            return RedirectToPage("./Index");
        }

        public async Task<JsonResult> OnGetGetCoursesByClass(int classId)
        {
            var courses = await _context.ClassCourses
                .Where(cc => cc.ClassId == classId)
                .Include(cc => cc.Course)
                .Select(cc => new
                {
                    cc.Course.CourseId,
                    cc.Course.CourseName
                }).ToListAsync();

            return new JsonResult(courses);
        }
    }
}
