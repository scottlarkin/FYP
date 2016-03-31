using RoutineManagement.Models;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace RoutineManagement.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.Title = "Schedule";

            return View();
        
        }

        public ActionResult Admin()
        {
            ViewBag.Title = "Admin";

            return View();
        }

        public ActionResult Routine(int scheduleID)
        {
            ViewBag.Title = "Scheduled Routine";
            ViewBag.ScheduleID = scheduleID;

            return View();
        }

        public ActionResult Builder(int? routineID = null)
        {
            routineID = routineID ?? 0;
            ViewBag.Title = "Routine Builder";
            ViewBag.RoutineID = routineID;

            return View();
        }

        public int GetUserPrivilege()
        {
            return UserInfo.GetPrivilege();
        }

        public string GetUserName()
        {
            return UserInfo.GetUserName();
        }

        public string GetAllUserNames()
        {
            List<string> users = UserInfo.GetAllUserNames();

            return new JavaScriptSerializer().Serialize(Json(users).Data);
        }

        public string GetAreas()
        {
            List<string> areas = ScheduleModel.GetAreas();

            return new JavaScriptSerializer().Serialize(Json(areas).Data);
        }

        public string GetTeamsByArea(string AreaName)
        {
            List<string> teams = ScheduleModel.GetTeamsByArea(AreaName);

            return new JavaScriptSerializer().Serialize(Json(teams).Data);
        }

        public string GetUsersByTeam(string TeamName)
        {
            List<string> users = ScheduleModel.GetUsersByTeam(TeamName);

            return new JavaScriptSerializer().Serialize(Json(users).Data);
        }

        public string LoadComments()
        {
            return "";
        }

        public void SaveComment()
        {

        }
        
    }
}
