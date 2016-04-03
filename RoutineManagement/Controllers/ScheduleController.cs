using RoutineManagement.Models;
using System;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace RoutineManagement.Controllers
{
    public class ScheduleController : Controller
    {
        public string LoadSchedule()
        {

            ScheduleModel schedule = new ScheduleModel();

            try
            {
                schedule.LoadSchedule();
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(schedule).Data);
        }

        public void ScheduleRoutine(ScheduledRoutine SR)
        {
            try
            {
                SR.SaveScheduledRoutine();
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }
        }

        public string LoadCommentsForSchedule(int ScheduleID)
        {
            string comments = "";

            try
            {
                comments = new JavaScriptSerializer().Serialize(Json(Comment.LoadCommentsForSchedule(ScheduleID)).Data);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return new JavaScriptSerializer().Serialize(Json(Comment.LoadCommentsForSchedule(ScheduleID)).Data);
        }

        public void AddCommentToScheduledRoutine(int? ScheduleID, string UserComment, int? ParentID)
        {
            try
            {
                Comment.AddCommentToScheduledRoutine(ScheduleID, UserComment, ParentID);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }
        }
    }
}