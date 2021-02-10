using System;
using System.Collections.Generic;

#nullable disable

namespace Demo_BSI_Cache.Models
{
    public partial class BookAuthor
    {
        public int AuthorId { get; set; }
        public int BookId { get; set; }
        public byte? AuthorOrder { get; set; }
        public int? RoyalityPercentage { get; set; }

        public virtual Author Author { get; set; }
        public virtual Book Book { get; set; }
    }
}
