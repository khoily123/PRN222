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

namespace ScoreManagement.Pages.StudentsManage
{
    [Authorize(Roles = "ADMIN")]
    public class EditModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        private readonly IHubContext<ServiceHub> _signalRServices;

        public EditModel(ScoreManagement.Models.Project_PRN222Context context, IHubContext<ServiceHub> signalRServices)
        {
            _context = context;
            _signalRServices = signalRServices;
        }

        [BindProperty]
        public Student Student { get; set; } = default!;

        public SelectList MajorList { get; set; } = default!;
        public SelectList AccountList { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null || _context.Students == null)
            {
                return NotFound();
            }

            var student = await _context.Students.FirstOrDefaultAsync(m => m.StudentId == id);
            if (student == null)
            {
                return NotFound();
            }

            Student = student;

            await PopulateSelectListsAsync(); // Gọi phương thức để tạo danh sách chọn

            return Page();
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                await PopulateSelectListsAsync(); // Tái lập danh sách chọn khi có lỗi
                return Page();
            }
            // Kiểm tra nếu StudentCode vượt quá 10 ký tự
            if (Student.StudentCode.Length > 10)
            {
                ModelState.AddModelError("Student.StudentCode", "Mã sinh viên không được vượt quá 10 ký tự.");
                return Page();
            }

            // Kiểm tra nếu StudentCode đã tồn tại với một Student khác
            var duplicateStudentCode = await _context.Students
                .AnyAsync(s => s.StudentCode == Student.StudentCode && s.StudentId != Student.StudentId);

            if (duplicateStudentCode)
            {
                ModelState.AddModelError("Student.StudentCode", "Mã sinh viên đã tồn tại. Vui lòng chọn mã khác.");
                await PopulateSelectListsAsync(); // Tái lập danh sách chọn khi có lỗi
                return Page();
            }

            // Cập nhật Student
            _context.Attach(Student).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            await _signalRServices.Clients.All.SendAsync("ReceiveStudent");
            return RedirectToPage("./Index");
        }

        private async Task PopulateSelectListsAsync()
        {
            AccountList = new SelectList(await _context.Accounts
                .Where(a => a.Role == "STUDENT" &&
                            (!_context.Lecturers.Any(l => l.AccountId == a.AccountId) &&
                             !_context.Students.Any(s => s.AccountId == a.AccountId) ||
                             a.AccountId == Student.AccountId))
                .Select(a => new
                {
                    Value = a.AccountId.ToString(),
                    Text = a.Username
                }).ToListAsync(), "Value", "Text");

            MajorList = new SelectList(await _context.Majors.ToListAsync(), "MajorId", "MajorName");
        }
    }

}
