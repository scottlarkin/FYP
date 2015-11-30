using DataAccess;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace RoutineManagement.Models
{

    public class ScheduleModel
    {

        public List<ScheduledRoutine> ScheduledRoutines { get; set; }

        public ScheduleModel()
        {
            ScheduledRoutines = new List<ScheduledRoutine>();
        }

        public void LoadSchedule()
        {
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (DataTable result = database.GetDataTable("dbo.ScheduleGet", new List<SqlParameter>()))
                {

                    foreach (DataRow dr in result.Rows)
                    {

                        ScheduledRoutines.Add(new ScheduledRoutine(
                                dr["ScheduleID"].ToString(),
                                dr["RoutineID"].ToString(),
                                dr["Area"].ToString(),
                                dr["AssignedTeam"].ToString(),
                                dr["AssignedUser"].ToString(),
                                dr["DueOn"].ToString(),
                                dr["CompletedOn"].ToString(),
                                dr["CompletedBy"].ToString(),
                                dr["Routine"].ToString()
                            ));
                    }
                }
            }
        }



        public static List<string> GetAreas()
        {
            List<string> ret = new List<string>();

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (DataTable result = database.GetDataTable("dbo.AreaGet", new List<SqlParameter>()))
                {
                    foreach (DataRow dr in result.Rows)
                    {
                        ret.Add(dr["Name"].ToString());
                    }
                }
            }

            return ret;
        }


        public static List<string> GetTeamsByArea(string AreaName)
        {
            List<string> ret = new List<string>();

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {

                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("AreaName", SqlDbType.NVarChar) { Value = AreaName });

                using (DataTable result = database.GetDataTable("dbo.TeamByAreaGet", parameters))
                {
                    foreach (DataRow dr in result.Rows)
                    {
                        ret.Add(dr["Name"].ToString());
                    }
                }
            }

            return ret;

        }

        public static List<string> GetRoutinesByArea(string AreaName)
        {
            List<string> ret = new List<string>();

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {

                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("AreaName", SqlDbType.NVarChar) { Value = AreaName });

                using (DataTable result = database.GetDataTable("dbo.RoutineNameByArea", parameters))
                {
                    foreach (DataRow dr in result.Rows)
                    {
                        ret.Add(dr["Name"].ToString());
                    }
                }
            }

            return ret;

        }

        public static List<string> GetUsersByTeam(string TeamName)
        {
            List<string> ret = new List<string>();

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {

                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("TeamName", SqlDbType.NVarChar) { Value = TeamName });

                using (DataTable result = database.GetDataTable("dbo.UsersByTeamGet", parameters))
                {
                    foreach (DataRow dr in result.Rows)
                    {
                        ret.Add(dr["Name"].ToString());
                    }
                }
            }

            return ret;

        }

        public static List<string> RoutineNameByArea(string AreaName)
        {
            List<string> ret = new List<string>();

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {

                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("AreaName", SqlDbType.NVarChar) { Value = AreaName });

                using (DataTable result = database.GetDataTable("dbo.RoutineNameByArea", parameters))
                {
                    foreach (DataRow dr in result.Rows)
                    {
                        ret.Add(dr["Name"].ToString());
                    }
                }
            }

            return ret;

        }

        public void ScheduleRoutine(string Routine, string Team, string User, string DateFor, int Rate, string Period, int Number)
        {


        }

    };
}