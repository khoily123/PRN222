﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.ClassCoursesManage
{
    [Authorize(Roles = "ADMIN")]
    public class DetailsModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        public DetailsModel(ScoreManagement.Models.Project_PRN222Context context)
        {
            _context = context;
        }

      public ClassCourse ClassCourse { get; set; } = default!; 

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.ClassCourses == null)
            {
                return NotFound();
            }

            var classcourse = await _context.ClassCourses
                .Include(x => x.Course)
                .Include(x => x.Class)
                .Include(x => x.Lecturer)
                .FirstOrDefaultAsync(m => m.ClassCourseId == id);
            if (classcourse == null)
            {
                return NotFound();
            }
            else 
            {
                ClassCourse = classcourse;
            }
            return Page();
        }
    }
}
