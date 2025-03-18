﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.StudentClassesManage
{
    [Authorize(Roles = "ADMIN")]
    public class IndexModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        public IndexModel(ScoreManagement.Models.Project_PRN222Context context)
        {
            _context = context;
        }

        public IList<StudentClass> StudentClass { get;set; } = default!;

        public async Task OnGetAsync()
        {
            if (_context.StudentClasses != null)
            {
                StudentClass = await _context.StudentClasses
                .Include(s => s.Class)
                .Include(s => s.Student).ToListAsync();
            }
        }
    }
}
