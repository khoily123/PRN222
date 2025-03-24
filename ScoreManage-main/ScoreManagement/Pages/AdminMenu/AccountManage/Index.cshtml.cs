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

namespace ScoreManagement.Pages.AdminMenu.AccountManage
{
    [Authorize(Roles = "ADMIN")]
    public class IndexModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        private readonly IHubContext<ServiceHub> _signalRServices;

        public IndexModel(ScoreManagement.Models.Project_PRN222Context context, IHubContext<ServiceHub> signalRServices)
        {
            _context = context;
            _signalRServices = signalRServices;
        }

        public IList<Account> Account { get; set; } = default!;

        public async Task OnGetAsync()
        {
            if (_context.Accounts != null)
            {
                Account = await _context.Accounts
                    .AsNoTracking()
                    .OrderByDescending(m => m.AccountId)
                    .ToListAsync();
            }
        }
    }
}
