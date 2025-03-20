using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.ClassCoursesManage
{
    [Authorize(Roles = "ADMIN")]
    public class CreateModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        public CreateModel(ScoreManagement.Models.Project_PRN222Context context)
        {
            _context = context;
        }

        public IActionResult OnGet()
        {
            ViewData["ClassCode"] = new SelectList(_context.Classes, "ClassId", "ClassCode");
            ViewData["LecturerName"] = new SelectList(_context.Lecturers, "LecturerId", "LecturerName");
            ViewData["CourseId"] = new SelectList(_context.Courses, "CourseId", "CourseName");
            return Page();
        }

        [BindProperty]
        public ClassCourse ClassCourse { get; set; } = default!;


        // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid || _context.ClassCourses == null || ClassCourse == null)
            {
                SetViewData(); // Gọi hàm thiết lập lại ViewData
                return Page();
            }

            bool isExist = await _context.ClassCourses
                .AnyAsync(cc => cc.ClassId == ClassCourse.ClassId && cc.CourseId == ClassCourse.CourseId);

            if (isExist)
            {
                ModelState.AddModelError(string.Empty, "Lớp này đã tồn tại môn này!");
                SetViewData(); // Thiết lập lại ViewData để dropdown không bị mất
                return Page();
            }

            _context.ClassCourses.Add(ClassCourse);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }

        // Hàm thiết lập lại danh sách dropdown
        private void SetViewData()
        {
            ViewData["ClassCode"] = new SelectList(_context.Classes, "ClassId", "ClassCode");
            ViewData["LecturerName"] = new SelectList(_context.Lecturers, "LecturerId", "LecturerName");
            ViewData["CourseId"] = new SelectList(_context.Courses, "CourseId", "CourseName");
        }

        public async Task<JsonResult> OnGetClassCode(int classId)
        {
            var classCode = await _context.Classes
                .Where(c => c.ClassId == classId)
                .Select(c => c.ClassCode)
                .FirstOrDefaultAsync();

            return new JsonResult(classCode);
        }
        public async Task<JsonResult> OnGetLecturerName(int lecturerId)
        {
            var classCode = await _context.Lecturers
                .Where(c => c.LecturerId == lecturerId)
                .Select(c => c.LecturerName)
                .FirstOrDefaultAsync();

            return new JsonResult(classCode);
        }
    }
}
