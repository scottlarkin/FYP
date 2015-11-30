using System.Collections.Generic;


namespace RoutineManagement.Models
{

    public class ChecksheetModel
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public List<Record> Records { get; set; }
        public List<Field> Fields { get; set; }

        public ChecksheetModel()
        {
            Records = new List<Record>();
            Fields = new List<Field>();
        }
    };

}
