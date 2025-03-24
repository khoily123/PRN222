using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.SignalR;
using ScoreManagement.Hubs;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.ClassesManage
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
        ViewData["SemesterId"] = new SelectList(_context.Semesters, "SemesterId", "SemesterCode");
            return Page();
        }

        [BindProperty]
        public Class Class { get; set; } = default!;
        

        // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
        public async Task<IActionResult> OnPostAsync()
        {
          if (!ModelState.IsValid || _context.Classes == null || Class == null)
            {
                return Page();
            }

            _context.Classes.Add(Class);
            await _context.SaveChangesAsync();
            await _signalRServices.Clients.All.SendAsync("ReceiveClass");
            return RedirectToPage("./Index");
        }
    }
}
