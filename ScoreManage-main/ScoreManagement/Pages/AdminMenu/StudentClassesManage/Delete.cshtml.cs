﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Hubs;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.StudentClassesManage
{
    [Authorize(Roles = "ADMIN")]
    public class DeleteModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        private readonly IHubContext<ServiceHub> _signalRServices;

        public DeleteModel(ScoreManagement.Models.Project_PRN222Context context, IHubContext<ServiceHub> signalRServices)
        {
            _context = context;
            _signalRServices = signalRServices;
        }

        [BindProperty]
      public StudentClass StudentClass { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.StudentClasses == null)
            {
                return NotFound();
            }

            var studentclass = await _context.StudentClasses
                .Include(s => s.Class)
                .Include(s => s.Student)
                .FirstOrDefaultAsync(m => m.StudentClassId == id);

            if (studentclass == null)
            {
                return NotFound();
            }
            else 
            {
                StudentClass = studentclass;
            }
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null || _context.StudentClasses == null)
            {
                return NotFound();
            }
            var studentclass = await _context.StudentClasses.FindAsync(id);

            if (studentclass != null)
            {
                StudentClass = studentclass;
                _context.StudentClasses.Remove(StudentClass);
                await _context.SaveChangesAsync();
                await _signalRServices.Clients.All.SendAsync("ReceiveStudentClass");
            }

            return RedirectToPage("./Index");
        }
    }
}
