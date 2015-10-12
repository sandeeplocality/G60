using System;
using System.Web;
using System.IO;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using UniGuardLib;

namespace G60
{
    /// <summary>
    /// Summary description for Handler
    /// </summary>
    public class Handler : IHttpHandler
    {

        ErrorLog obj = new ErrorLog();
        public void ProcessRequest(HttpContext ctx)
        {
            string json;
            using (var reader = new System.IO.StreamReader(ctx.Request.InputStream))
            {
                json = reader.ReadToEnd();
                obj.Write_ErrorLog("1:" + json);
                json = System.Web.HttpUtility.UrlDecode(json);
                if (json.Contains("DeviceData="))
                {
                    json = json.Remove(0, 11);
                }
            }
            ctx.Response.ContentType = "text/plain";
            if (!string.IsNullOrEmpty(json))
            {
                try
                {
                    try
                    {
                        // Parse JSON into dynamic object, convenient!
                        System.Collections.Generic.Dictionary<string, object> values = JsonConvert.DeserializeObject<System.Collections.Generic.Dictionary<string, object>>(json);

                        Newtonsoft.Json.Linq.JObject results = Newtonsoft.Json.Linq.JObject.Parse(json);
                        int recard_count = 0;
                        string DateUTC = "";
                        foreach (var result in results["Records"])
                        {
                            string Reason = (string)result["Reason"];
                            //  DateUTC = (string)result["DateUTC"];
                            if (Reason == "17")
                            {
                                Newtonsoft.Json.Linq.JObject results1 = Newtonsoft.Json.Linq.JObject.Parse(Convert.ToString(result));
                                foreach (var result1 in results1["Fields"])
                                {
                                    string cdata = (string)result1["Data"];
                                    if (!string.IsNullOrEmpty(Convert.ToString(cdata)))
                                    {
                                        recard_count = recard_count + 1;
                                    }
                                }
                            }
                        }
                        if (recard_count != 0)
                        {

                            string dev_SerNo = (string)results["SerNo"];


                            G60_Data obj_DB_name = new G60_Data();
                            DataTable dt_database_name = new DataTable();
                            dt_database_name = obj_DB_name.get_database_name(dev_SerNo);
                            if (dt_database_name.Rows.Count > 0)
                            {
                                string databaseName = dt_database_name.Rows[0]["schCode"].ToString();


                                // Add data
                                UniGuardLib.Data data = new UniGuardLib.Data(databaseName);

                                /*********************************************
                                 * INSERT IMPORT DATA
                                 *********************************************/

                                InsertQuery insertImport = new InsertQuery();
                                insertImport.SetTable("import");
                                insertImport.SetFields(new string[4] { "impDate", "impTime", "impRecordCount", "impLiveData" });

                                // Adjust time if necessary
                                string importDateTime = (Convert.ToDateTime(DateTime.Now)).ToString();
                                string newImportDate = data.AdjustTimezone(importDateTime, "yyyy-MM-dd", dev_SerNo);
                                string newImportTime = data.AdjustTimezone(importDateTime, "HH:mm:ss", dev_SerNo);

                                //string newImportDate = (Convert.ToDateTime(importDateTime)).ToString("yyyy-MM-dd");
                                //string newImportTime = (Convert.ToDateTime(importDateTime)).ToString("HH:mm:ss");

                                // Add rows
                                insertImport.AddRowValues(new string[4] { newImportDate, newImportTime, recard_count.ToString(), "1" });

                                // Insert the import and retrieve the import Id
                                Data objdata = new Data(databaseName);
                                int importId = objdata.InsertImport(insertImport);

                                /*********************************************
                                 * INSERT PATROL RECORDS
                                 *********************************************/
                                if (recard_count > 0)
                                {


                                    foreach (var result in results["Records"])
                                    {
                                        if (((string)result["DateUTC"]) != null)
                                        {
                                            DateUTC = (string)result["DateUTC"];
                                        }

                                        // this can be a string or null
                                        string Reason = (string)result["Reason"];
                                        if (Reason == "17")
                                        {
                                            Newtonsoft.Json.Linq.JObject results1 = Newtonsoft.Json.Linq.JObject.Parse(Convert.ToString(result));



                                            foreach (var result1 in results1["Fields"])
                                            {
                                                string cdata = (string)result1["Data"];
                                                if (!string.IsNullOrEmpty(Convert.ToString(cdata)))
                                                {
                                                    var base64 = cdata;
                                                    var base64_data = Convert.FromBase64String(base64);
                                                    string hexValue = ByteArrayToString(base64_data);
                                                    int decValue = int.Parse(hexValue, System.Globalization.NumberStyles.HexNumber);
                                                    // Prepare new InserQuery for patrol data
                                                    InsertQuery insertPatrol = new InsertQuery();
                                                    insertPatrol.SetTable("patrol");
                                                    insertPatrol.SetFields(new string[5] { "import_id", "patTSN", "patDate", "patTime", "patRSN" });

                                                    //string date = (Convert.ToDateTime(DateUTC)).ToString("yyyy-MM-dd");
                                                    //string time = (Convert.ToDateTime(DateUTC)).ToString("HH:mm:ss");
                                                    //string date = newImportDate1;
                                                    //string time = newImportTime1;

                                                    string importDateTime1 = (Convert.ToDateTime(DateUTC)).ToString();
                                                    string date = data.AdjustTimezone(importDateTime1, "yyyy-MM-dd", dev_SerNo);
                                                    string time = data.AdjustTimezone(importDateTime1, "HH:mm:ss", dev_SerNo);

                                                    insertPatrol.AddRowValues(new string[5] { importId.ToString(), Convert.ToString(decValue), date, time, Convert.ToString(dev_SerNo) });
                                                    data.InsertPatrol(insertPatrol);


                                                }
                                            }
                                        }
                                    }

                                }
                            }

                        }
                    }
                    catch (Exception ex)
                    {
                        obj.Write_ErrorLog("2:" + ex.ToString());
                        System.Collections.Generic.Dictionary<string, object> values = JsonConvert.DeserializeObject<System.Collections.Generic.Dictionary<string, object>>(json);
                        string logFolder = @"C:\g60";
                        string serialNumber = values["SerNo"].ToString();
                        string fileName = string.Format("{0} - {1}.txt", serialNumber, DateTime.Now.ToString("yyyyMMddHHmmss"));
                        System.IO.File.WriteAllText(System.IO.Path.Combine(logFolder, fileName), json);
                        obj.Write_ErrorLog("3:" + json);
                        ctx.Response.Write("Insert successful");
                    }
                }
                catch (Exception ex)
                {
                    obj.Write_ErrorLog("4:" + ex.ToString());
                    // System.Collections.Generic.Dictionary<string, object> values = JsonConvert.DeserializeObject<System.Collections.Generic.Dictionary<string, object>>(json);
                    string logFolder = @"C:\g60";
                    string serialNumber = "1234";
                    string fileName = string.Format("{0} - {1}.txt", serialNumber, DateTime.Now.ToString("yyyyMMddHHmmss"));
                    System.IO.File.WriteAllText(System.IO.Path.Combine(logFolder, fileName), json);
                    obj.Write_ErrorLog("4:" + json);
                    ctx.Response.Write("Insert successful");
                    ctx.Response.StatusCode = (int)System.Net.HttpStatusCode.InternalServerError;
                    ctx.Response.Write(string.Format("ERROR: {0}", ex.Message));
                }
            }
            else
            {
                ctx.Response.TrySkipIisCustomErrors = true;
                ctx.Response.StatusCode = (int)System.Net.HttpStatusCode.InternalServerError;
                obj.Write_ErrorLog("6:" + "ERROR: No POST Data!");
                ctx.Response.Write(string.Format("ERROR: No POST Data!"));
            }
        }
        public bool IsReusable
        {
            get { return false; }
        }
        public static string ByteArrayToString(byte[] ba)
        {
            System.Text.StringBuilder hex = new System.Text.StringBuilder(ba.Length * 2);
            foreach (byte b in ba)
                hex.AppendFormat("{0:x2}", b);
            return hex.ToString();
        }
        private string recorderSerial;
        public string RecorderSerial
        {
            set { this.recorderSerial = value; }
            get { return this.recorderSerial; }
        }


    }


}