using RoutineManagement.Models;
using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace RoutineManagement.Controllers
{
    public class RoutineController : Controller
    {

        public string GetRoutinesByArea(string AreaName)
        {
            List<string> routines;

            try
            {
                routines = ScheduleModel.GetRoutinesByArea(AreaName);
            }
            catch (Exception e)
            {
                routines = new List<string>();
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(routines).Data);
        }

        public void SaveRoutine(AgendaRoutineModel Routine)
        {
            try
            {
                Routine.Save();
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }
        }

        public void CompleteScheduledRoutine(int ScheduleID)
        {
            try
            {
                AgendaRoutineModel.CompleteScheduledRoutine(ScheduleID);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }
        }

        public void SaveScheduledRoutine(AgendaRoutineModel Routine, int ScheduleID)
        {
            try
            {
                Routine.SaveScheduledRoutine(ScheduleID);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }
        }

        public string LoadRoutine(int RoutineID)
        {
            AgendaRoutineModel routine = new AgendaRoutineModel();

            try
            {
                routine.Load(RoutineID);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(routine).Data);
        }

        public string GetRoutineList()
        {
            List<AgendaRoutineModel> rl;

            try
            {
                 rl = AgendaRoutineModel.GetRoutineList();
            }
            catch (Exception e)
            {
                rl = new List<AgendaRoutineModel>();
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(rl).Data);
        }

        public string LoadScheduledRoutine(int ScheduleID)
        {
            AgendaRoutineModel routine = new AgendaRoutineModel();

            try
            {
                routine.LoadScheduledRoutine(ScheduleID);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(routine).Data);
        }

        public string ValidateRoutineName(string routineName, string area)
        {
            string valid = "";

            try
            {
                valid = AgendaRoutineModel.ValidateRoutineName(routineName, area); ;
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return valid;
        }
        
        public string GetFieldTypes()
        {
            string types = "";

            try
            {
                types = new JavaScriptSerializer().Serialize(Json(AgendaRoutineModel.GetFieldTypes()).Data);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return types;
        }
    }
}