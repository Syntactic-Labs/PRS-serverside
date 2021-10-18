using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PRS_serverside.Models
{
    public class OrderLine
    {
        public int LineId { get; set; }
        public string PartName { get; set; }
        public int Quantity { get; set; }
        public decimal PricePer { get; set; }
        public decimal Total { get; set; }
    }
}
