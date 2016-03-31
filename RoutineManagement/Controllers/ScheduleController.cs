using RoutineManagement.Models;
using System.Web.Mvc;
using System.Web.Script.Serialization;

namespace RoutineManagement.Controllers
{
    public class ScheduleController : Controller
    {
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

        public string LoadCommentsForSchedule(int ScheduleID)
        {
            return new JavaScriptSerializer().Serialize(Json(Comment.LoadCommentsForSchedule(ScheduleID)).Data);
        }

        public void AddCommentToScheduledRoutine(int? ScheduleID, string UserComment, int? ParentID)
        {
            Comment.AddCommentToScheduledRoutine(ScheduleID, UserComment, ParentID);
        }
    }
}