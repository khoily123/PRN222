using System;
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

namespace ScoreManagement.Pages.AdminMenu.ClassCoursesManage
{
    [Authorize(Roles = "ADMIN")]
    public class DeleteModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        private readonly IHubContext<ServiceHub> _signalRServices;

        public DeleteModel(ScoreManagement.Models.Project_PRN222Context context,IHubContext<ServiceHub> signalRServices)
        {
            _context = context;
            _signalRServices = signalRServices;
        }

        [BindProperty]
      public ClassCourse ClassCourse { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.ClassCourses == null)
            {
                return NotFound();
            }

            var classcourse = await _context.ClassCourses.Include(x => x.Course)
                .Include(x => x.Class)
                .Include(x => x.Lecturer).FirstOrDefaultAsync(m => m.ClassCourseId == id);

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

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null || _context.ClassCourses == null)
            {
                return NotFound();
            }
            var classcourse = await _context.ClassCourses.FindAsync(id);

            if (classcourse != null)
            {
                ClassCourse = classcourse;
                _context.ClassCourses.Remove(ClassCourse);
                await _context.SaveChangesAsync();
                await _signalRServices.Clients.All.SendAsync("ReceiveClassCourse");
            }

            return RedirectToPage("./Index");
        }
    }
}
