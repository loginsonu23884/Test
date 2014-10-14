<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DetailsReport.aspx.vb" Inherits="Gallery_DetailsReport" MaintainScrollPositionOnPostback="true"   title="Phoenix Art Group - Details Report" %>
<%@ Register src="~/Controls/ctlDetails.ascx" tagname="ctlDetails" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Phoenix Art Group - Details Report</title>
</head>
<body onload="ResetScroll();">
    <form id="form1" runat="server">
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="ItemID">
        <LayoutTemplate>
            <div ID="itemPlaceholderContainer" runat="server" style="">
                <span ID="itemPlaceholder" runat="server" />
            </div>
            <div style="">
            </div>
        </LayoutTemplate>
        <EmptyDataTemplate>
            <span>There are no Details to show.</span>
        </EmptyDataTemplate>
        <ItemTemplate>
            <span style="">
                <uc1:ctlDetails ID="details1" IsWindow='<%# IsWindow %>'  ItemID='<%# Eval("ItemID") %>' ImageFile='<%# Eval("ImageFile") %>' loctype='' runat="server" />
              <%--  <uc1:ctlDetails ID="details1" ItemID='<%# Eval("ItemID") %>' ImageFile='<%# Eval("ImageFile") %>' runat="server" />--%>
            </span>
 
        </ItemTemplate>
    </asp:ListView>
   
 
    </form>
</body>

<script type="text/javascript">
    function ResetScroll() {

        window.scrollTo(0, 0);
    }
    
</script> 
   
</html>
    