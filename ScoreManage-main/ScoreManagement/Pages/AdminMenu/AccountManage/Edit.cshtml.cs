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
using ScoreManagement.Services;

namespace ScoreManagement.Pages.AdminMenu.AccountManage
{
    [Authorize(Roles = "ADMIN")]
    public class EditModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        private readonly IHubContext<ServiceHub> _signalRServices;
        public EditModel(ScoreManagement.Models.Project_PRN222Context context, IHubContext<ServiceHub> signalRServices)
        {
            _context = context;
            this._signalRServices = signalRServices;
        }

        [BindProperty]
        public Account Account { get; set; } = default!;
        public List<SelectListItem> RoleOptions { get; set; } = new List<SelectListItem>
        {
        new SelectListItem { Value = "LECTURER", Text = "LECTURER" },
        new SelectListItem { Value = "STUDENT", Text = "STUDENT" }
        };
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
            Account = account;

            // Đảm bảo `Role` hiện tại của tài khoản được hiển thị dưới dạng tùy chọn đã chọn
            var selectedRole = RoleOptions.FirstOrDefault(x => x.Value == Account.Role);
            if (selectedRole != null)
            {
                selectedRole.Selected = true;
            }

            return Page();
        }
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see https://aka.ms/RazorPagesCRUD.
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }
            var confirmPassword = Request.Form["confirmPasswordField"];

            // Kiểm tra nếu mật khẩu và nhập lại mật khẩu không giống nhau
            if (Account.PasswordHash != confirmPassword)
            {
                ViewData["PasswordMismatchError"] = "No password match.";
                return Page(); // Trả lại trang với thông báo lỗi
            }

            // Lấy tài khoản từ database
            var accountToUpdate = await _context.Accounts.FirstOrDefaultAsync(m => m.AccountId == Account.AccountId);
            if (accountToUpdate == null)
            {
                return NotFound();
            }
            accountToUpdate.Username = Account.Username;
            accountToUpdate.PasswordHash = RSAEncryption.Encrypt(Account.PasswordHash);

            // DEBUG: Kiểm tra mật khẩu trước khi lưu
            Console.WriteLine($"[DEBUG] Password sau khi mã hóa: {accountToUpdate.PasswordHash}");
            accountToUpdate.Role = Account.Role;
            try
            {
                await _context.SaveChangesAsync();
                await _signalRServices.Clients.All.SendAsync("ReceiveAccount");
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AccountExists(Account.AccountId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return RedirectToPage("./Index");
        }

        private bool AccountExists(int id)
        {
            return (_context.Accounts?.Any(e => e.AccountId == id)).GetValueOrDefault();
        }
    }
}
