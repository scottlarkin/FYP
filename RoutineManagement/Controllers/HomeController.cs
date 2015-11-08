using MvcApplication2.Models;
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
