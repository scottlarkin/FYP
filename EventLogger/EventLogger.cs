using System;
using System.Diagnostics;

namespace EventLogger
{

    public class EventLogger
    {

        private string source;
        private string log;

        public EventLogger(string Source, string Log)
        {
            source = Source;
            log = Log;

            if (!EventLog.SourceExists(Source))
                EventLog.CreateEventSource(Source, Log);
        }

        public void Write(string Message, EventLogEntryType Type)
        {
            EventLog.WriteEntry(source, Message, Type);
        }

        public void WriteException(Exception e)
        {
            Write("Message: " + e.Message + "........ Source:" + e.Source + "........ Stack Trace:" + e.StackTrace, System.Diagnostics.EventLogEntryType.Error);
        }
    }
}
