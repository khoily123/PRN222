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

namespace ScoreManagement.Pages.AdminMenu.AccountManage
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
        public Account Account { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Accounts == null)
            {
                return NotFound();
            }

            var account = await _context.Accounts.FirstOrDefaultAsync(m => m.AccountId == id);

            if (account == null)
            {
                return NotFound();
            }
            else
            {
                Account = account;
            }
            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null || _context.Accounts == null)
            {
                return NotFound();
            }
            var account = await _context.Accounts.FindAsync(id);

            if (account != null)
            {
                Account = account;

                try
                {
                    _context.Accounts.Remove(Account);
                    await _context.SaveChangesAsync();
                    await _signalRServices.Clients.All.SendAsync("ReceiveAccount");
                }
                catch (DbUpdateException)
                {
                    ModelState.AddModelError(string.Empty, "Không thể xóa tài khoản này do có dữ liệu liên quan trong bảng khác.");
                    return Page();
                }
                
            }

            return RedirectToPage("./Index");
        }
    }
}
