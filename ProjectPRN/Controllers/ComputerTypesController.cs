using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using ProjectPRN.Hubs;
using ProjectPRN.Models;

namespace ProjectPRN.Controllers
{
    public class ComputerTypesController : Controller
    {
        private readonly ProjectPrn222Context _context;
        private readonly IHubContext<SignalRServices> _signalRServices;

        public ComputerTypesController(ProjectPrn222Context context, IHubContext<SignalRServices> _signalRServices)
        {
            _context = context;
            this._signalRServices = _signalRServices;
        }

        // GET: ComputerTypes
        public async Task<IActionResult> Index()
        {
            return View(await _context.ComputerTypes.ToListAsync());
        }

        // GET: ComputerTypes/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var computerType = await _context.ComputerTypes
                .FirstOrDefaultAsync(m => m.CtId == id);
            if (computerType == null)
            {
                return NotFound();
            }

            return View(computerType);
        }

        // GET: ComputerTypes/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: ComputerTypes/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("CtId,CtName,Price")] ComputerType computerType)
        {
            // Kiểm tra xem CtName đã tồn tại chưa
            bool isDuplicate = await _context.ComputerTypes.AnyAsync(ct => ct.CtName == computerType.CtName);
            if (isDuplicate)
            {
                ModelState.AddModelError("CtName", "Tên loại máy tính đã tồn tại. Vui lòng chọn tên khác.");
            }

            if (ModelState.IsValid)
            {
                _context.Add(computerType);
                await _context.SaveChangesAsync();
                await _signalRServices.Clients.All.SendAsync("ReceiveComputerType");
                TempData["SuccessMessage"] = "Tạo thành công!";
                return RedirectToAction(nameof(Index));
            }

            return View(computerType);
        }


        // GET: ComputerTypes/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var computerType = await _context.ComputerTypes.FindAsync(id);
            if (computerType == null)
            {
                return NotFound();
            }
            return View(computerType);
        }

        // POST: ComputerTypes/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("CtId,CtName,Price")] ComputerType computerType)
        {
            if (id != computerType.CtId)
            {
                return NotFound();
            }

            // Debug giá trị nhận được từ form
            Console.WriteLine($"Received Price: {computerType.Price}");

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(computerType);
                    await _context.SaveChangesAsync();
                    await _signalRServices.Clients.All.SendAsync("ReceiveComputerType");
                    TempData["SuccessMessage"] = "Chỉnh sửa thành công!";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ComputerTypeExists(computerType.CtId))
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
            return View(computerType);
        }



        // GET: ComputerTypes/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var computerType = await _context.ComputerTypes
                .FirstOrDefaultAsync(m => m.CtId == id);
            if (computerType == null)
            {
                return NotFound();
            }

            return View(computerType);
        }

        // POST: ComputerTypes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var computerType = await _context.ComputerTypes
                .Include(ct => ct.Computers) // Giả sử có quan hệ với Computers
                .FirstOrDefaultAsync(ct => ct.CtId == id);

            if (computerType == null)
            {
                return NotFound();
            }

            // Kiểm tra nếu có liên kết với Computer
            if (computerType.Computers != null && computerType.Computers.Any())
            {
                TempData["ErrorMessage"] = "Không thể xóa vì vẫn còn máy tính thuộc loại này!";
                return RedirectToAction(nameof(Index));
            }

            _context.ComputerTypes.Remove(computerType);
            await _context.SaveChangesAsync();
            await _signalRServices.Clients.All.SendAsync("ReceiveComputerType");
            TempData["SuccessMessage"] = "Xóa thành công!";
            return RedirectToAction(nameof(Index));
        }


        private bool ComputerTypeExists(int id)
        {
            return _context.ComputerTypes.Any(e => e.CtId == id);
        }
    }
}
