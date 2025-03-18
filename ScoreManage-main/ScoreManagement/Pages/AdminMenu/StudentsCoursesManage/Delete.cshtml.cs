﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.StudentsCoursesManage
{
    [Authorize(Roles = "ADMIN")]
    public class DeleteModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        public DeleteModel(ScoreManagement.Models.Project_PRN222Context context)
        {
            _context = context;
        }

        [BindProperty]
      public StudentsCourse StudentsCourse { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.StudentsCourses == null)
            {
                return NotFound();
            }

            var studentscourse = await _context.StudentsCourses
                .Include(c => c.Class)
                .Include(c => c.Student)
                .Include(c => c.Course)
                .Include(c => c.Lecturer)
                .Include(c => c.Semester)
                .FirstOrDefaultAsync(m => m.StudentCourseId == id);

            if (studentscourse == null)
            {
                return NotFound();
            }
            else 
            {
                StudentsCourse = studentscourse;
            }
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null || _context.StudentsCourses == null)
            {
                return NotFound();
            }

            var studentscourse = await _context.StudentsCourses.FindAsync(id);

            if (studentscourse != null)
            {
                StudentsCourse = studentscourse;

                try
                {
                    _context.StudentsCourses.Remove(StudentsCourse);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateException)
                {
                    ModelState.AddModelError(string.Empty, "Không thể xóa do có dữ liệu liên quan trong bảng grade.");
                    return Page();
                }
                
            }

            return RedirectToPage("./Index");
        }
    }
}
