using System;
using System.Collections.Generic;

namespace ProjectPRN.Models;

public partial class Order
{
    public int OrderId { get; set; }

    public int AId { get; set; }

    public DateOnly OrderDate { get; set; }

    public decimal TotalAmount { get; set; }

    public int Status { get; set; }

    public virtual Account AIdNavigation { get; set; } = null!;

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
