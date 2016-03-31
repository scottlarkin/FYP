using DataAccess;
using RoutineManagement.Models;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace RoutineManagement.Controllers
{
    public class AdminController : Controller
    {
        public void UpdateUserAccessLevel(string UserName, int AccessLevelID)
        {
            UserInfo.UpdateAccessLevel(UserName, AccessLevelID);
        }

        public string GetUserAccessLevels(string UserName)
        {
            return new JavaScriptSerializer().Serialize(Json(UserInfo.GetUserAccessLevel(UserName)).Data);
        }

        public void AddArea(string AreaName, string ParentAreaName)
        {

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                List<SqlParameter> parameters = new List<SqlParameter>();

                parameters.Add(new System.Data.SqlClient.SqlParameter("@AreaName", SqlDbType.NVarChar) { Value = AreaName });
                parameters.Add(new System.Data.SqlClient.SqlParameter("@ParentAreaName", SqlDbType.NVarChar) { Value = ParentAreaName });

                database.ExecuteProcedure("dbo.AreaAdd", parameters);

            }

        }

        public void AddTeam(string TeamName)
        {
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                List<SqlParameter> parameters = new List<SqlParameter>();

                parameters.Add(new System.Data.SqlClient.SqlParameter("@TeamName", SqlDbType.NVarChar) { Value = TeamName });

                database.ExecuteProcedure("dbo.TeamAdd", parameters);

            }

        }
    }
}