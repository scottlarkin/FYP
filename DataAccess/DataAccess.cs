//Author: Scott Larkin
//Date: Oct 2015

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

namespace DataAccess
{
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
                throw ex;
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
                catch(SqlException e)
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

                command.ExecuteNonQuery();
            }
        }

        public void Dispose()
        {
            connection.Close();
            connection.Dispose();
        }

    }
}
