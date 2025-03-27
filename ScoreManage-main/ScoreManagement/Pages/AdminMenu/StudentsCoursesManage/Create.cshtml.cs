using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Hubs;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.StudentsCoursesManage
{
    [Authorize(Roles = "ADMIN")]
    public class CreateModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        private readonly IHubContext<ServiceHub> _signalRServices;

        public CreateModel(ScoreManagement.Models.Project_PRN222Context context, IHubContext<ServiceHub> signalRServices)
        {
            _context = context;
            _signalRServices = signalRServices;
        }

        public IActionResult OnGet()
        {
            ViewData["ClassId"] = new SelectList(_context.Classes, "ClassId", "ClassId");
            ViewData["CourseId"] = new SelectList(_context.Courses, "CourseId", "CourseName");
            ViewData["LecturerId"] = new SelectList(_context.Lecturers, "LecturerId", "LecturerName");
            ViewData["SemesterId"] = new SelectList(_context.Semesters, "SemesterId", "SemesterCode");
            ViewData["StudentId"] = new SelectList(_context.Students, "StudentId", "StudentCode");
            return Page();
        }

        [BindProperty]
        public StudentsCourse StudentsCourse { get; set; } = default!;
        

        // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
        public async Task<IActionResult> OnPostAsync()
        {
            ViewData["ClassId"] = new SelectList(_context.Classes, "ClassId", "ClassId");
            ViewData["CourseId"] = new SelectList(_context.Courses, "CourseId", "CourseName");
            ViewData["LecturerId"] = new SelectList(_context.Lecturers, "LecturerId", "LecturerName");
            ViewData["SemesterId"] = new SelectList(_context.Semesters, "SemesterId", "SemesterCode");
            ViewData["StudentId"] = new SelectList(_context.Students, "StudentId", "StudentCode");
            if (StudentsCourse.StudentId == 0)
            {
                ModelState.AddModelError("StudentsCourse.StudentId", "Please select a student.");
            }

            if (StudentsCourse.CourseId == 0)
            {
                ModelState.AddModelError("StudentsCourse.CourseId", "Please select a course.");
            }

            if (StudentsCourse.ClassId == 0)
            {
                ModelState.AddModelError("StudentsCourse.ClassId", "Please select a class.");

            }

            if (StudentsCourse.SemesterId == 0)
            {
                ModelState.AddModelError("StudentsCourse.SemesterId", "Please select a semester.");

            }

            if (StudentsCourse.LecturerId == 0)
            {
                ModelState.AddModelError("StudentsCourse.LecturerId", "Please select a lecturer.");

            }
            var isExist = await _context.StudentsCourses.AnyAsync(sc =>
        sc.StudentId == StudentsCourse.StudentId &&
        sc.CourseId == StudentsCourse.CourseId &&
        sc.ClassId == StudentsCourse.ClassId);

            if (isExist)
                ModelState.AddModelError("", "This student is already registered for this course in the selected class.");

            if (!ModelState.IsValid)
                return Page();

            // Thêm dữ liệu mới
            _context.StudentsCourses.Add(StudentsCourse);
            await _context.SaveChangesAsync();
            await _signalRServices.Clients.All.SendAsync("ReceiveStudentCourse");

            return RedirectToPage("./Index");
        }
        public async Task<JsonResult> OnGetStudentInfo(int studentId)
        {
            var student = await _context.Students
                .Where(s => s.StudentId == studentId)
                .Select(s => new { s.StudentCode, s.FullName })
                .FirstOrDefaultAsync();

            return new JsonResult(student);
        }
        public async Task<JsonResult> OnGetClassCode(int classId)
        {
            var classCode = await _context.Classes
                .Where(c => c.ClassId == classId)
                .Select(c => c.ClassCode)
                .FirstOrDefaultAsync();

            return new JsonResult(classCode);
        }

        public async Task<JsonResult> OnGetGetSemesterByClass(int classId)
        {
            var semester = await _context.Classes
                .Where(c => c.ClassId == classId)
                .Select(c => new { c.SemesterId, c.Semester.SemesterCode })
                .FirstOrDefaultAsync();

            return new JsonResult(semester);
        }

        public async Task<JsonResult> OnGetGetClassesByCourse(int courseId)
        {
            var classes = await _context.ClassCourses
                .Where(cc => cc.CourseId == courseId)
                .Select(cc => new { cc.ClassId, cc.Class.ClassCode })
                .ToListAsync();

            return new JsonResult(classes);
        }

        public async Task<JsonResult> OnGetGetLecturerByClassAndCourse(int classId, int courseId)
        {
            var lecturer = await _context.ClassCourses
                .Where(cc => cc.ClassId == classId && cc.CourseId == courseId)
                .Select(cc => new { cc.LecturerId, cc.Lecturer.LecturerName })
                .FirstOrDefaultAsync();

            return new JsonResult(lecturer);
        }
    }
}
