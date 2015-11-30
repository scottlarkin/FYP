using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RoutineManagement.Models
{
    public class Field
    {
        public string Name { get; set; }
        public bool Editable { get; set; }
        public int TypeID { get; set; }
    };
}