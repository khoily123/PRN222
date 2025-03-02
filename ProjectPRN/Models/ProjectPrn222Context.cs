using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace ProjectPRN.Models;

public partial class ProjectPrn222Context : DbContext
{
    public ProjectPrn222Context()
    {
    }

    public ProjectPrn222Context(DbContextOptions<ProjectPrn222Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Account> Accounts { get; set; }

    public virtual DbSet<Computer> Computers { get; set; }

    public virtual DbSet<ComputerSession> ComputerSessions { get; set; }

    public virtual DbSet<ComputerType> ComputerTypes { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ConnectionStrings:DefaultConnection");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Account>(entity =>
        {
            entity.HasKey(e => e.AId).HasName("PK__Account__566AFA9A588AC4BC");

            entity.ToTable("Account");

            entity.Property(e => e.AId)
                .ValueGeneratedNever()
                .HasColumnName("a_id");
            entity.Property(e => e.Balance)
                .HasColumnType("money")
                .HasColumnName("balance");
            entity.Property(e => e.Password)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("password");
            entity.Property(e => e.Type).HasColumnName("type");
            entity.Property(e => e.Username)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("username");
        });

        modelBuilder.Entity<Computer>(entity =>
        {
            entity.HasKey(e => e.PcId).HasName("PK__Computer__1D3A69C0D1381567");

            entity.ToTable("Computer");

            entity.Property(e => e.PcId)
                .ValueGeneratedNever()
                .HasColumnName("pc_id");
            entity.Property(e => e.PcName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("pc_name");
            entity.Property(e => e.PcType).HasColumnName("pc_type");

            entity.HasOne(d => d.PcTypeNavigation).WithMany(p => p.Computers)
                .HasForeignKey(d => d.PcType)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Computer__pc_typ__3B75D760");
        });

        modelBuilder.Entity<ComputerSession>(entity =>
        {
            entity.HasKey(e => e.CsId).HasName("PK__Computer__138C55F4D7E3A2BD");

            entity.ToTable("Computer_Session");

            entity.Property(e => e.CsId)
                .ValueGeneratedNever()
                .HasColumnName("cs_id");
            entity.Property(e => e.AId).HasColumnName("a_id");
            entity.Property(e => e.PcId).HasColumnName("pc_id");
            entity.Property(e => e.Status)
                .HasMaxLength(1)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("status");
            entity.Property(e => e.TimeEnd)
                .HasColumnType("datetime")
                .HasColumnName("time_end");
            entity.Property(e => e.TimeStart)
                .HasColumnType("datetime")
                .HasColumnName("time_start");

            entity.HasOne(d => d.AIdNavigation).WithMany(p => p.ComputerSessions)
                .HasForeignKey(d => d.AId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Computer_S__a_id__3F466844");

            entity.HasOne(d => d.Pc).WithMany(p => p.ComputerSessions)
                .HasForeignKey(d => d.PcId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Computer___pc_id__3E52440B");
        });

        modelBuilder.Entity<ComputerType>(entity =>
        {
            entity.HasKey(e => e.CtId).HasName("PK__Computer__33D47D09794F7514");

            entity.ToTable("Computer_Type");

            entity.Property(e => e.CtId)
                .ValueGeneratedNever()
                .HasColumnName("ct_id");
            entity.Property(e => e.CtName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("ct_name");
            entity.Property(e => e.Price)
                .HasColumnType("money")
                .HasColumnName("price");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__Orders__46596229F784BF1A");

            entity.Property(e => e.OrderId)
                .ValueGeneratedNever()
                .HasColumnName("order_id");
            entity.Property(e => e.AId).HasColumnName("a_id");
            entity.Property(e => e.OrderDate).HasColumnName("order_date");
            entity.Property(e => e.Status).HasColumnName("status");
            entity.Property(e => e.TotalAmount)
                .HasColumnType("money")
                .HasColumnName("totalAmount");

            entity.HasOne(d => d.AIdNavigation).WithMany(p => p.Orders)
                .HasForeignKey(d => d.AId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Orders__a_id__440B1D61");
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => e.OdId).HasName("PK__OrderDet__FB4B2EFEE1E11463");

            entity.ToTable("OrderDetail");

            entity.Property(e => e.OdId)
                .ValueGeneratedNever()
                .HasColumnName("od_id");
            entity.Property(e => e.OrderId).HasColumnName("order_id");
            entity.Property(e => e.ProductId).HasColumnName("product_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.UnitPrice)
                .HasColumnType("money")
                .HasColumnName("unitPrice");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__OrderDeta__order__46E78A0C");

            entity.HasOne(d => d.Product).WithMany(p => p.OrderDetails)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__OrderDeta__produ__47DBAE45");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.ProductId).HasName("PK__Product__47027DF595C1D0EE");

            entity.ToTable("Product");

            entity.Property(e => e.ProductId)
                .ValueGeneratedNever()
                .HasColumnName("product_id");
            entity.Property(e => e.Description)
                .HasColumnType("text")
                .HasColumnName("description");
            entity.Property(e => e.Image)
                .HasMaxLength(255)
                .IsUnicode(false)
                .HasColumnName("image");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.Price)
                .HasColumnType("money")
                .HasColumnName("price");
            entity.Property(e => e.Type)
                .HasMaxLength(1)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("type");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
