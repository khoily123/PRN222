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

namespace ScoreManagement.Pages.AdminMenu.MajorManage
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
      public Major Major { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Majors == null)
            {
                return NotFound();
            }

            var major = await _context.Majors.FirstOrDefaultAsync(m => m.MajorId == id);

            if (major == null)
            {
                return NotFound();
            }
            else 
            {
                Major = major;
            }
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null || _context.Majors == null)
            {
                return NotFound();
            }
            var major = await _context.Majors.FindAsync(id);

            if (major != null)
            {
                Major = major;

                try
                {
                    _context.Majors.Remove(Major);
                    await _context.SaveChangesAsync();
                    await _signalRServices.Clients.All.SendAsync("ReceiveMajor");
                }
                catch (DbUpdateException)
                {
                    ModelState.AddModelError(string.Empty, "Không thể xóa ngành học này do có dữ liệu liên quan trong bảng sinh viên.");
                    return Page();
                }
                
            }

            return RedirectToPage("./Index");
        }
    }
}
