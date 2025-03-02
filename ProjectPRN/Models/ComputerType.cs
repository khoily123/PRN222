using System;
using System.Collections.Generic;

namespace ProjectPRN.Models;

public partial class ComputerType
{
    public int CtId { get; set; }

    public string CtName { get; set; } = null!;

    public decimal Price { get; set; }

    public virtual ICollection<Computer> Computers { get; set; } = new List<Computer>();
}
