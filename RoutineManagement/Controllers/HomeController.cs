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

        public void SaveRoutine(AgendaRoutineModel Routine)
        {
            Routine.Save();
        }

        public void SaveScheduledRoutine(AgendaRoutineModel Routine, int ScheduleID)
        {
            Routine.SaveScheduledRoutine(ScheduleID);
        }

        public string LoadRoutine(int RoutineID)
        {
            AgendaRoutineModel routine = new AgendaRoutineModel();
            routine.Load(RoutineID);

            return new JavaScriptSerializer().Serialize(Json(routine).Data);
        }

        public string LoadScheduledRoutine(int ScheduleID)
        {
            AgendaRoutineModel routine = new AgendaRoutineModel();
            routine.LoadScheduledRoutine(ScheduleID);

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

            ScheduleModel schedule = new ScheduleModel();

            schedule.LoadSchedule();

            return new JavaScriptSerializer().Serialize(Json(schedule).Data);
        }

        public void ScheduleRoutine(ScheduledRoutine SR)
        {
            SR.SaveScheduledRoutine();
        }

        public string LoadComments()
        {
            return "";
        }

        public void SaveComment()
        {

        }

        public string ValidateRoutineName(string routineName, string area)
        {
            return AgendaRoutineModel.ValidateRoutineName(routineName, area);
        }


        public string GetFieldTypes()
        {
            return new JavaScriptSerializer().Serialize(Json(AgendaRoutineModel.GetFieldTypes()).Data);
        }
        
    }
}
