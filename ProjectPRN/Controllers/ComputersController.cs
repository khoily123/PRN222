using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ProjectPRN.Models;

namespace ProjectPRN.Controllers
{
    public class ComputersController : Controller
    {
        private readonly ProjectPrn222Context _context;

        public ComputersController(ProjectPrn222Context context)
        {
            _context = context;
        }

        // GET: Computers
        public async Task<IActionResult> Index()
        {
            var projectPrn222Context = _context.Computers.Include(c => c.PcTypeNavigation);
            return View(await projectPrn222Context.ToListAsync());
        }

        // GET: Computers/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var computer = await _context.Computers
                .Include(c => c.PcTypeNavigation)
                .FirstOrDefaultAsync(m => m.PcId == id);
            if (computer == null)
            {
                return NotFound();
            }

            return View(computer);
        }

        // GET: Computers/Create
        public IActionResult Create()
        {
            ViewData["PcType"] = new SelectList(_context.ComputerTypes, "CtId", "CtName");
            return View();
        }

        // POST: Computers/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("PcId,PcName,PcType")] Computer computer)
        {
            ModelState.Remove("PcTypeNavigation"); // Xóa kiểm tra ModelState nếu lỗi vẫn còn

            // Kiểm tra xem PcName đã tồn tại hay chưa
            bool isDuplicate = await _context.Computers.AnyAsync(c => c.PcName == computer.PcName);
            if (isDuplicate)
            {
                ModelState.AddModelError("PcName", "Tên máy tính đã tồn tại. Vui lòng chọn tên khác.");
            }

            if (ModelState.IsValid)
            {
                // Gán lại PcTypeNavigation từ database
                computer.PcTypeNavigation = await _context.ComputerTypes.FirstOrDefaultAsync(ct => ct.CtId == computer.PcType);

                _context.Add(computer);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Tạo thành công!";
                return RedirectToAction(nameof(Index));
            }

            ViewData["PcType"] = new SelectList(_context.ComputerTypes, "CtId", "CtName", computer.PcType);
            return View(computer);
        }



        // GET: Computers/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var computer = await _context.Computers.FindAsync(id);
            if (computer == null)
            {
                return NotFound();
            }
            ViewData["PcType"] = new SelectList(_context.ComputerTypes, "CtId", "CtName", computer.PcType);
            return View(computer);
        }

        // POST: Computers/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("PcId,PcName,PcType")] Computer computer)
        {
            Console.WriteLine(computer.PcId);
            Console.WriteLine(computer.PcName);
            Console.WriteLine(computer.PcType);

            ModelState.Remove("PcTypeNavigation"); // Xóa kiểm tra ModelState nếu lỗi vẫn còn

            if (!ModelState.IsValid)
            {
                foreach (var modelError in ModelState.Values.SelectMany(v => v.Errors))
                {
                    Console.WriteLine($"Lỗi ModelState: {modelError.ErrorMessage}");
                }
                ViewData["PcType"] = new SelectList(_context.ComputerTypes, "CtId", "CtName", computer.PcType);
                return View(computer);
            }

            var existingComputer = await _context.Computers.AsNoTracking().FirstOrDefaultAsync(c => c.PcId == id);
            if (existingComputer == null)
            {
                return NotFound();
            }

            // Gán lại PcTypeNavigation trước khi lưu
            computer.PcTypeNavigation = await _context.ComputerTypes.FirstOrDefaultAsync(ct => ct.CtId == computer.PcType);

            computer.PcId = id;
            _context.Entry(computer).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Chỉnh sửa thành công!";
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ComputerExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return RedirectToAction(nameof(Index));
        }

        // GET: Computers/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var computer = await _context.Computers
                .Include(c => c.PcTypeNavigation)
                .FirstOrDefaultAsync(m => m.PcId == id);
            if (computer == null)
            {
                return NotFound();
            }

            return View(computer);
        }

        // POST: Computers/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var computer = await _context.Computers.FindAsync(id);
            if (computer != null)
            {
                _context.Computers.Remove(computer);
            }

            await _context.SaveChangesAsync();
            TempData["SuccessMessage"] = "Xóa thành công!";
            return RedirectToAction(nameof(Index));
        }

        private bool ComputerExists(int id)
        {
            return _context.Computers.Any(e => e.PcId == id);
        }
    }
}
