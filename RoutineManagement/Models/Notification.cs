using MongoDB.Bson;
using MongoDB.Bson.IO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RoutineManagement.Models
{
    public class Notification
    {

        public static string GetNotificationsForUser(string user)
        {

            List<BsonDocument> notifications = new List<BsonDocument>();
            string ret = "null";

            for (int i = 0; i < 100; i++)
            {

                DataAccess.MongoDB mdb = new DataAccess.MongoDB("RoutineManagement");

                notifications = mdb.Get("Notification", new BsonDocument("user", user).Add("seen", "false"));

                if (notifications.Count > 0)
                {
                    ret = "[";

                    foreach (var item in notifications)
                    {
                        ret += item.ToJson(new JsonWriterSettings { OutputMode = JsonOutputMode.Strict });

                        if (item != notifications.Last() && notifications.Count > 1)
                        {
                            ret += ",";
                        }


                        BsonDocument updated = (BsonDocument)item.Clone();
                        updated["seen"] = "true";


                        mdb.update("Notification",item, updated);


                    }
                    notifications = mdb.Get("Notification", new BsonDocument("user", user).Add("seen", "false"));
                    ret += "]";

                    break;
                }

                System.Threading.Thread.Sleep(100);
            }

            return ret;
        }
    }
}