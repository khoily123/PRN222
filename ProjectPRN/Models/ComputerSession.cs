using System;
using System.Collections.Generic;

namespace ProjectPRN.Models;

public partial class ComputerSession
{
    public int CsId { get; set; }

    public int PcId { get; set; }

    public int AId { get; set; }

    public DateTime TimeStart { get; set; }

    public DateTime? TimeEnd { get; set; }

    public string? Status { get; set; }

    public virtual Account AIdNavigation { get; set; } = null!;

    public virtual Computer Pc { get; set; } = null!;
}
