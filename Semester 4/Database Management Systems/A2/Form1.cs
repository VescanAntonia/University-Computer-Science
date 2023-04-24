using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace A1
{
    public partial class Form1 : Form
    {
        private DataSet dataSet = new DataSet();
        private SqlConnection dbConnection;

        private SqlDataAdapter dataAdapterParent, dataAdapterChild;
        
        private readonly BindingSource bindingParent = new BindingSource();   
        private readonly BindingSource bindingChild = new BindingSource();

        
        public Form1()
        {
            InitializeComponent();
        }

        //private void ParentTable_Load()
        //{
        //    //parentTable.SelectionMode = DataGridViewSelectionMode.FullRowSelect;

        //    //// We take the select command and the parentTableName
        //    //string select = ConfigurationSettings.AppSettings["select"];
        //    //string parentTableName = ConfigurationSettings.AppSettings["ParentTableName"];

        //    //// We create the select command
        //    //daParent.SelectCommand = new SqlCommand(select, conn);

        //    //dset.Clear();
        //    //daParent.Fill(dset, parentTableName);
        //    //parentTable.DataSource = dset.Tables[parentTableName];
        //}
        void InitializeDatabase()
        {
            String connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            String database = ConfigurationManager.AppSettings["Database"];
            dbConnection = new SqlConnection(String.Format(connectionString, database));
            dataAdapterParent = new SqlDataAdapter(ConfigurationManager.AppSettings["SelectParent"], dbConnection);
            dataAdapterChild = new SqlDataAdapter(ConfigurationManager.AppSettings["SelectChild"], dbConnection);

            new SqlCommandBuilder(dataAdapterChild);
            new SqlCommandBuilder(dataAdapterParent).GetInsertCommand();

            dataAdapterParent.Fill(dataSet, ConfigurationManager.AppSettings["ParentTableName"]);
            dataAdapterChild.Fill(dataSet, ConfigurationManager.AppSettings["ChildTableName"]);

            var dataRelation = new DataRelation(
                ConfigurationManager.AppSettings["ForeignKey"],
                dataSet.Tables[ConfigurationManager.AppSettings["ParentTableName"]].Columns[ConfigurationManager.AppSettings["ParentReferencedKey"]],
                dataSet.Tables[ConfigurationManager.AppSettings["ChildTableName"]].Columns[ConfigurationManager.AppSettings["ChildForeignKey"]]);
            dataSet.Relations.Add(dataRelation);
        }
        

        private void InitializeUI()
        {
            bindingParent.DataSource = dataSet;
            bindingParent.DataMember = ConfigurationManager.AppSettings["ParentTableName"];

            bindingChild.DataSource = bindingParent;
            bindingChild.DataMember = ConfigurationManager.AppSettings["ForeignKey"];

            parentTable.DataSource = bindingParent;
            childTable.DataSource = bindingChild;
        }
        private void label1_Click(object sender, EventArgs e)
        {

        }


        private void Form1_Load(object sender, EventArgs e)
        {
            InitializeDatabase();
            InitializeUI();
        }


        //private void button2_Click(object sender, EventArgs e)
        //{
            
        //    //try
        //    //{
        //    //    dataAdapterChild.Update(dataSet, ConfigurationManager.AppSettings["ChildTableName"]);
        //    //    dataAdapterParent.Update(dataSet, ConfigurationManager.AppSettings["ParentTableName"]);


        //    //    //daProfiles.Update(dset, "Profiles");
        //    //    //MessageBox.Show("Updated succesfully!");
        //    //}
        //    //catch (Exception ex)
        //    //{
        //    //    MessageBox.Show(ex.Message);
        //    //}

        //}

        private void button1_Click(object sender, EventArgs e)
        {
            dataAdapterChild.Update(dataSet, ConfigurationManager.AppSettings["ChildTableName"]);
            dataAdapterParent.Update(dataSet, ConfigurationManager.AppSettings["ParentTableName"]);

        }

        //private void button2_Click_1(object sender, EventArgs e)
        //{
        //    dataSet.Tables[ConfigurationManager.AppSettings["ChildTableName"]].Clear();
        //    dataSet.Tables[ConfigurationManager.AppSettings["ParentTableName"]].Clear();
        //    dataAdapterParent.Fill(dataSet, ConfigurationManager.AppSettings["ParentTableName"]);
        //    dataAdapterChild.Fill(dataSet, ConfigurationManager.AppSettings["ChildTableName"]);

        //}

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        
    }
}
