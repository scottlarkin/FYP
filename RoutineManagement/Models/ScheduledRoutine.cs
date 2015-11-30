using DataAccess;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace RoutineManagement.Models
{

    public class ScheduledRoutine
    {
        public ScheduledRoutine() { }

        public ScheduledRoutine(string sid, string rid, string a, string at, string au, string d, string co, string cb, string r, int? rate = null, string period = null, int? number = null)
        {
            ScheduleID = int.Parse(sid);
            RoutineID = int.Parse(rid);
            Area = a;
            AssignedTeam = at;
            AssignedUser = au;
            DueOn = d;
            CompletedOn = co;
            CompletedBy = cb;
            Routine = r;
            Rate = rate ?? 1;
            Period = period ?? "Days";
            Number = number ?? 1;
        }

        public void SaveScheduledRoutine()
        {
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("@Routine", SqlDbType.NVarChar) { Value = Routine.Replace("'", "''") });
                parameters.Add(new SqlParameter("@Team", SqlDbType.NVarChar) { Value = AssignedTeam.Replace("'", "''") });
                parameters.Add(new SqlParameter("@User", SqlDbType.NVarChar) { Value = AssignedUser.Replace("'", "''") });
                parameters.Add(new SqlParameter("@DateFor", SqlDbType.DateTime) { Value = DueOn.Replace("'", "''") });
                parameters.Add(new SqlParameter("@Rate", SqlDbType.Int) { Value = Rate });
                parameters.Add(new SqlParameter("@Period", SqlDbType.NVarChar) { Value = Period.Replace("'", "''") });
                parameters.Add(new SqlParameter("@Number", SqlDbType.Int) { Value = Number });

                database.ExecuteProcedure("dbo.ScheduleRoutine", parameters);
            }
        }

        public int ScheduleID { get; set; }
        public int RoutineID { get; set; }
        public string Area { get; set; }
        public string AssignedTeam { get; set; }
        public string AssignedUser { get; set; }
        public string DueOn { get; set; }
        public string CompletedOn { get; set; }
        public string CompletedBy { get; set; }
        public string Routine { get; set; }
        public int Rate { get; set; }
        public string Period { get; set; }
        public int Number { get; set; }
    };
}