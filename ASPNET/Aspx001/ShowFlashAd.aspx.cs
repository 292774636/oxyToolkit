using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class Page_Function_showflashad : System.Web.UI.Page
{
    public int Pics_Width = 240;
    public int Pics_Height = 180;
    public int Texts_Height = 18;
    public int Swf_Height;
    public string Pics;
    public string Links;
    public string Texts;
    public void Page_Load(object sender, EventArgs e)
    {
        //链接数据库，并获取数据库中FlashAD表中的数据 
        SqlConnection objConn = new SqlConnection();
        objConn.ConnectionString = ConfigurationManager.ConnectionStrings["yntvuConnectionString"].ConnectionString;
        objConn.Open();
        SqlCommand objCmd = new SqlCommand();
        objCmd.Connection = objConn;
        objCmd.CommandText = "Select Top 6 * From FlashAdPic Where IsShow='1' and IsDel='0'";
        SqlDataReader objReader = objCmd.ExecuteReader();
        //将查询结果保存到数组变量中，并进行调用 
        string[] imgPics = new string[6];
        string[] imgTexts = new string[6];
        string[] imgLinks = new string[6];
        int i;
        for (i = 0; i < 6; i++)
        {
            objReader.Read();
            imgPics = objReader["Pics"].ToString();
            imgLinks = objReader["Links"].ToString();
            imgTexts = objReader["Texts"].ToString();
            Pics = i == 5 ? Pics = Pics + imgPics : Pics + imgPics + "|";
            Links = i == 5 ? Links = Links + imgLinks : Links + imgLinks + "|";
            Texts = i == 5 ? Texts = Texts + imgTexts : Texts + imgTexts + "|";
        }
        objConn.Close();
        Swf_Height = Pics_Height + Texts_Height;
    }
}
