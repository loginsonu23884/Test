<%@ Page Language="VB" ValidateRequest="false"  AutoEventWireup="false" CodeFile="Email.aspx.vb" Inherits="Gallery_Email" EnableEventValidation="false"  %>

<%@ Register src="../Controls/ctlSendEmail.ascx" tagname="ctlSendEmail" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<script type="text/javascript">
 
    function confirmCancel()
    {
    var Check=confirm('Are you sure you want to cancel this email?')
       if(Check)
       {
        window.close();
       }
       else
       { return false; }
    }
    
    
</script>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
</head>
<body>
    <form id="form1" runat="server">
 
        <uc1:ctlSendEmail ID="ctlSendEmail1" runat="server"  />
    <asp:Button ID="cmdSubmit" runat="server" Text="" UseSubmitBehavior="true" OnClientClick="closepopup();" Visible="false" />
    
  <asp:HiddenField ID="hdnchk" Value="0" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript">
    function closepopup()
    {
        window.close();
    }
</script>
