using MvcApplication2.Models;
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

        public ActionResult Routine(int routineID)
        {
            ViewBag.Title = "Routine";
            ViewBag.RoutineID = routineID;

            return View();
        }

        public ActionResult Builder(int? routineID = null)
        {
            routineID = routineID ?? 0;
            ViewBag.Title = "Routine Builder";
            ViewBag.RoutineID = routineID;

            return View();
        }

        public void SaveRoutine(AgendaRoutineModel Routine)
        {
            Routine.Save();
        }

        public string LoadRoutine(int RoutineID)
        {
            AgendaRoutineModel routine = new AgendaRoutineModel();
            routine.Load(RoutineID);

            return new JavaScriptSerializer().Serialize(Json(routine).Data);
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

        public string GetRoutinesByArea(string AreaName)
        {
            List<string> routines = ScheduleModel.GetRoutinesByArea(AreaName);

            return new JavaScriptSerializer().Serialize(Json(routines).Data);
        }

        public string GetUsersByTeam(string TeamName)
        {
            List<string> users = ScheduleModel.GetUsersByTeam(TeamName);

            return new JavaScriptSerializer().Serialize(Json(users).Data);
        }

        public string LoadSchedule()
        {
            return "";
        }

        public void ScheduleRoutine()
        {

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
