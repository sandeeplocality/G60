using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace G60
{
	/*sample comment*/
    public class G60_Data
    {
        public DataTable get_database_name(string recSerialNumber)
        {
            try
            {
                string MyConnection2 = "datasource=localhost;Database=ug12_maindb;username=ug12server;password=87S6KetBWUYqBfWt";
                MySqlConnection MyConn2 = new MySqlConnection(MyConnection2);
                string Query1 = "SELECT schemalocation.schCode from account INNER JOIN recorderarchive on account.id=recorderarchive.account_id INNER JOIN schemalocation ON account.schemalocation_id=schemalocation.id where recorderarchive.recSerialNumber=" + recSerialNumber;
                MySqlCommand MyCommand3 = new MySqlCommand(Query1, MyConn2);
                MySqlDataAdapter MyAdapter = new MySqlDataAdapter();
                MyAdapter.SelectCommand = MyCommand3;
                DataTable dTable = new DataTable();
                MyAdapter.Fill(dTable);
                MyConn2.Close();
                return dTable;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}