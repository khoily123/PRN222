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
    public class EditModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        private readonly IHubContext<ServiceHub> _signalRServices;

        public EditModel(ScoreManagement.Models.Project_PRN222Context context, IHubContext<ServiceHub> signalRServices)
        {
            _context = context;
            _signalRServices = signalRServices;
        }

        [BindProperty]
        public StudentsCourse StudentsCourse { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.StudentsCourses == null)
            {
                return NotFound();
            }

            var studentscourse =  await _context.StudentsCourses.FirstOrDefaultAsync(m => m.StudentCourseId == id);
            if (studentscourse == null)
            {
                return NotFound();
            }
            StudentsCourse = studentscourse;
           ViewData["ClassId"] = new SelectList(_context.Classes, "ClassId", "ClassCode");
           ViewData["CourseId"] = new SelectList(_context.Courses, "CourseId", "CourseName");
           ViewData["LecturerId"] = new SelectList(_context.Lecturers, "LecturerId", "LecturerName");
           ViewData["SemesterId"] = new SelectList(_context.Semesters, "SemesterId", "SemesterCode");
           ViewData["StudentId"] = new SelectList(_context.Students, "StudentId", "StudentCode");
            return Page();
        }

        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see https://aka.ms/RazorPagesCRUD.
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.Attach(StudentsCourse).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
                await _signalRServices.Clients.All.SendAsync("ReceiveStudentCourse");
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!StudentsCourseExists(StudentsCourse.StudentCourseId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return RedirectToPage("./Index");
        }

        private bool StudentsCourseExists(int id)
        {
          return (_context.StudentsCourses?.Any(e => e.StudentCourseId == id)).GetValueOrDefault();
        }
    }
}
