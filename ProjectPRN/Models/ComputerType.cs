using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectPRN.Models;

public partial class ComputerType
{
    public int CtId { get; set; }

    public string CtName { get; set; } = null!;

    [Column(TypeName = "decimal(18,2)")]
    [DisplayFormat(DataFormatString = "{0:0.00}", ApplyFormatInEditMode = true)]
    public decimal Price { get; set; }


    public virtual ICollection<Computer> Computers { get; set; } = new List<Computer>();
}
