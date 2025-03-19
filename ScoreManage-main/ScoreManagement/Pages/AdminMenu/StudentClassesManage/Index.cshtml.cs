using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Models;

namespace ScoreManagement.Pages.AdminMenu.StudentClassesManage
{
    [Authorize(Roles = "ADMIN")]
    public class IndexModel : PageModel
    {
        private readonly ScoreManagement.Models.Project_PRN222Context _context;

        public IndexModel(ScoreManagement.Models.Project_PRN222Context context)
        {
            _context = context;
        }
        public IList<Class> Classes { get; set; } = default!;
        public IList<StudentClass> StudentClass { get;set; } = default!;

        [BindProperty(SupportsGet = true)]
        public int? SelectedClassId { get; set; }
        public IList<Student> Students { get; set; } = new List<Student>();

        [BindProperty]
        public int SelectedStudentId { get; set; }
        public async Task OnGetAsync()
        {


            if (_context.StudentClasses != null)
            {
                Classes = await _context.Classes.ToListAsync();


                if (SelectedClassId.HasValue)
                {
                    StudentClass = await _context.StudentClasses
                        .Where(sc => sc.ClassId == SelectedClassId.Value)
                        .Include(sc => sc.Student)
                        .Include(sc => sc.Class)
                        .ToListAsync();

                    Students = await _context.Students
                    .Where(s => !_context.StudentClasses.Any(sc => sc.StudentId == s.StudentId && sc.ClassId == SelectedClassId.Value))
                    .ToListAsync();
                }

            }
        }

        public async Task<IActionResult> OnPostAddStudentAsync()
        {
            if (SelectedClassId.HasValue && SelectedStudentId > 0)
            {
                var newStudentClass = new StudentClass
                {
                    ClassId = SelectedClassId.Value,
                    StudentId = SelectedStudentId
                };

                _context.StudentClasses.Add(newStudentClass);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index", new { SelectedClassId });
        }
    }
}
