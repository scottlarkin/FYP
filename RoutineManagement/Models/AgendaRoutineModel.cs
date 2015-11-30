using DataAccess;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace RoutineManagement.Models
{

    public class AgendaRoutineModel
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public List<ChecksheetModel> Checksheets { get; set; }
        public string Area { get; set; }

        public static List<FieldType> GetFieldTypes()
        {
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                using (DataTable dt = database.GetDataTable("dbo.TypeGet", new List<SqlParameter>()))
                {
                    List<FieldType> types = new List<FieldType>();

                    FieldType ft;

                    foreach (DataRow row in dt.Rows)
                    {
                        ft = new FieldType();

                        ft.ID = int.Parse(row["ID"].ToString());
                        ft.Name = row["Name"].ToString();
                        ft.HtmlType = row["HTMLType"].ToString();

                        types.Add(ft);
                    }

                    return types;
                }
            }
        }

        public AgendaRoutineModel()
        {
            Checksheets = new List<ChecksheetModel>();
        }

        public void Load(int ID)
        {
            //execute procedure to get a routine and convert data tables to C# model
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                List<SqlParameter> parameters = new List<SqlParameter>();

                parameters.Add(new SqlParameter("@RoutineID", SqlDbType.Int) { Value = ID });

                using (DataSet routine = database.GetDataSet("dbo.RoutineGet", parameters))
                {
                    DataTable checksheets = routine.Tables[1];
                    DataTable fields = routine.Tables[2];
                    DataTable records = routine.Tables[3];
                    DataTable fieldvalues = routine.Tables[4];

                    int fieldCounter = 0;
                    int recordCounter = 0;
                    int fieldValueCounter = 0;

                    this.ID = int.Parse(routine.Tables[0].Rows[0]["ID"].ToString());
                    Name = routine.Tables[0].Rows[0]["Name"].ToString();

                    foreach (DataRow csRow in checksheets.Rows)
                    {
                        int numFields = int.Parse(csRow["FieldCount"].ToString());
                        int numRecords = int.Parse(csRow["RecordCount"].ToString());
                        ChecksheetModel checksheet = new ChecksheetModel();

                        checksheet.Name = csRow["ChecksheetName"].ToString();

                        for (int i = 0; i < numFields; i++)
                        {
                            Field field = new Field();

                            field.Name = fields.Rows[fieldCounter]["FieldName"].ToString();
                            field.TypeID = int.Parse(fields.Rows[fieldCounter++]["FieldTypeID"].ToString());

                            checksheet.Fields.Add(field);
                        }

                        for (int i = 0; i < numRecords; i++)
                        {
                            Record record = new Record();

                            record.Name = records.Rows[recordCounter++]["RecordName"].ToString();

                            if (i > 0)
                            {
                                for (int j = 0; j < numFields; j++)
                                {
                                    FieldValue fieldValue = new FieldValue();

                                    fieldValue.Value = fieldvalues.Rows[fieldValueCounter++]["Value"].ToString();
                                    record.FieldValues.Add(fieldValue);
                                }
                            }

                            checksheet.Records.Add(record);
                        }

                        Checksheets.Add(checksheet);
                    }
                }
            }
        }


        public void LoadScheduledRoutine(int ScheduleID)
        {
            //execute procedure to get a routine and convert data tables to C# model
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                List<SqlParameter> parameters = new List<SqlParameter>();

                parameters.Add(new SqlParameter("@ScheduleID", SqlDbType.Int) { Value = ScheduleID });

                using (DataSet routine = database.GetDataSet("dbo.ScheduledRoutineGet", parameters))
                {
                    DataTable checksheets = routine.Tables[1];
                    DataTable fields = routine.Tables[2];
                    DataTable records = routine.Tables[3];
                    DataTable fieldvalues = routine.Tables[4];

                    int fieldCounter = 0;
                    int recordCounter = 0;
                    int fieldValueCounter = 0;

                    this.ID = int.Parse(routine.Tables[0].Rows[0]["ID"].ToString());
                    Name = routine.Tables[0].Rows[0]["Name"].ToString();
                    Description = routine.Tables[0].Rows[0]["Description"].ToString();

                    foreach (DataRow csRow in checksheets.Rows)
                    {
                        int numFields = int.Parse(csRow["FieldCount"].ToString());
                        int numRecords = int.Parse(csRow["RecordCount"].ToString());
                        ChecksheetModel checksheet = new ChecksheetModel();

                        checksheet.Name = csRow["ChecksheetName"].ToString();

                        for (int i = 0; i < numFields; i++)
                        {
                            Field field = new Field();

                            field.Name = fields.Rows[fieldCounter]["FieldName"].ToString();
                            field.TypeID = int.Parse(fields.Rows[fieldCounter++]["FieldTypeID"].ToString());

                            checksheet.Fields.Add(field);
                        }

                        for (int i = 0; i < numRecords; i++)
                        {
                            Record record = new Record();

                            record.Name = records.Rows[recordCounter++]["RecordName"].ToString();

                            if (i > 0)
                            {
                                for (int j = 0; j < numFields; j++)
                                {
                                    FieldValue fieldValue = new FieldValue();
                                    fieldValue.Editable = fieldvalues.Rows[fieldValueCounter]["Editable"].ToString() == "true";
                                    fieldValue.Value = fieldvalues.Rows[fieldValueCounter++]["Value"].ToString();
                                    record.FieldValues.Add(fieldValue);
                                }
                            }

                            checksheet.Records.Add(record);
                        }

                        Checksheets.Add(checksheet);
                    }
                }
            }
        }

        public static string ValidateRoutineName(string routinename, string area)
        {
            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("RoutineName", SqlDbType.NVarChar) { Value = routinename.Replace("'", "''") });
                parameters.Add(new SqlParameter("Area", SqlDbType.NVarChar) { Value = area.Replace("'", "''") });
                return database.GetValue("dbo.ValidateRoutineName", parameters);
            }
        }

        public bool Save()
        {

            //convert the routine into data tables and send to sql

            bool success = true;

            using (SqlServer database = new SqlServer(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ToString()))
            {
                DataTable checksheets = new DataTable();
                DataTable records = new DataTable();
                DataTable fields = new DataTable();
                DataTable fieldValues = new DataTable();
                List<SqlParameter> parameters = new List<SqlParameter>();

                checksheets.Columns.Add("ID", typeof(string));
                checksheets.Columns.Add("Name", typeof(string));
                checksheets.Columns.Add("Description", typeof(string));

                records.Columns.Add("ChechsheetID", typeof(int));
                records.Columns.Add("Name", typeof(string));

                fields.Columns.Add("ChechsheetID", typeof(int));
                fields.Columns.Add("Name", typeof(string));
                fields.Columns.Add("TypeID", typeof(int));

                fieldValues.Columns.Add("ChechsheetID", typeof(int));
                fieldValues.Columns.Add("Value", typeof(string));
                fieldValues.Columns.Add("Editable", typeof(string));

                for (int i = 0; i < Checksheets.Count; i++)
                {
                    ChecksheetModel cs = Checksheets[i];
                    string csID = (i + 1).ToString();
                    DataRow csNewRow = checksheets.NewRow();

                    csNewRow["ID"] = csID;
                    csNewRow["Name"] = cs.Name.Replace("'", "''");
                    csNewRow["Description"] = cs.Description.Replace("'", "''");

                    checksheets.Rows.Add(csNewRow);

                    foreach (Field f in cs.Fields)
                    {
                        DataRow newRow = fields.NewRow();

                        newRow["ChechsheetID"] = csID;
                        newRow["Name"] = f.Name.Replace("'", "''");
                        newRow["TypeID"] = f.TypeID;
                        fields.Rows.Add(newRow);
                    }

                    foreach (Record r in cs.Records)
                    {
                        DataRow newRow = records.NewRow();

                        newRow["ChechsheetID"] = csID;
                        newRow["Name"] = r.Name.Replace("'", "''");

                        records.Rows.Add(newRow);

                        if (r != cs.Records[0])
                        {
                            foreach (FieldValue fv in r.FieldValues)
                            {
                                DataRow fvNewRow = fieldValues.NewRow();

                                fvNewRow["ChechsheetID"] = csID;
                                if (fv.Value != null)
                                {
                                    fvNewRow["Value"] = fv.Value.Replace("'", "''");
                                }
                                fvNewRow["Editable"] = fv.Editable.ToString();

                                fieldValues.Rows.Add(fvNewRow);
                            }
                        }
                    }
                }

                parameters.Add(new SqlParameter("@Name", SqlDbType.NVarChar) { Value = Name.Replace("'", "''") });
                parameters.Add(new SqlParameter("@Description", SqlDbType.NVarChar) { Value = Description.Replace("'", "''") });
                parameters.Add(new SqlParameter("@Checksheets", SqlDbType.Structured) { TypeName = "dbo.ChecksheetList", Value = checksheets });
                parameters.Add(new SqlParameter("@Records", SqlDbType.Structured) { TypeName = "dbo.RecordList", Value = records });
                parameters.Add(new SqlParameter("@Fields", SqlDbType.Structured) { TypeName = "dbo.FieldList", Value = fields });
                parameters.Add(new SqlParameter("@FieldValues", SqlDbType.Structured) { TypeName = "dbo.FieldValueList", Value = fieldValues });
                parameters.Add(new SqlParameter("@Area", SqlDbType.NVarChar) { Value = Area.ToString().Replace("'", "''") });

                database.ExecuteProcedure("dbo.RoutineSave", parameters);

            }

            return success;
        }

    };
}