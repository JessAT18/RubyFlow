namespace ApiProductor.Controllers
{
    using ApiProductor.Models;
    using Azure.Messaging.ServiceBus;
    using Microsoft.AspNetCore.Mvc;
    using Newtonsoft.Json;
    using System;
    using System.Threading.Tasks;

    [Route("api/[controller]")]
    [ApiController]
    public class DataController : ControllerBase
    {
        [HttpPost]
        public async Task<bool> EnviarAsync([FromBody] Data data)
        {
            string connectionString = "Endpoint=sb://queuejess.servicebus.windows.net/;SharedAccessKeyName=Enviar;SharedAccessKey=f+vpkehAxR16QvfnSxZXy3g2Hif+dnNpX3CUtSrVd2g=;EntityPath=cola1";
            string queueName = "cola1";
            string mensaje = JsonConvert.SerializeObject(data);
            await using (ServiceBusClient client = new ServiceBusClient(connectionString))
            {
                // create a sender for the queue 
                ServiceBusSender sender = client.CreateSender(queueName);

                // create a message that we can send
                ServiceBusMessage message = new ServiceBusMessage(mensaje);

                // send the message
                await sender.SendMessageAsync(message);
                Console.WriteLine($"Sent a single message to the queue: {queueName}");
            }
            return true;
        }
    }
}