using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RoutineManagement.Models
{
    public class Record
    {
        public string Name { get; set; }
        public List<FieldValue> FieldValues { get; set; }

        public Record()
        {
            FieldValues = new List<FieldValue>();
        }
    };
}