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

namespace A1
{
    public partial class Form1 : Form
    {
        SqlConnection conn;
        SqlDataAdapter daAccounts;
        SqlDataAdapter daProfiles;
        DataSet dset;
        BindingSource bsAccounts;
        BindingSource bsProfiles;

        SqlCommandBuilder cmdBuilder;

        string queryAccounts;
        string queryProfiles;
        public Form1()
        {
            InitializeComponent();
            FillData();
        }
        void FillData()
        {
            conn = new SqlConnection(getConnectionString());
            queryAccounts = "SELECT * FROM Accounts";
            queryProfiles = "SELECT * FROM Profiles";
            //for parent table and child table
            daAccounts = new SqlDataAdapter(queryAccounts, conn);
            daProfiles = new SqlDataAdapter(queryProfiles, conn);
            dset = new DataSet();
            daAccounts.Fill(dset, "Accounts");
            daProfiles.Fill(dset, "Profiles");

            //fill in insert update and delete
            cmdBuilder = new SqlCommandBuilder(daProfiles);
            cmdBuilder = new SqlCommandBuilder(daAccounts);

            //DataRelation(parent-child relationship added to the dset)
            dset.Relations.Add("AccountsProfiles",
                dset.Tables["Accounts"].Columns["id"],
                dset.Tables["Profiles"].Columns["account_id"]);
            //fill the data into the DataGridViews
            /*this.dataGridView1.DataSource = dset.Tables["Accounts"];
            this.dataGridView2.DataSource = this.dataGridView1.DataSource;
            this.dataGridView2.DataMember = "AccountsProfiles";*/

            bsAccounts = new BindingSource();
            bsAccounts.DataSource = dset.Tables["Accounts"];
            bsProfiles = new BindingSource(bsAccounts, "AccountsProfiles");
            this.dataGridView1.DataSource = bsAccounts;
            this.dataGridView2.DataSource = bsProfiles;
        }
        string getConnectionString()
        {
            return "Data Source=DESKTOP-E1SO1HG\\SQLEXPRESS;" +
                "Initial Catalog=Netflix;Integrated Security=true";
        }
        private void label1_Click(object sender, EventArgs e)
        {

        }


        private void Form1_Load(object sender, EventArgs e)
        {

        }


        private void button2_Click(object sender, EventArgs e)
        {
            
            try
            {
                daProfiles.Update(dset, "Profiles");
                MessageBox.Show("Updated succesfully!");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        
    }
}
