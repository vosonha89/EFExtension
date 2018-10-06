using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFExtension.Core
{
    /// <summary>
    /// Simple sql parameter for easier to use
    /// </summary>
    public class SimpleSqlParam
    {
        public string Name { get; set; }
        public object Value { get; set; }
    }
}
