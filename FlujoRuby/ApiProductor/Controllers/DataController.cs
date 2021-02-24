using ApiProductor.Models;
using Azure.Messaging.ServiceBus;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ApiProductor.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DataController : ControllerBase
    {
        [HttpPost]
        public async Task<bool> EnviarAsync([FromBody] Data data)
        {
            string connectionString = "Endpoint=sb://queuejess.servicebus.windows.net/;SharedAccessKeyName=Enviar;SharedAccessKey=f+vpkehAxR16QvfnSxZXy3g2Hif+dnNpX3CUtSrVd2g=;EntityPath=cola1";
            string queueName = "queuejess/cola1";
            await using (ServiceBusClient client = new ServiceBusClient(connectionString))
            {
                // create a sender for the queue 
                ServiceBusSender sender = client.CreateSender(queueName);

                // create a message that we can send
                ServiceBusMessage message = new ServiceBusMessage("Hello world!");

                // send the message
                await sender.SendMessageAsync(message);
                Console.WriteLine($"Sent a single message to the queue: {queueName}");
            }
            return true;
        }
    }
}
