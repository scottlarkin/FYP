using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace RoutineManagement.Models
{
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

        public static string GetUserName()
        {
            string n = "";

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                n = database.GetValue("dbo.UserNameGet", new List<System.Data.SqlClient.SqlParameter>()).ToString();
            }

            return n;
        }
    }
}