using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;


namespace G60
{
    public class ErrorLog
    {
        public bool Write_ErrorLog(string LogMessage)
        {
            bool Status = false;
            DateTime CurrentDateTime = DateTime.Now;
            string CurrentDateTimeString = CurrentDateTime.ToString();
            string logLine = BuildLogLine(CurrentDateTime, LogMessage);
            lock (typeof(ErrorLog))
            {
                StreamWriter oStreamWriter = null;
                try
                {
                    var path = String.Format("{0}LogFiles\\Logdata.txt", AppDomain.CurrentDomain.BaseDirectory);
                    oStreamWriter = new StreamWriter(path, true);
                    oStreamWriter.WriteLine(logLine);
                    oStreamWriter.WriteLine("----------------------------------------------------------------------------------------------------------------------------------------------");
                    Status = true;
                }
                catch
                {
                }
                finally
                {
                    if (oStreamWriter != null)
                    {
                        oStreamWriter.Close();
                    }
                }
            }
            return Status;
        }
        private bool CheckCreateLogDirectory(string LogPath)
        {
            bool loggingDirectoryExists = false;
            DirectoryInfo oDirectoryInfo = new DirectoryInfo(LogPath);
            if (oDirectoryInfo.Exists)
            {
                loggingDirectoryExists = true;
            }
            else
            {
                try
                {
                    Directory.CreateDirectory(LogPath);
                    loggingDirectoryExists = true;
                }
                catch
                {
                }
            }
            return loggingDirectoryExists;
        }
        private string BuildLogLine(DateTime CurrentDateTime, string LogMessage)
        {
            StringBuilder loglineStringBuilder = new StringBuilder();
            loglineStringBuilder.Append(LogFileEntryDateTime(CurrentDateTime));
            loglineStringBuilder.Append(" \t");
            loglineStringBuilder.Append(LogMessage);
            return loglineStringBuilder.ToString();
        }
        public string LogFileEntryDateTime(DateTime CurrentDateTime)
        {
            return CurrentDateTime.ToString("dd-MM-yyyy HH:mm:ss");
        }
        private string LogFileName(DateTime CurrentDateTime)
        {
            return CurrentDateTime.ToString("dd_MM_yyyy");
        }


    }

}