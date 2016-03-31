using RoutineManagement.Models;
using System.Web.Mvc;

namespace RoutineManagement.Controllers
{
    public class NotificationController : Controller
    {
        public string GetNewNotifications(string user)
        {
            return Notification.GetNewNotificationsForUser(user);
        }

        public string GetNotifications(string user)
        {
            return Notification.GetNotificationsForUser(user);
        }

        public void ReadNotifications(string user)
        {
            Notification.ReadNotifications(user);
        }

        public void ClearNotifications(string user)
        {
            Notification.ClearNotifications(user);
        }
    }
}