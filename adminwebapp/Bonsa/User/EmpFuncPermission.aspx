﻿<%@ Page Language="C#" MasterPageFile="회원관리.master" AutoEventWireup="true" CodeFile="EmpFuncPermission.aspx.cs" Inherits="Bonsa_User_EmpFuncPermission" %>


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
            <td>
                사원 기능별 권한관리
            </td>
        </tr>
    </table>
    <!-- 타이틀밑의 두선 -->
    <table  class="clsLineTable">
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div class='PageToolBar'>
    [ <asp:Label ID="lblName" Text="" runat="server"></asp:Label> ] 사원 기능별 권한설정
        <asp:HiddenField ID="hidID" Value="" runat="server" />
        
        <span style="color:Red; padding-left:20px;"></span>
    </div>
    
     <asp:GridView ID="grdList" runat="server" AutoGenerateColumns="False" 
        Width=30% onrowdatabound="grdLisTBL_RowDataBound" >
        <RowStyle CssClass="GridRow" />
        <Columns>
            
            
            <asp:BoundField DataField="func_name" HeaderText="기능명" >
                <ItemStyle CssClass="GridItem" Wrap=false HorizontalAlign=Left />
            </asp:BoundField>
            
            <asp:TemplateField HeaderText="허용"> 
                <ItemTemplate> 
                <asp:CheckBox ID="CheckBoxEdit" runat="server" /> 
                </ItemTemplate> 
                <ItemStyle CssClass="GridItem" HorizontalAlign="Center" />
            </asp:TemplateField> 
            
           
        </Columns>
        <FooterStyle BackColor="White" Font-Bold="True" ForeColor="#858585" />
        <PagerStyle HorizontalAlign="Center" CssClass="clsButton" />
        <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" />
        <HeaderStyle CssClass="GridHeader" />
        <EditRowStyle BackColor="#2461BF" />
        <AlternatingRowStyle BackColor="#EAEAEA" />
      </asp:GridView>
        
    <asp:Panel ID="pnlListBar" runat="server" CssClass="clsControlBar">
        <asp:Button ID="btnSave" runat="server" CssClass="clsButton" Text=" 저 장 " OnClientClick="return confirm('저장 하시겠습니까?');" OnClick="btnSave_OnClick"/>
        <asp:Button ID="btnList" runat="server"  CssClass="clsButton" Text=" 목록보기 " OnClick="btnList_Click"/>
        <asp:Label ID="lblResultMsg" runat="server" ForeColor="Red" Text=""></asp:Label>
    </asp:Panel>
</asp:Content>
