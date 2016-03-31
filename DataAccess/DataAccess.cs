//Author: Scott Larkin
//Date: Oct 2015

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using MongoDB.Bson;
using MongoDB.Driver;

namespace DataAccess
{

    //DAL for interacting with mongoDB... Didnt have much time to do this so its a bit bare
    public class MongoDB
    {
        protected static IMongoClient client;
        protected static IMongoDatabase database;

        public MongoDB(string db)
        {
            client = new MongoClient();
            database = client.GetDatabase(db);
        }


        //basic insert function
        public void Insert(string collection, BsonDocument item)
        {
            database.GetCollection<BsonDocument>(collection).InsertOne(item);
        }

        //get all documents in a collection which match the filter, with options to order the result based on the name of a field in the found documents
        public List<BsonDocument> Get(string collection, BsonDocument filter, string OrderDescending = "", string OrderAscending = "")
        {
            var col = database.GetCollection<BsonDocument>(collection);

            var ret = col.Find<BsonDocument>(filter);

            if (OrderDescending != "")
            {
               ret.SortByDescending(bson => bson[OrderDescending]);
            }

            if (OrderAscending != "")
            {
                ret.SortByDescending(bson => bson[OrderAscending]);
            }
           
            List<BsonDocument> h = ret.ToList<BsonDocument>();

            return h;
        }

        //replace all documents in a collection, which match the filter, with another document.
        public void Update(string collection, BsonDocument filter, BsonDocument replacement)
        {
            database.GetCollection<BsonDocument>(collection).ReplaceOne(filter, replacement);
        }


        //remove all documents in a collection which match the filter.
        public void Delete(string collection, BsonDocument filter)
        {
            database.GetCollection<BsonDocument>(collection).DeleteMany(filter);
        }

    }

    public class SqlServer : IDisposable
    {

        private string connectionString;
        private SqlConnection connection;

        public SqlServer(string ConnectionString)
        {
            connectionString = ConnectionString;
            Connect();
        }

        ~SqlServer()
        {
            Dispose();
        }

        public bool Connect()
        {
            try
            {
                connection = new SqlConnection(connectionString);
                connection.Open();
            }
            catch (Exception ex)
            {
                // throw ex;
                return false;
            }

            return true;
        }

        public void ExecuteCommand(string SQL, List<SqlParameter> parameters)
        {
            using (SqlCommand command = new SqlCommand(SQL, connection))
            {

                foreach (SqlParameter p in parameters)
                {
                    command.Parameters.Add(p);
                }

                command.ExecuteNonQuery();
            }
        }


        public DataTable GetDataTable(string SQL, List<SqlParameter> parameters)
        {
            using (DataTable dt = new DataTable())
            using (SqlDataAdapter adapter = new SqlDataAdapter())
            using (SqlCommand command = new SqlCommand(SQL, connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter p in parameters)
                {
                    command.Parameters.Add(p);
                }

                adapter.SelectCommand = command;
                adapter.Fill(dt);

                return dt;
            }
        }

        public DataSet GetDataSet(string SQL, List<SqlParameter> parameters)
        {
            using (DataSet ds = new DataSet())
            using (SqlDataAdapter adapter = new SqlDataAdapter())
            using (SqlCommand command = new SqlCommand(SQL, connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter p in parameters)
                {
                    command.Parameters.Add(p);
                }

                adapter.SelectCommand = command;
                adapter.Fill(ds);

                return ds;
            }
        }

        public string GetValue(string SQL, List<SqlParameter> parameters)
        {

            using (DataTable dt = new DataTable())
            using (SqlDataAdapter adapter = new SqlDataAdapter())
            using (SqlCommand command = new SqlCommand(SQL, connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter p in parameters)
                {
                    command.Parameters.Add(p);
                }

                adapter.SelectCommand = command;
                adapter.Fill(dt);

                if (dt.Rows[0][0] != null)
                {
                    return dt.Rows[0][0].ToString();
                }
            }

            return "";
        }

        public void ExecuteProcedure(string SQL, List<SqlParameter> parameters)
        {
            using (SqlCommand command = new SqlCommand(SQL, connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter p in parameters)
                {
                    command.Parameters.Add(p);
                }
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (SqlException e)
                {
                    int ln = e.LineNumber;
                }
            }
        }

        public void ExecuteProcedure(string SQL)
        {
            using (SqlCommand command = new SqlCommand(SQL, connection))
            {
                command.CommandType = CommandType.StoredProcedure;

                try
                {
                    command.ExecuteNonQuery();
                }
                catch
                {

                }
            }
        }

        public void Dispose()
        {
            connection.Close();
            connection.Dispose();
        }

    }
}
