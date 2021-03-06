﻿using System;
using System.Data.SqlClient;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class 입출금관리_정산처리 : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (인증회원 == null)
        {
            Session.Clear();
            Session.Abandon();
            FormsAuthentication.SignOut();
            Logout();
            Response.End();
            return;
        }
        KEY_AUTOREFRESH = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:자동갱신:";
        KEY_CACHEINFOS = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:검색정보들:";
        KEY_CACHEQUERY = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:검색질문식:";
        KEY_CACHESELINF = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:선택된정보:";
        KEY_CACHESORT = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:정돈항:";
        KEY_CACHESORTDIRECTION = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:정돈방향:";
        KEY_CACHEFILTER = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:검색인자들:";
        KEY_CACHECURPAGE = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:현재페지위치:";
        KEY_CACHEFIRSTDATE = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:첫날자:";
        KEY_CACHELASTDATE = "CACHE:NEWBACARA:본사:업체페지:입출금관리:정산처리:끝날자:";

        if (!IsPostBack)
        {
            검색질문식 = "";

            BindDataSource();
        }
    }

    public void BindDataSource()
    {
        if (검색정보들 != null)
        {
            검색정보들.Dispose();
            검색정보들 = null;
        }

        DBManager dbManager = new DBManager();
        DataSet dsResult = new DataSet();
        DataTable dt = new DataTable();
        dt.Columns.Add("Date");
        dt.Columns.Add("ChargeMoney", typeof(System.Int64));
        dt.Columns.Add("ChargeCount", typeof(System.Int64));
        dt.Columns.Add("WithdrawMoney", typeof(System.Int64));
        dt.Columns.Add("WithdrawCount", typeof(System.Int64));
        dt.Columns.Add("BenefitMoney", typeof(System.Int64));
        dt.Columns.Add("EnterpriseMoney", typeof(System.Int64));
        dsResult.Tables.Add(dt);

        for (DateTime date = 첫날자; date <= 끝날자; date = date.AddDays(1))
        {
            DataRow dr = dsResult.Tables[0].NewRow();
            dr["Date"] = date.ToString("yyyy-MM-dd");

            double nClassPercent = double.Parse(인증회원.Tables[0].Rows[0]["ClassPercent"].ToString());

            string strQuery = "SELECT SUM(TBL_Charge.money) AS ChargeMoney, COUNT(TBL_Charge.money) AS ChargeCount ";
            strQuery += "FROM TBL_Charge JOIN TBL_UserList ON TBL_Charge.UserID = TBL_UserList.ID ";
            strQuery += "WHERE TBL_Charge.Status>0 AND TBL_Charge.RegDate >= @StartDate AND TBL_Charge.RegDate <= @EndDate AND TBL_UserList.ParentID=" + 인증회원번호.ToString();
            SqlCommand cmd = new SqlCommand(strQuery);
            cmd.Parameters.Add(new SqlParameter("@StartDate", date));
            cmd.Parameters.Add(new SqlParameter("@EndDate", date.AddDays(1)));
            DataSet dsChargeList = dbManager.RunMSelectQuery(cmd);
            long nChargeMoney = 0;
            long nChargeCount = 0;
            if (dsChargeList.Tables.Count > 0 && dsChargeList.Tables[0].Rows.Count > 0)
            {
                nChargeMoney = dsChargeList.Tables[0].Rows[0]["ChargeMoney"] == DBNull.Value ? 0 : long.Parse(dsChargeList.Tables[0].Rows[0]["ChargeMoney"].ToString());
                nChargeCount = dsChargeList.Tables[0].Rows[0]["ChargeCount"] == DBNull.Value ? 0 : long.Parse(dsChargeList.Tables[0].Rows[0]["ChargeCount"].ToString());
            }

            strQuery = "SELECT SUM(TBL_Withdraw.money) AS WithdrawMoney, COUNT(TBL_Withdraw.money) AS WithdrawCount ";
            strQuery += "FROM TBL_Withdraw JOIN TBL_UserList ON TBL_Withdraw.UserID = TBL_UserList.ID ";
            strQuery += "WHERE TBL_Withdraw.Status>0 AND TBL_Withdraw.RegDate >= @StartDate AND TBL_Withdraw.RegDate <= @EndDate AND TBL_UserList.ParentID=" + 인증회원번호.ToString();
            cmd = new SqlCommand(strQuery);
            cmd.Parameters.Add(new SqlParameter("@StartDate", date));
            cmd.Parameters.Add(new SqlParameter("@EndDate", date.AddDays(1)));
            DataSet dsWithdrawList = dbManager.RunMSelectQuery(cmd);
            long nWithdrawMoney = 0;
            long nWithdrawCount = 0;
            if (dsWithdrawList.Tables.Count > 0 && dsWithdrawList.Tables[0].Rows.Count > 0)
            {
                nWithdrawMoney = dsWithdrawList.Tables[0].Rows[0]["WithdrawMoney"] == DBNull.Value ? 0 : long.Parse(dsWithdrawList.Tables[0].Rows[0]["WithdrawMoney"].ToString());
                nWithdrawCount = dsWithdrawList.Tables[0].Rows[0]["WithdrawCount"] == DBNull.Value ? 0 : long.Parse(dsWithdrawList.Tables[0].Rows[0]["WithdrawCount"].ToString());
            }

            dr["ChargeMoney"] = nChargeMoney;
            dr["ChargeCount"] = nChargeCount;
            dr["WithdrawMoney"] = nWithdrawMoney;
            dr["WithdrawCount"] = nWithdrawCount;
            dr["BenefitMoney"] = nChargeMoney - nWithdrawMoney;
            dr["EnterpriseMoney"] = (nChargeMoney - nWithdrawMoney) * nClassPercent / 100;
            dsResult.Tables[0].Rows.Add(dr);
        }
        검색정보들 = dsResult;
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        UpdateButton();
        GridDataBind();
    }

    void GridDataBind()
    {
        if (검색정보들 == null)
        {
            BindDataSource();
        }
        DataSet src = 검색정보얻기(검색질문식);
        if (src != null)
        {
            DataView dv = src.Tables[0].DefaultView;
            grdList.DataSource = dv;
        }
        else
        {
            grdList.DataSource = null;
        }
        //grdList.PageSize = 페지당현시개수;
        grdList.PageIndex = 현재페지위치;
        grdList.DataBind();
        // 합계계산
        if (검색정보들 != null && grdList.FooterRow != null)
        {
            grdList.FooterRow.Cells[0].Text = "합계";
            long chargeSum = 0;
            long chargeCount = 0;
            long withdrawSum = 0;
            long withdrawCount = 0;
            long benefitSum = 0;
            long enterpriseMoney = 0;
            for (int i = 0; i < 검색정보들.Tables[0].Rows.Count; i++)
            {
                chargeSum += Convert.ToInt64(검색정보들.Tables[0].Rows[i]["ChargeMoney"] == DBNull.Value ? 0 : 검색정보들.Tables[0].Rows[i]["ChargeMoney"]);
                chargeCount += Convert.ToInt64(검색정보들.Tables[0].Rows[i]["ChargeCount"] == DBNull.Value ? 0 : 검색정보들.Tables[0].Rows[i]["ChargeCount"]);
                withdrawSum += Convert.ToInt64(검색정보들.Tables[0].Rows[i]["WithdrawMoney"] == DBNull.Value ? 0 : 검색정보들.Tables[0].Rows[i]["WithdrawMoney"]);
                withdrawCount += Convert.ToInt64(검색정보들.Tables[0].Rows[i]["WithdrawCount"] == DBNull.Value ? 0 : 검색정보들.Tables[0].Rows[i]["WithdrawCount"]);
                benefitSum += Convert.ToInt64(검색정보들.Tables[0].Rows[i]["BenefitMoney"] == DBNull.Value ? 0 : 검색정보들.Tables[0].Rows[i]["BenefitMoney"]);
                enterpriseMoney += Convert.ToInt64(검색정보들.Tables[0].Rows[i]["EnterpriseMoney"] == DBNull.Value ? 0 : 검색정보들.Tables[0].Rows[i]["EnterpriseMoney"]);
            }
            grdList.FooterRow.Cells[1].Text = chargeSum.ToString("N0") + "";
            grdList.FooterRow.Cells[2].Text = chargeCount.ToString("N0") + "회";
            grdList.FooterRow.Cells[3].Text = withdrawSum.ToString("N0") + "";
            grdList.FooterRow.Cells[4].Text = withdrawCount.ToString("N0") + "회";
            grdList.FooterRow.Cells[5].Text = benefitSum.ToString("N0") + "";
            grdList.FooterRow.Cells[6].Text = enterpriseMoney.ToString("N0") + "";
        }
    }
    void UpdateButton()
    {
        tbxStartDate.Text = 첫날자.ToString("yyyy-MM-dd");
        tbxEndDate.Text = 끝날자.ToString("yyyy-MM-dd");
    }

    #region 그리드사건처리부
    protected void grdLisTBL_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header ||
            e.Row.RowType == DataControlRowType.Footer ||
            e.Row.RowType == DataControlRowType.Pager ||
            e.Row.RowType == DataControlRowType.Separator)
            return;
    }

    protected void grdLisTBL_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        현재페지위치 = e.NewPageIndex;
    }
    #endregion

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (tbxStartDate.Text != "" && tbxEndDate.Text != "")
        {
            첫날자 = DateTime.Parse(tbxStartDate.Text + " 00:00:00");
            끝날자 = DateTime.Parse(tbxEndDate.Text + " 23:59:59");
            BindDataSource();
        }
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        검색질문식 = "";
        BindDataSource();
    }
    protected void btnViewByUser_Click(object sender, EventArgs e)
    {
        Response.Redirect("회원별정산.aspx");
    }
    protected void btnDay_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        if (btn == null) return;
        int nDay = -1 * int.Parse(btn.CommandArgument);
        첫날자 = DateTime.Today.AddDays(nDay);
        끝날자 = DateTime.Today.AddDays(nDay + 1).AddSeconds(-1);

        btn.ForeColor = System.Drawing.Color.White;
        btn.BackColor = System.Drawing.Color.Red;
        BindDataSource();
    }
}
