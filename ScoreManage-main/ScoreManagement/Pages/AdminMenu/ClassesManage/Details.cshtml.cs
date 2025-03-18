﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.ClassesManage
{
    [Authorize(Roles = "ADMIN")]
    public class DetailsModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        public DetailsModel(ScoreManagement.Models.Project_PRN222Context context)
        {
            _context = context;
        }

        public Class Class { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Classes == null)
            {
                return NotFound();
            }

            var selectedClass = await _context.Classes
                .Include(s => s.Semester)
                .FirstOrDefaultAsync(m => m.ClassId == id);
            if (selectedClass == null)
            {
                return NotFound();
            }
            else
            {
                Class = selectedClass;
            }
            return Page();
        }
    }
}
