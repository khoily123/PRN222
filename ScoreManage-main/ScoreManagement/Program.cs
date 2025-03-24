using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.EntityFrameworkCore;
using ScoreManagement.Hubs;
using ScoreManagement.Models;


var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
builder.Services.AddRazorPages();

// Cấu hình DbContext cho kết nối cơ sở dữ liệu
            builder.Services.AddSignalR();
builder.Services.AddSingleton<ServiceHub>();

builder.Services.AddLogging();
builder.Services.AddDbContext<Project_PRN222Context>(options =>
       options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/AccountLogin/Login"; // Đường dẫn đến trang đăng nhập
        options.LogoutPath = "/AccountLogin/Logout";
        options.AccessDeniedPath = "/AccountLogin/PageNotFound404"; // Trang khi truy cập bị từ chối
    });
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        builder => builder.AllowAnyOrigin()
                          .AllowAnyMethod()
                          .AllowAnyHeader());
});
var app = builder.Build();

app.UseCors("AllowAll");


            // Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
   app.UseExceptionHandler("/Error");
   // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
   app.UseHsts();
            }

   app.UseHttpsRedirection();
   app.UseStaticFiles();

   app.UseRouting();

   // Thêm xác thực và phân quyền vào pipeline
   app.UseAuthentication();
   app.UseAuthorization();

   app.MapRazorPages();

      // Định tuyến trang chính đến trang đăng nhập
   app.MapGet("/", context =>
            {
       context.Response.Redirect("/AccountLogin/Login");
       return Task.CompletedTask;
      });
   app.MapHub<ServiceHub>("/signalr"); // Thêm Hub vào
   app.Run();

