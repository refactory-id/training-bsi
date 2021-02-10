using Hangfire;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BSI_Demo_Queue_API.Controllers
{
	[ApiController]
	[Route("api/[controller]")]
	public class HangfireController : ControllerBase
	{
		//Fire and forget
		[HttpPost]
		[Route("[action]")]

		public IActionResult fireAndForget()
		{
			var jobID = BackgroundJob.Enqueue(() => sendEmail("Welcome to our apps"));
			return Ok($"Job ID : {jobID}. Welcome email sent to the user");
		}

		//delayed Job
		[HttpPost]
		[Route("[action]")]

		public IActionResult delayedJob()
		{
			var interval = 15;
			var jobID = BackgroundJob.Schedule(() => sendEmail("Welcome to our apps"), TimeSpan.FromSeconds(interval));
			return Ok($"Job ID : {jobID}. Welcome email will be sent in {interval} seconds.");
		}

		//recurring job
		[HttpPost]
		[Route("[action]")]
		[Obsolete]
		public IActionResult recurringJob()
		{
			var interval = 1;
			RecurringJob.AddOrUpdate("Generated Report", () => GeneratedReport(), Cron.MinuteInterval(interval));
			//var jobID = BackgroundJob.Schedule(() => sendEmail("Welcome to our apps"), TimeSpan.FromSeconds(interval));
			return Ok("Generated report initated.");
		}

		//Continuation
		[HttpPost]
		[Route("[action]")]
		public IActionResult continuationJob()
		{
			var interval = 15;
			var parentJobID = BackgroundJob.Schedule(() => sendEmail("are you sure to change password?"), TimeSpan.FromSeconds(interval));

			BackgroundJob.ContinueJobWith(parentJobID, () => sendEmail("Success."));
			//var jobID = BackgroundJob.Schedule(() => sendEmail("Welcome to our apps"), TimeSpan.FromSeconds(interval));
			return Ok("Generated report initated.");
		}


		public void sendEmail(string text)
		{
			Console.WriteLine(text);
		}

		public void GeneratedReport()
		{
			Console.WriteLine("Report generated");
		}

	}
}
