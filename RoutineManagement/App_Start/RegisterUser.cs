using DataAccess;
using System.Web.Configuration;

namespace RoutineManagement.App_Start
{
    public class RegisterUser
    {
        public static void Register()
        {
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                database.ExecuteProcedure("dbo.RegisterUser");
            }
        }
    }
}