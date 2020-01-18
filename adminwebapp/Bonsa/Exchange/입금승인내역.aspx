﻿<%@ Page Language="C#" MasterPageFile="../Exchange/입출금관리.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="입금승인내역.aspx.cs" Inherits="입출금관리_입금승인내역" Title="코리아 게임 관리자페이지" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Subhead" Runat="Server">
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
                <h5>회원입금승인내역</h5>
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
                 <td width="10%" class="srcTit" nowrap >
                   <i class="fa fa-circle-o" ></i>
                    &nbsp;결과&nbsp;: 총
                    [<asp:Label ID="lblRowCount" runat="server"></asp:Label>]건 
                </td>
                <td class="srcTit" nowrap>
                    &nbsp;<img src="../../Images/ico_sqr02.gif" width="3" height="3" align="absmiddle">
                    &nbsp;&nbsp;<asp:DropDownList ID="ddlSearchKey" runat="server">
                        <asp:ListItem Value="LoginID">회원ID</asp:ListItem>
                        <asp:ListItem Value="NickName">닉네임</asp:ListItem>
                        <asp:ListItem Value="BankName">예금주명</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="tbxSearchValue" runat="server" CssClass="clsEdit" 
                        OnTextChanged="btnSearch_Click" Width="100px"></asp:TextBox>
                </td>
                <td class="srcTit" nowrap>
                    &nbsp;<img src="../../Images/ico_sqr02.gif" width="3" height="3" align="absmiddle">&nbsp;
                    날자:
                    <asp:TextBox ID="tbxStartDate" runat="server" CssClass="clsEdit" 
                        Width="80px" onclick="Calendar(this)" ></asp:TextBox>
                    부터&nbsp;&nbsp;<asp:TextBox ID="tbxEndDate" runat="server" CssClass="clsEdit"
                        Width="80px" onclick="Calendar(this)"></asp:TextBox>
                    까지
                </td>
                <td>
                    <asp:Button ID="btnSearch" runat="server" Text="검색" class="btn btn-danger" OnClick="btnSearch_Click" />
                </td>
                <td width="50%" align="left">
                    <asp:Button ID="btnExcel" runat="server" Text="Excel출력" CssClass="clsButton" OnClick="btnExcel_OnClick" />
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
                                <td valign="bottom">A</td>
                                <td style="font-size: 12pt" valign="top" rowspan="2">↓</td>
                            </tr>
                            <tr>
                                <td style="color: red" valign="top">Z</td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="pnlDescSortLbl" Wrap="False" runat="server" CssClass="clsSortPanel"
                        Visible="False">
                        <table class="clsSortPanel" id="tblDescSortLbl" cellspacing="0" cellpadding="0" width="10"
                            align="center" border="0">
                            <tr>
                                <td style="color: red" valign="bottom">Z</td>
                                <td style="font-size: 11pt" valign="middle" rowspan="2">↓</td>
                            </tr>
                            <tr>
                                <td valign="top">A</td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Label ID="lblTrialSortExpr" runat="server" CssClass="clsLabelE" Height="11px">&nbsp;로 정돈</asp:Label>
                </td>
                -->
                
            </tr>
            <tr>
                <td class="srcTit" nowrap>
                    &nbsp;<img src="../../Images/ico_sqr02.gif" width="3" height="3" align="absmiddle">
                    &nbsp;업체선택 
                </td>
                <td colspan=8>
                    <asp:DropDownList ID="ddlBonsa" runat="server" AutoPostBack="True" 
                        onselectedindexchanged="ddlBonsa_SelectedIndexChanged" Width="80px">
                    </asp:DropDownList>
                    &nbsp;<asp:DropDownList ID="ddlBubonsa" runat="server" AutoPostBack="True" 
                        onselectedindexchanged="ddlBubonsa_SelectedIndexChanged" Width="80px">
                    </asp:DropDownList>
                    &nbsp;<asp:DropDownList ID="ddlChongPan" runat="server" AutoPostBack="True" Visible="false"
                         Width="80px" onselectedindexchanged="ddlChongPan_SelectedIndexChanged">
                    </asp:DropDownList>
                    &nbsp;<asp:DropDownList ID="ddlMaejang" runat="server" AutoPostBack="True" Visible="false" 
                         Width="80px" onselectedindexchanged="ddlMaejang_SelectedIndexChanged">
                    </asp:DropDownList>
                    
                    
                   
                    <img src="../../Images/ico_sqr02.gif" width="3" height="3" align="absmiddle">
                    &nbsp;입금유형
                   
                    <asp:DropDownList ID="ddlChargeType" runat="server">
                        <asp:ListItem Value="">전체</asp:ListItem>
                        <asp:ListItem Value="1">회원입금</asp:ListItem>
                        <asp:ListItem Value="2">관리자입금</asp:ListItem>
                    </asp:DropDownList>
                    
                </td>
                
               
            </tr>
        </table>
    </div>
    <asp:GridView ID="grdList" runat="server" AutoGenerateColumns="False" 
        Width=100% AllowPaging="True" DataKeyNames="ID" AllowSorting="True" 
        onpageindexchanging="grdLisTBL_PageIndexChanging" ShowFooter="true"
        onrowdatabound="grdLisTBL_RowDataBound" OnRowDeleting="grdLisTBL_RowDeleting" 
        onsorting="grdLisTBL_Sorting" EmptyDataText="검색된 자료가 없습니다."  
        >
        <RowStyle CssClass="GridRow" />
        <PagerSettings Mode="NumericFirstLast" />
        <Columns>
            <asp:TemplateField HeaderText="번호">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkNo" CommandName="Select" CommandArgument='<%# Bind("ID") %>' ToolTip='<%# Bind("UserID") %>' 
                        runat="server"></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" CssClass="GridCommandButton" Width=40px />
            </asp:TemplateField>
            <asp:BoundField DataField="LoginID" HeaderText="아이디" SortExpression="LoginID" >
                <ItemStyle HorizontalAlign="center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="닉네임" SortExpression="NickName">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkViewDetail" Text='<%# Eval("NickName") %>'  NavigateUrl='<%# "../User/회원이력정보.aspx?id=" + Eval("UserID").ToString() + "&ReturnUrl=" + Request.Path %>' runat="server" CausesValidation="False"></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" CssClass="GridCommandButton" />
            </asp:TemplateField>
            <asp:BoundField DataField="DepositHolder" HeaderText="입금자명" SortExpression="DepositHolder" NullDisplayText="-">
                <ItemStyle CssClass="GridItem" Wrap=false HorizontalAlign=Center />
            </asp:BoundField>
            <asp:BoundField DataField="EntName" HeaderText="부본사" SortExpression="EntName" NullDisplayText="-">
                <ItemStyle CssClass="GridItem" Wrap=false HorizontalAlign=Center />
            </asp:BoundField>
            <asp:BoundField DataField="money" HeaderText="요청금액" SortExpression="money" DataFormatString="{0:N0}">
                <ItemStyle HorizontalAlign="right" />
                <FooterStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="regdate" HeaderText="요청시간" SortExpression="regdate" DataFormatString="{0:yyyy-MM-dd HH:mm}">
                <ItemStyle HorizontalAlign="Center" Width="120px" Wrap=false />
            </asp:BoundField>
            <asp:TemplateField HeaderText="비고">
                <ItemTemplate>
                    <asp:Label ID="lblMemo" runat=server Text='<%# Eval("memo").ToString() == "" ? "없음" : "보기" %>' 
                        ForeColor='<%# Eval("memo").ToString() == "" ? System.Drawing.Color.Black : System.Drawing.Color.Red %>' 
                        ToolTip='<%# Bind("memo") %>' Font-Bold='<%# Eval("memo").ToString() != "" %>' ></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="상태" SortExpression="status">
                <ItemTemplate>
                    <asp:Label ID="lblState" runat="server" CausesValidation="False"
                        Text='<%# Eval("status").ToString() == "1" ? "회원입금" : "관리자입금" %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="NoticeGridItem" HorizontalAlign="Center" Width="100px" Wrap=false />
            </asp:TemplateField>
             <asp:BoundField DataField="update_time" HeaderText="승인시간" SortExpression="update_time" DataFormatString="{0:yyyy-MM-dd HH:mm}">
                <ItemStyle HorizontalAlign="Center"  Wrap=false />
            </asp:BoundField>
            <asp:BoundField DataField="reg_username" HeaderText="승인자" SortExpression="reg_username" >
                <ItemStyle HorizontalAlign="Center"  Wrap=false />
            </asp:BoundField>
           
        </Columns>
        <FooterStyle BackColor="White" Font-Bold="True" ForeColor="#858585" />
        <PagerStyle HorizontalAlign="Center" CssClass="clsButton" />
        <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" />
        <HeaderStyle CssClass="GridHeader" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="#ecf8ff" />
    </asp:GridView>
    <asp:Panel ID="pnlListBar" runat="server" CssClass="clsControlBar">
        <asp:Button ID="btnRefresh" runat="server" class="btn btn-warning" Text="새로고침" 
            OnClick="btnRefresh_Click" />
        
    </asp:Panel>
    <br />
    <table class="clsTipPanel">
        <tr>
            <td width=20px></td>
            <td class="clsTip">
                - 메모는 보기버튼에 마우스를 가져가면 틀팁으로 확인할수 있습니다.
            </td>
        </tr>
    </table>
    <asp:CustomValidator ID="cvResult" Visible="false" runat="server" Display="Dynamic"
        ValidationGroup="list"></asp:CustomValidator>
    <asp:ValidationSummary ID="vsError" runat="server" ValidationGroup="list" />
</asp:Content>

