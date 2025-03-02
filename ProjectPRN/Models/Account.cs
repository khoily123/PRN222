using System;
using System.Collections.Generic;

namespace ProjectPRN.Models;

public partial class Account
{
    public int AId { get; set; }

    public string Username { get; set; } = null!;

    public string Password { get; set; } = null!;

    public decimal? Balance { get; set; }

    public int Type { get; set; }

    public virtual ICollection<ComputerSession> ComputerSessions { get; set; } = new List<ComputerSession>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
