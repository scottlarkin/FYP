﻿using MongoDB.Bson;
using MongoDB.Bson.IO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RoutineManagement.Models
{
    public class Notification
    {

        public string Date { get; set; }
        public string User { get; set; }
        public string Text { get; set; }

        private const string NOTIFICATION_COL_NAME = "Notification";

        public Notification(string user, string text)
        {
            User = user;
            Text = text;
            Date = DateTime.Now.ToString();
        }

        public void Send()
        {
            BsonDocument d = new BsonDocument()
                                    .Add("id", BsonValue.Create(BsonType.ObjectId).ToString())
                                    .Add("date", Date)
                                    .Add("user", User)
                                    .Add("text", Text)
                                    .Add("seen", "false")
                                    .Add("sent", "false");

            DataAccess.MongoDB mdb = new DataAccess.MongoDB("RoutineManagement");

            mdb.Insert("Notification", d);

        }

        public static string GetNewNotificationsForUser(string user)
        {
            DataAccess.MongoDB mdb = new DataAccess.MongoDB("RoutineManagement");
            List<BsonDocument> notifications = new List<BsonDocument>();
            string ret = "null";

            for (int i = 0; i < 600; i++)
            {

                notifications = mdb.Get(NOTIFICATION_COL_NAME, new BsonDocument("user", user).Add("sent", "false"));

                if (notifications.Count > 0)
                {
                    //convert new notifications to JSON string
                    ret = ParseNotifications(notifications, (item) =>
                    {

                        BsonDocument updated = (BsonDocument)item.Clone();
                        updated["sent"] = "true";
                        //mark notification as sent
                        mdb.Update(NOTIFICATION_COL_NAME, item, updated);

                    });

                    break;
                }

                System.Threading.Thread.Sleep(200);
            }

            return ret;
        }

        public static string GetNotificationsForUser(string user)
        {

            List<BsonDocument> notifications = new List<BsonDocument>();
            DataAccess.MongoDB mdb = new DataAccess.MongoDB("RoutineManagement");

            notifications = mdb.Get(NOTIFICATION_COL_NAME, new BsonDocument("user", user).Add("sent", "true"), "date");

            return ParseNotifications(notifications);
        }


        public static void ReadNotifications(string user)
        {

            List<BsonDocument> notifications = new List<BsonDocument>();

            DataAccess.MongoDB mdb = new DataAccess.MongoDB("RoutineManagement");

            notifications = mdb.Get(NOTIFICATION_COL_NAME, new BsonDocument("user", user).Add("seen", "false"));

            foreach (BsonDocument doc in notifications)
            {
                BsonDocument updated = (BsonDocument)doc.Clone();
                updated["seen"] = "true";
                mdb.Update(NOTIFICATION_COL_NAME, doc, updated);
            }

        }

        public static void ClearNotifications(string user)
        {
            DataAccess.MongoDB mdb = new DataAccess.MongoDB("RoutineManagement");
            mdb.Delete(NOTIFICATION_COL_NAME, new BsonDocument("user", user));
        }

        //convert notification list to JSON string
        private static string ParseNotifications(List<BsonDocument> notifications, Action<BsonDocument> perNotificationAction = null)
        {
            string ret = "null";

            if (notifications.Count > 0)
            {
                ret = "[";

                foreach (var item in notifications)
                {
                    ret += item.ToJson(new JsonWriterSettings { OutputMode = JsonOutputMode.Strict });

                    if (item != notifications.Last() && notifications.Count > 1)
                        ret += ",";

                    if (perNotificationAction != null)
                        perNotificationAction((BsonDocument)item);

                }

                ret += "]";

            }

            return ret;
        }


    }
}