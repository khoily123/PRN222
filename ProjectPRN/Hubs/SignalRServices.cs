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

        public async Task SendComputers()
        {
            await Clients.All.SendAsync("ReceiveComputer");
        }

        public async Task SendComputerTypes()
        {
            await Clients.All.SendAsync("ReceiveComputerType");
        }
    }
}
