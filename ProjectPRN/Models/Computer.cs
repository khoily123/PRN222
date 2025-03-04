using Microsoft.AspNetCore.Mvc.ModelBinding;
using System;
using System.Collections.Generic;

namespace ProjectPRN.Models;

public partial class Computer
{
    public int PcId { get; set; }

    public string PcName { get; set; } = null!;

    public int PcType { get; set; }

    public virtual ICollection<ComputerSession> ComputerSessions { get; set; } = new List<ComputerSession>();

    [BindNever]
    public virtual ComputerType? PcTypeNavigation { get; set; }
}
