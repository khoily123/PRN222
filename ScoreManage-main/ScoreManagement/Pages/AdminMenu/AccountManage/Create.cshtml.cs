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
            // Thiết lập danh sách vai trò
            ViewData["RoleOptions"] = new List<SelectListItem>
            {
                new SelectListItem { Value = "LECTURER", Text = "Lecturer" },
                new SelectListItem { Value = "STUDENT", Text = "Student" }
            };

            return Page();
        }

        [BindProperty]
        public Account Account { get; set; } = default!;

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                ViewData["RoleOptions"] = new List<SelectListItem>
        {
            new SelectListItem { Value = "LECTURER", Text = "Lecturer" },
            new SelectListItem { Value = "STUDENT", Text = "Student" }
        };
                return Page();
            }

            // Kiểm tra nếu Username đã tồn tại
            var existingAccount = await _context.Accounts
                .AnyAsync(a => a.Username == Account.Username);

            if (existingAccount)
            {
                ModelState.AddModelError("Account.Username", "Username đã tồn tại. Vui lòng chọn Username khác.");
                return Page();
            }

            // Kiểm tra nếu mật khẩu và mật khẩu xác nhận giống nhau
            var confirmPassword = Request.Form["confirmPasswordField"];
            if (Account.PasswordHash != confirmPassword)
            {
                ModelState.AddModelError(string.Empty, "Mật khẩu và Nhập lại mật khẩu không giống nhau.");
                return Page();
            }

            //Mã hoá mật khẩu
            Account.PasswordHash = RSAEncryption.Encrypt(Account.PasswordHash);
            // **DEBUG: Kiểm tra mật khẩu sau khi mã hóa**
            Console.WriteLine($"[DEBUG] Password sau khi mã hóa: {Account.PasswordHash}");
            // Thêm Account mới vào database
            _context.Accounts.Add(Account);
            await _context.SaveChangesAsync();
            await _signalRServices.Clients.All.SendAsync("ReceiveAccount");
            return RedirectToPage("./Index");
        }

    }
}
