using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BSI_Demo_Benchmark
{
	[MemoryDiagnoser][RankColumn]
	public class Program
	{
		private readonly List<Person> people = new List<Person>();
		private readonly int listSize = 1000;
		private readonly string find = "Person1000";
		private static readonly NameParser parser = new NameParser();
		private readonly string fullName = "Emanuel Dina Prasetyawan";

		public Program()
		{
			for (int i = 1; i <= listSize; i++)
			{
				people.Add(new Person()
				{
					Id = i.ToString(),
					Name = $"Person{i}"
				});
			}
		}

		[Benchmark]
		public Person ClassicFor()
		{
			for (int i = 1; i <= listSize; i++)
			{
				if (people[i].Name == find)
				{
					return people[i];
				}
			}

			return null;
		}

		[Benchmark]
		public Person ForEach()
		{
			foreach (var person in people)
			{
				if (person.Name == find)
				{
					return person;
				}
			}

			return null;
		}

		[Benchmark]
		public Person Linq() => people.FirstOrDefault(p => p.Name == find);

		[Benchmark]
		public string ConcatUsingStringBuilder()
		{
			var sb = new StringBuilder();
			for (int i = 0; i <= 100; i++)
			{
				sb.AppendLine(i.ToString());
			}
			return sb.ToString();
		}

		[Benchmark]
		public string ConcatStringUsingList()
		{
			var list = new List<string>(100);
			for (int i = 0; i <= 100; i++)
			{
				list.Add(i.ToString());
			}
			return list.ToString();
		}


		[Benchmark]
		public void GetLastName()
		{
			parser.GetLastName(fullName);
		}

		[Benchmark]
		public void GetLastNameSubstring()
		{
			parser.GetLastNameWithSubstring(fullName);
		}

		[Benchmark]
		public void GetLastNameSpan()
		{
			parser.GetLastNameWithSpan(fullName);
		}

		
		static void Main(string[] args)
		{
			//Console.WriteLine("Hello World!");
			BenchmarkRunner.Run<Program>();
		}
		
	}

	public class NameParser
	{
		public string GetLastName(string fullName)
		{
			var name = fullName.Split(" ");
			var lastName = name.LastOrDefault();
			return lastName;
		}

		public string GetLastNameWithSubstring(string fullName)
		{
			var nameIndex = fullName.LastIndexOf(" ");
			return fullName.Substring(nameIndex + 1);
		}

		public ReadOnlySpan<char> GetLastNameWithSpan(ReadOnlySpan<char> fullName)
		{
			var nameIndex = fullName.LastIndexOf(" ");
			return fullName.Slice(nameIndex + 1);
		}
	}

	public class Person
	{
		public string Id { get; set; }
		public string Name { get; set; }
	}
}
