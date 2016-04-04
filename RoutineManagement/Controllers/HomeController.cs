using RoutineManagement.Models;
using System;
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

        public void RegisterUser()
        {
            try
            {
                UserInfo.RegisterUser();
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }
        }

        public int GetUserPrivilege()
        {
            int p = 0;

            try
            {
                p = UserInfo.GetPrivilege();
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return p;
        }

        public string GetUserName()
        {
            string name = "";

            try
            {
                name = UserInfo.GetUserName();
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return name;
        }

        public string GetAllUserNames()
        {
            List<string> users;

            try
            {
                users = UserInfo.GetAllUserNames();
            }
            catch (Exception e)
            {
                users = new List<string>();
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(users).Data);
        }

        public string GetAreas()
        {
            List<string> areas;

            try
            {
                areas = ScheduleModel.GetAreas();
            }
            catch (Exception e)
            {
                areas = new List<string>();
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(areas).Data);
        }

        public string GetTeamsByArea(string AreaName)
        {
            List<string> teams;

            try
            {
                teams = ScheduleModel.GetTeamsByArea(AreaName);
            }
            catch (Exception e)
            {
                teams = new List<string>();
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(teams).Data);
        }

        public string GetUsersByTeam(string TeamName)
        {
            List<string> users;

            try
            {
                users = ScheduleModel.GetUsersByTeam(TeamName);
            }
            catch (Exception e)
            {
                users = new List<string>();
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(users).Data);
        }

    }
}
