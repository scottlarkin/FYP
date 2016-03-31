using RoutineManagement.Models;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace RoutineManagement.Controllers
{
    public class RoutineController : Controller
    {

        public string GetRoutinesByArea(string AreaName)
        {
            List<string> routines = ScheduleModel.GetRoutinesByArea(AreaName);

            return new JavaScriptSerializer().Serialize(Json(routines).Data);
        }


        public void SaveRoutine(AgendaRoutineModel Routine)
        {
            Routine.Save();
        }

        public void CompleteScheduledRoutine(int ScheduleID)
        {
            AgendaRoutineModel.CompleteScheduledRoutine(ScheduleID);
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

        public string GetRoutineList()
        {
            List<AgendaRoutineModel> rl = AgendaRoutineModel.GetRoutineList();

            return new JavaScriptSerializer().Serialize(Json(rl).Data);
        }

        public string LoadScheduledRoutine(int ScheduleID)
        {
            AgendaRoutineModel routine = new AgendaRoutineModel();
            routine.LoadScheduledRoutine(ScheduleID);

            return new JavaScriptSerializer().Serialize(Json(routine).Data);
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