﻿<%@ Page Language="C#" MasterPageFile="회원관리.master" AutoEventWireup="true" CodeFile="부본사목록.aspx.cs" Inherits="회원관리_부본사목록" Title="코리아 게임 관리자페이지" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Subhead" Runat="Server">
    <style>
        a
        {
        	font-size:9pt;
        }
        span
        {
        	font-size:9pt;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlaceHolder" Runat="Server">
    <table cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <img src="../../Images/ico_sysTit1.gif" />
            </td>
            <td width="7px" nowrap>
            </td>
            <td class="clsSysTitle">
                <h5>부본사관리</h5>
            </td>
        </tr>
    </table>
    
    <script type="text/javascript">
     $(function() {
         $('select').selectlist({
             zIndex: 10,
             width: 120,
             height: 27
         });
     })
</script>
    <!-- 타이틀밑의 두선 -->
    <table cellpadding="0" border="1" bordercolor="#E7E3E7" cellspacing="0" class="clsLineTable">
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div class='PageToolBar'>
        <table width="100%" border="0" cellpadding="7" cellspacing="1">
            <tr valign="middle">
                <td width="10%" class="srcTit" nowrap>
                            &nbsp;<i class="fa fa-circle-o" ></i>
                             &nbsp;결과&nbsp;: 총
                    [<asp:Label ID="lblRowCount" runat="server"></asp:Label>]건
                </td>
                <td>
                사용여부:&nbsp;
                <asp:DropDownList ID="ddlUseYn" runat="server">
                    <asp:ListItem Value="1">사용</asp:ListItem>
                    <asp:ListItem Value="0">금지</asp:ListItem>
                    <asp:ListItem Value="">전체</asp:ListItem>                    
                </asp:DropDownList>                
                </td>
                <!--
                <td>
                <asp:Label ID="lblBillKind" Text="정산유형" runat="server"></asp:Label>:
                <asp:DropDownList ID="ddlBillKind" runat="server">
                    <asp:ListItem Value="" Selected="True">전체</asp:ListItem>
                    <asp:ListItem Value="GAME">로링식</asp:ListItem>
                    <asp:ListItem Value="CHARGE">입출식</asp:ListItem>
                </asp:DropDownList>
                </td>
                -->
                <td>
                부본사사명:
                <asp:TextBox ID="tbxName" MaxLength="20" runat="server"></asp:TextBox>
                </td>
                <td>
                <asp:Button ID="btnSearch" Text="검색" class="btn btn-danger" runat="server" OnClick="btnSearch_Click"/>
                </td>
                <td width=30%>
               
                </td>
                <!--
                <td align="right" nowrap>
                    <asp:Label ID="lblSortExpr" runat="server" CssClass="clsLabelE" Font-Size="10pt"
                        Height="11px">정돈 안함</asp:Label>
                    <asp:Panel ID="pnlAscSortLbl" Wrap="False" runat="server" CssClass="clsSortPanel"
                        Visible="False">
                        <table class="clsSortPanel" id="tblAscSortLbl" cellspacing="0" cellpadding="0" width="10"
                            align="center" border="0">
                            <tr>
                                <td valign="bottom">
                                    A
                                </td>
                                <td style="font-size: 12pt" valign="top" rowspan="2">
                                    ↓
                                </td>
                            </tr>
                            <tr>
                                <td style="color: red" valign="top">
                                    Z
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="pnlDescSortLbl" Wrap="False" runat="server" CssClass="clsSortPanel"
                        Visible="False">
                        <table class="clsSortPanel" id="tblDescSortLbl" cellspacing="0" cellpadding="0" width="10"
                            align="center" border="0">
                            <tr>
                                <td style="color: red" valign="bottom">
                                    Z
                                </td>
                                <td style="font-size: 11pt" valign="middle" rowspan="2">
                                    ↓
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    A
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Label ID="lblTrialSortExpr" runat="server" CssClass="clsLabelE" Font-Size=10pt>&nbsp;로 정돈</asp:Label>
                </td>
            </tr>
            -->
            
        </table>
    </div>
    <asp:GridView ID="grdList" runat="server" AutoGenerateColumns="False" 
        Width=100% AllowPaging="True" DataKeyNames="ID" AllowSorting="True" 
        onpageindexchanging="grdLisTBL_PageIndexChanging" PageSize=20
        onrowdatabound="grdLisTBL_RowDataBound" OnRowDeleting="grdLisTBL_RowDeleting" 
        onsorting="grdLisTBL_Sorting" EmptyDataText="검색된 자료가 없습니다."  
        >
        <RowStyle CssClass="GridRow" />
        <Columns>
            <asp:TemplateField HeaderText="번호" SortExpression="ID">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkNo" runat="server" CommandArgument='<%# Eval("ID") %>'></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle CssClass="GridItem" Width="30px" Wrap=false HorizontalAlign=Center />
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText="부본사사명" SortExpression="Name" >
                <ItemStyle CssClass="GridItem" Wrap=false HorizontalAlign=Center />
            </asp:BoundField>
            <asp:TemplateField HeaderText="유형" SortExpression="bill_kind" ShowHeader="False" Visible=false>
                <ItemTemplate>
                    <asp:Label ID="lblBill" Width="100" runat="server" Text='<%# Eval("bill_kind").ToString().Equals("GAME") ? "로링" : "입출금" %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="GridItem" Width="30px" Wrap=false HorizontalAlign=Center />
            </asp:TemplateField>
            <asp:BoundField DataField="money" DataFormatString="{0:N0}원" HeaderText="업체머니" 
                SortExpression="money" >
                <ItemStyle CssClass="GridItem" HorizontalAlign="Right" Wrap=false />
            </asp:BoundField>
            <asp:BoundField DataField="LoginID" HeaderText="아이디" SortExpression="LoginID" >
                <ItemStyle CssClass="GridItem" Wrap=false />
            </asp:BoundField>
            <asp:BoundField DataField="LoginPWD" HeaderText="암호" SortExpression="LoginPWD" >
                <ItemStyle CssClass="GridItem" Wrap=false />
            </asp:BoundField>
          
            <asp:BoundField DataField="Partner" HeaderText="파트너코드" SortExpression="Partner" >
                <ItemStyle CssClass="GridItem" Wrap=false HorizontalAlign=Center />
            </asp:BoundField>
            
            <asp:TemplateField HeaderText="사용여부" SortExpression="use_yn">
                <ItemTemplate>
                    <asp:Label ID="lblUseYn" runat="server" Text='<%# (Eval("use_yn").ToString().Equals("1") ? "사용" : "금지") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="GridItem" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="ClassPercent" DataFormatString="{0:N1}%" HeaderText="업체지분율" SortExpression="ClassPercent" >
                <ItemStyle CssClass="GridItem" Wrap=false HorizontalAlign=Center />
            </asp:BoundField>
            <asp:TemplateField HeaderText="등록날자" SortExpression="RegDate">
                <ItemTemplate>
                    <asp:Label ID="lblRegDate" runat="server" Text='<%# ((DateTime)Eval("RegDate")).ToString("yyyy-MM-dd") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="GridItem" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False" Visible=false>
                <ItemTemplate>
                    <asp:HyperLink ID="lnkViewSub" NavigateUrl='<%# "총판목록.aspx?parentid=" + Eval("ID").ToString() %>' runat="server" CausesValidation="False"
                        Text="하위보기"></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" CssClass="GridCommandButton" />
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkEdit" NavigateUrl='<%# "부본사등록.aspx?id=" + Eval("ID").ToString() %>' runat="server" CausesValidation="False"
                        Text="수정"></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" CssClass="GridCommandButton" />
            </asp:TemplateField>
            
            
        </Columns>
        <FooterStyle BackColor="White" Font-Bold="True" ForeColor="#858585" />
        <PagerStyle HorizontalAlign="Center" CssClass="clsButton" />
        <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" />
        <HeaderStyle CssClass="GridHeader" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="#ecf8ff" />
    </asp:GridView>
    <asp:Panel ID="pnlListBar" runat="server" CssClass="clsControlBar">
        <asp:Button ID="btnNew" runat="server" class="btn btn-info" Text="새로등록" onclick="btnNew_Click" />
        <asp:Button ID="btnRefresh" runat="server" class="btn btn-warning" Text="목록새로고침" />
    </asp:Panel>
</asp:Content>

