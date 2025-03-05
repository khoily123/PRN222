using Microsoft.AspNetCore.SignalR;
using ProjectPRN.Models;

namespace ProjectPRN.Hubs
{
    public class SignalRServices : Hub
    {

        public async Task SendProducts()
        {
            await Clients.All.SendAsync("ReceiveProduct");
        }
    }
}
