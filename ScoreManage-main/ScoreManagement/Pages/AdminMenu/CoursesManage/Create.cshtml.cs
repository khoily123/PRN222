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

namespace ScoreManagement.Pages.AdminMenu.CoursesManage
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
            return Page();
        }

        [BindProperty]
        public Course Course { get; set; } = default!;
        

        // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
        public async Task<IActionResult> OnPostAsync()
        {
          if (!ModelState.IsValid || _context.Courses == null || Course == null)
            {
                return Page();
            }
            // Kiểm tra xem CourseCode đã tồn tại hay chưa
            bool courseExists = await _context.Courses.AnyAsync(c => c.CourseCode == Course.CourseCode);
            if (courseExists)
            {
                ModelState.AddModelError("Course.CourseCode", "This course code already exists.");
                return Page();
            }
            _context.Courses.Add(Course);
            await _context.SaveChangesAsync();
            await _signalRServices.Clients.All.SendAsync("ReceiveCourse");
            return RedirectToPage("./Index");
        }
    }
}
