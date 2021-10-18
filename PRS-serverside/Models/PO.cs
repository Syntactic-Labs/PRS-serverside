using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PRS_serverside.Models
{
    public class PO : OrderLine
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string PrtNumber { get; set; }
        public decimal FinTotal { get; set; }
    }
}
