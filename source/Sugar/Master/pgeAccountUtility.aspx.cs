﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net.Mime;
using System.Configuration;
using System.Threading;
using System.Globalization;

public partial class Sugar_Master_pgeAccountUtility : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand cmd = null;
    SqlTransaction myTran = null;
    string cs = string.Empty;
    string qryCommon = string.Empty;
    int PageSize;
    protected void Page_Load(object sender, EventArgs e)
    {
        qryCommon = "qrymstaccountmaster";
        cs = ConfigurationManager.ConnectionStrings["sqlconnection"].ConnectionString;
        con = new SqlConnection(cs);
        if (!IsPostBack)
        {
            BindDummyRow();
        }
        SetFocus(btnAdd);
    }

    private void BindDummyRow()
    {
        DataTable dummy = new DataTable();
        dummy.Columns.Add("Ac_Code");
        dummy.Columns.Add("Ac_Name_E");
        dummy.Columns.Add("Short_Name");
        dummy.Columns.Add("cityname");
        dummy.Columns.Add("citygststatecode");
        dummy.Columns.Add("Gst_No");
        dummy.Columns.Add("Address_E");
        dummy.Columns.Add("Address_R");
        dummy.Columns.Add("Mobile_No");
        dummy.Columns.Add("accoid");
        dummy.Rows.Add();
        gvCustomers.DataSource = dummy;
        gvCustomers.DataBind();


    }

    [WebMethod]
    public static string GetCustomers(string searchTerm, int pageIndex, string Trantype, int PageSize, int Company_Code)
    {

        string searchtxt = "";
        string delimStr = "";
        char[] delimiter = delimStr.ToCharArray();
        string words = "";
        string[] split = null;
        string name = string.Empty;

        searchtxt = searchTerm;
        words = searchTerm;
        split = words.Split(delimiter);
        foreach (var s in split)
        {
            string aa = s.ToString();
            // name += "Doc_No Like '%" + aa + "%'or";
            // name += "( Ac_Code like '%" + aa + "%' or Ac_Name_E like '%" + aa + "%' or Address_E like '%" + aa + "%' ) and";
            name += "( Ac_Name_E like '%" + aa + "%' or cityname like '%" + aa + "%' or Address_E like '%" + aa + "%' or Ac_Code like '%" + aa + "%' or citygststatecode like '%" + aa + "%' or Gst_No like '%" + aa + "%' or accoid like '%" + aa + "%' or Mobile_No like '%" + aa + "%' or Short_Name like '%" + aa + "%' or Address_R like '%" + aa + "%') and";


        }
        name = name.Remove(name.Length - 3);
        //string query = "SELECT ROW_NUMBER() OVER ( order by DOC_NO ASC) AS RowNumber,DOC_NO as CustomerID,Ac_Name_E as ContactName,"
        //+ "AMOUNT ,TRAN_TYPE as City FROM qryGledgernew where " + name + "";
        string query = string.Empty;
        if (Trantype != "A")
        {
            query = "SELECT ROW_NUMBER() OVER ( order by Ac_Code ASC) AS RowNumber,Ac_Code,Ac_Name_E,Short_Name,"
          + "cityname ,citygststatecode,upper(Gst_No) as Gst_No,Address_E,Address_R,Mobile_No,accoid FROM qrymstaccountmaster where Company_Code='" +
          Company_Code + "' and Ac_type='" + Trantype + "' and " + name + "  order by Ac_Code desc ";
        }
        else
        {
            query = "SELECT ROW_NUMBER() OVER ( order by Ac_Code ASC) AS RowNumber,Ac_Code,Ac_Name_E,Short_Name,"
         + "cityname ,citygststatecode,upper(Gst_No) as Gst_No,Address_E,Address_R,Mobile_No,accoid FROM qrymstaccountmaster where Company_Code='" +
         Company_Code + "'  and " + name + "  order by Ac_Code desc ";
        }

        SqlCommand cmd = new SqlCommand(query);
        cmd.CommandType = CommandType.Text;
        return GetData(cmd, pageIndex, PageSize).GetXml();



    }
    private static DataSet GetData(SqlCommand cmd, int pageIndex, int PageSize)
    {
        string RecordCount = "";
        string cs1 = ConfigurationManager.ConnectionStrings["sqlconnection"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs1))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {

                cmd.Connection = con;
                sda.SelectCommand = cmd;
                DataSet dsreturn = new DataSet();
                using (DataSet ds = new DataSet())
                {
                    sda.Fill(ds);
                    int number = 1;
                    DataTable dtnew = new DataTable();
                    dtnew = ds.Tables[0];
                    for (int i = 0; i < dtnew.Rows.Count; i++)
                    {
                        dtnew.Rows[i][0] = number;
                        number = number + 1;

                    }
                    string f1 = " RowNumber >=(" + pageIndex + " -1) * (" + PageSize + "+1) and RowNumber<=";
                    string f2 = "(((" + pageIndex + " -1) * " + PageSize + " +1) +" + PageSize + ")-1";

                    DataRow[] results = dtnew.Select(f1 + f2, "Ac_Code desc");
                    if (results.Count() > 0)
                    {
                        DataTable dt1 = results.CopyToDataTable();


                        dt1.TableName = "Customers";
                        DataTable dt = new DataTable("Pager");
                        dt.Columns.Add("PageIndex");
                        dt.Columns.Add("PageSize");
                        dt.Columns.Add("RecordCount");
                        dt.Rows.Add();
                        RecordCount = ds.Tables[0].Rows.Count.ToString();

                        dt.Rows[0]["PageIndex"] = pageIndex;
                        dt.Rows[0]["PageSize"] = PageSize;
                        dt.Rows[0]["RecordCount"] = RecordCount;

                        dsreturn = new DataSet();
                        dsreturn.Tables.Add(dt1);
                        dsreturn.Tables.Add(dt);
                        return dsreturn;
                    }
                    else
                    {
                        return dsreturn;
                    }

                }
            }
        }
    }



    protected void btnAdd_Click(object sender, EventArgs e)
    {
        // DataSet ds = new DataSet();
        // DataTable dt = new DataTable();
        // string qry = string.Empty;
        // qry = " select Ac_Code,Ac_Name_E,"
        //+ "cityname ,citygststatecode,Gst_No,group_Name_E,Mobile_No,accoid FROM " + qryCommon + " limit 15";
        // ds = clsDAL.SimpleQuery(qry);
        // if (ds != null)
        // {
        //     dt = ds.Tables[0];
        //     if (dt.Rows.Count > 0)
        //     {
        //         gvCustomers.DataSource = dt;
        //         gvCustomers.DataBind();
        //         ViewState["currentTable"] = dt;
        //     }
        // }
        // else
        // {
        //     gvCustomers.DataSource = null;
        //     gvCustomers.DataBind();
        //     ViewState["currentTable"] = null;
        // }
    }
}