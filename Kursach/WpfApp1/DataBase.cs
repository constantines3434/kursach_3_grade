using System.Data.SqlClient;
using System.Windows;


namespace WpfApp1
{/// <summary>
 /// подключени базы к c# с методами
 /// </summary>
    internal class DataBase
    {
        SqlConnection sqlConnection = new SqlConnection(@"Data Source=WIN-OMJN02Q49QC; Initial Catalog=Base; Integrated Security=True");

        public string StringCon()
        {
            return @"Data Source=WIN-OMJN02Q49QC; Initial Catalog=Base; Integrated Security=True";
        }
        public SqlDataAdapter queryExecute(string query)
        {
            try
            {
                SqlConnection myCon = new SqlConnection(StringCon());
                myCon.Open();

                SqlDataAdapter SDA = new SqlDataAdapter(query, myCon);

                SDA.SelectCommand.ExecuteNonQuery();
                MessageBox.Show("Действие успешно выполнено!", "Успех");
                return SDA;
            }
            catch
            {
                MessageBox.Show("Возникла ошибка при выполнении запроса.", "Ошибка");
                return null;
            }
        }

        public void openConnection()
        {
            if (sqlConnection.State == System.Data.ConnectionState.Closed)
            {
                sqlConnection.Open();
            }
        }

        public void closeConnection()
        {
            if (sqlConnection.State == System.Data.ConnectionState.Open)
            {
                sqlConnection.Close();
            }
        }

        public SqlConnection getConnection()
        {
            return sqlConnection;
        }
    }
}


