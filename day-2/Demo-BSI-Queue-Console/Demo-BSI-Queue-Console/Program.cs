using System;
using System.Collections;
using System.Collections.Generic;

namespace Demo_BSI_Queue_Console
{
	class Program
	{
		static void Main(string[] args)
		{
			Queue<string> queue = new Queue<string>();
			queue.Enqueue("Hello");
			queue.Enqueue("World");

			Console.WriteLine(queue.Dequeue());
			Console.WriteLine(queue.Dequeue());

			Console.Read();

		}
	}
}
