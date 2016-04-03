using RoutineManagement.Models;
using System;
using System.Web.Mvc;

namespace RoutineManagement.Controllers
{
    public class NotificationController : Controller
    {
        public string GetNewNotifications(string user)
        {
            try
            {

            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return Notification.GetNewNotificationsForUser(user);
        }

        public string GetNotifications(string user)
        {
            string notifications = "";

            try
            {
                notifications = Notification.GetNotificationsForUser(user);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }

            return notifications;
        }

        public void ReadNotifications(string user)
        {
            try
            {
                Notification.ReadNotifications(user);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }
        }

        public void ClearNotifications(string user)
        {
            try
            {
                Notification.ClearNotifications(user);
            }
            catch (Exception e)
            {
                new EventLogger.EventLogger("Routine Management", "Application").WriteException(e);
            }
        }
    }
}