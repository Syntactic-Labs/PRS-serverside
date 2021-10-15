using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PRS_serverside.Models
{
    public class PO
    {

        public virtual Vendor Vendor { get; set; }
        public virtual IEnumerable<POLine> POLines { get; set; }
    }
}
