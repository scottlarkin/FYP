using DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace RoutineManagement.Models
{

    public class UserAccessLevel{
        public bool Reader {get;set;}
        public bool Writer {get;set;}
        public bool Editor {get;set;}
        public bool TeamReader {get;set;}
        public bool TeamWriter {get;set;}
        public bool TeamEditor {get;set;}
        public bool AreaReader {get;set;}
        public bool AreaWriter {get;set;}
        public bool AreaEditor {get;set;}
        public bool Admin {get;set;}
    };

    public class UserInfo
    {
        public static int GetPrivilege()
        {
            int p = 1;

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                p = int.Parse(database.GetValue("dbo.PrivilegeGet", new List<System.Data.SqlClient.SqlParameter>()));
            }

            return p;
        }

        public static void RegisterUser()
        {
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                database.ExecuteProcedure("dbo.RegisterUser");
            }
        }

        public static string GetUserName()
        {
            string n = "";

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                n = database.GetValue("dbo.UserNameGet", new List<System.Data.SqlClient.SqlParameter>()).ToString();
            }

            return n;
        }

        public static List<string> GetAllUserNames()
        {

            List<string> ret = new List<string>();

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (DataTable dt = database.GetDataTable("dbo.UserNamesGet", new List<System.Data.SqlClient.SqlParameter>()))
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        ret.Add(dr[0].ToString());
                    }
                }
            }

            return ret;

        }

        public static void UpdateAccessLevel(string UserName, int AccessLevelID)
        {
            List<System.Data.SqlClient.SqlParameter> parameters = new List<System.Data.SqlClient.SqlParameter>();

            parameters.Add(new System.Data.SqlClient.SqlParameter("@UserName", SqlDbType.NVarChar) { Value = UserName });
            parameters.Add(new System.Data.SqlClient.SqlParameter("@AccessLevelID", SqlDbType.Int) { Value = AccessLevelID });

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                database.GetDataTable("dbo.UserAccessLevelUpdate", parameters);
            }

        }

        public static UserAccessLevel GetUserAccessLevel(string UserName)
        {
            UserAccessLevel ret = new UserAccessLevel();
            List<System.Data.SqlClient.SqlParameter> parameters = new List<System.Data.SqlClient.SqlParameter>();

            parameters.Add(new System.Data.SqlClient.SqlParameter("@UserName", SqlDbType.NVarChar) { Value = UserName });

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (DataTable dt = database.GetDataTable("dbo.UserAccessLevelsGet", parameters))
                {

                    DataRow r = dt.Rows[0];

                    ret.Reader = r["Reader"].ToString() == "1";
                    ret.Writer = r["Writer"].ToString() == "1";
                    ret.Editor = r["Editor"].ToString() == "1";
                    ret.TeamReader = r["Team Reader"].ToString() == "1";
                    ret.TeamWriter = r["Team Writer"].ToString() == "1";
                    ret.TeamEditor = r["Team Editor"].ToString() == "1";
                    ret.AreaReader = r["Area Reader"].ToString() == "1";
                    ret.AreaWriter = r["Area Writer"].ToString() == "1";
                    ret.AreaEditor = r["Area Editor"].ToString() == "1";
                    ret.Admin = r["Admin"].ToString() == "1";

                }
            }

            return ret;
        }
    }
}