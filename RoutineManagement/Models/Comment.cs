using DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace RoutineManagement.Models
{
    public class Comment
    {
        public int ID;
        public int ParentID;
        public string Text { get; set; }
        public List<Comment> Replies { get; set; }
        public string DateStamp { get; set; }
        public string UserName { get; set; }
        public string Reply { get; set; }

        public Comment()
        {
            Replies = new List<Comment>();
        }

        public static void AddCommentToScheduledRoutine(int? ScheduleID, string UserComment, int? ParentID)
        {
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                List<SqlParameter> parameters = new List<SqlParameter>();

                if (ScheduleID != null)
                    parameters.Add(new System.Data.SqlClient.SqlParameter("@ScheduleID", SqlDbType.Int) { Value = ScheduleID });

                parameters.Add(new System.Data.SqlClient.SqlParameter("@Comment", SqlDbType.NVarChar) { Value = UserComment.Replace("'", "''") });

                if (ParentID != null)
                    parameters.Add(new System.Data.SqlClient.SqlParameter("@ParentCommentID", SqlDbType.Int) { Value = ParentID});

                database.ExecuteProcedure("dbo.ScheduledRoutineCommentAdd", parameters);

            }

        }

        public static List<Comment> LoadCommentsForSchedule(int ScheduleID)
        {

            List<Comment> ret = new List<Comment>();

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {

                List<Comment> allComments = new List<Comment>();

                List<SqlParameter> parameters = new List<SqlParameter>();

                parameters.Add(new System.Data.SqlClient.SqlParameter("@ScheduleID", SqlDbType.Int) { Value = ScheduleID });

                using (DataTable dt = database.GetDataTable("dbo.CommentsForScheduleGet", parameters))
                {

                    foreach (DataRow dr in dt.Rows)
                    {
                        Comment c = new Comment();

                        c.ID = int.Parse(dr["ID"].ToString());
                        c.Text = dr["Comment"].ToString();
                        c.DateStamp = dr["DateStamp"].ToString();
                        c.UserName = dr["UserName"].ToString();
                        c.Reply = dr["Reply"].ToString();

                        int.TryParse(dr["ParentCommentID"].ToString(), out c.ParentID);

                        allComments.Add(c);
                    }


                    foreach (Comment c in allComments)
                    {

                        foreach (Comment cc in allComments)
                        {
                            if (c == cc)
                            {
                                continue;
                            }

                            if (cc.ParentID == c.ID)
                            {
                                c.Replies.Add(cc);
                            }

                        }

                        if (c.Replies.Count > 0 || c.Reply == "0")
                        {
                            ret.Add(c);
                        }
                    }

                }
            }

            return ret;
        }
    }
}