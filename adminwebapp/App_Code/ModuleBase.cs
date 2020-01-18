//////////////////////////////////////////////////////////////////
// Copyright (C) 2003-2004 GPSH WR, Inc.
// All rights reserved.
//
//////////////////////////////////////////////////////////////////

using System;
using System.IO;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Xml;

public enum ��ڻ������
{ 
    �������,
    �κ������,
    ���ǻ���,
    �������
}

/// <summary>
/// Summary description for PageBase.
/// </summary>
public class ModuleBase : System.Web.UI.MasterPage
{
    public static string KEY_CACHEUSER = PageBase.KEY_CACHEUSER;
    public static string KEY_CACHEALARM = PageBase.KEY_CACHEALARM;

    public ModuleBase()
    {
        try
        {
            //if (GoldenConfiguration.EnableSsl)
            //{
            //    string szPath = Context.Request.Url.ToString().ToLower();
            //    // URL�� "/Secure/", "/UserMngSys/"�� ������ https����� �ϰ� �Ͽ��ְ� 
            //    // �׷��� ������  http�� �ּҺ�ȯ�Ѵ�.
            //    if ((szPath.IndexOf("/secure/") > -1))
            //    {
            //        if (!Context.Request.IsSecureConnection)
            //        {
            //            //Context.Response.Redirect(szPath.Replace("http:", "https:"), true);
            //            Context.Response.Redirect(szPath.Insert(4, "s"));
            //        }
            //    }
            //    else
            //    {
            //        if (Context.Request.IsSecureConnection)
            //            Context.Response.Redirect(szPath.Replace("https:", "http:"), true);
            //    }
            //}
        }
        catch
        {
            // for design time
        }
    }

    /// <summary>
    ///		Ȯ�ε� ȸ���� ���� �ڷḦ ó��(����/���)�Ѵ�.
    ///		<remark>��ǿ� �����ȴ�.</remark>
    /// </summary>
    public DataSet ����ȸ��
    {
        get
        {
            DataSet ds = null;
            try
            {
                ds = (DataSet)Session[KEY_CACHEUSER];
            }
            catch
            {
            }

            return ds;
        }
        set
        {
            if (value == null)
                Session.Remove(KEY_CACHEUSER);
            else
                Session[KEY_CACHEUSER] = value;
        }
    }

    /// <summary>
    ///		�˶��� �︱ ������ �����Ѵ�. 
    ///		<remark>��ǿ� �����ȴ�.</remark>
    ///		<remark>1:1�Խ���, ����, ȯ��ü��鿡�� �̿��Ѵ�.</remark>
    /// </summary>
    public string �˶�������
    {
        get
        {
            try
            {
                return Session[KEY_CACHEALARM].ToString();
            }
            catch
            {
                return "";
            }
        }
        set
        {
            if (value == null)
                Session.Remove(KEY_CACHEALARM);
            else
                Session[KEY_CACHEALARM] = value;
        }
    }

    /// <summary>
    ///		Ȯ�ε� ȸ���� ������ ���ǵ� ���ѹ����ȿ� �ִ°� ���°��� �����Ѵ�.
    /// </summary>
    /// <param name="szRoles">���ǵ� ���ѹ���</param>
    /// <returns>������ tru; ������ false</returns>
    public virtual bool User_IsInRoles(string szRoles)
    {
        //if (����ȸ�� == null) return false;
        //string UserRole = (string)(����ȸ��.Tables[0].Rows[0][ȸ���ڷ�.����]);
        //return ((UserRole != "") && (szRoles.IndexOf("#" + UserRole + "#") >= 0));
        return true;
    }

    public void ShowMessageBox(string strMsg, string strUrl)
    {
        Response.Write("<script>alert('" + strMsg + "');location.href='" + strUrl + "';</script>");
    }

    public void ShowMessageBox(string strMsg)
    {
        Response.Write("<script>alert('" + strMsg + "');</script>");
    }
}
