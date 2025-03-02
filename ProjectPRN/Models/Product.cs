using System;
using System.Collections.Generic;

namespace ProjectPRN.Models;

public partial class Product
{
    public int ProductId { get; set; }

    public string Name { get; set; } = null!;

    public decimal Price { get; set; }

    public string Image { get; set; } = null!;

    public string? Description { get; set; }

    public string Type { get; set; } = null!;

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
