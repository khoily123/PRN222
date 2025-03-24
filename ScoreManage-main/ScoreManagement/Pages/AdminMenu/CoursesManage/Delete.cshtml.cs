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

namespace ScoreManagement.Pages.AdminMenu.CoursesManage
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
      public Course Course { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Courses == null)
            {
                return NotFound();
            }

            var course = await _context.Courses.FirstOrDefaultAsync(m => m.CourseId == id);

            if (course == null)
            {
                return NotFound();
            }
            else 
            {
                Course = course;
            }
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null || _context.Courses == null)
            {
                return NotFound();
            }
            var course = await _context.Courses.FindAsync(id);

            if (course != null)
            {
                Course = course;

                try
                {
                    _context.Courses.Remove(Course);
                    await _context.SaveChangesAsync();
                    await _signalRServices.Clients.All.SendAsync("ReceiveCourse");
                }
                catch (DbUpdateException)
                {
                    ModelState.AddModelError(string.Empty, "Không thể xóa môn học này do có dữ liệu liên quan trong bảng khác.");
                    return Page();
                }
                
            }

            return RedirectToPage("./Index");
        }
    }
}
