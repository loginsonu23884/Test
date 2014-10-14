<%@ page language="VB" autoeventwireup="false" inherits="Customers_InActive, App_Web_z1yv-zsa" enableEventValidation="false" theme="Default" stylesheettheme="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inactive Gallery</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td align="center">
                    <div>
                        <asp:Label ID="Label2" Font-Bold="true" Font-Italic="true" Font-Size="Large" runat="server" Text="Phoenix Art Group"></asp:Label>
                    </div>            
                </td>
            </tr>
            <tr>
                <td align="center">
                    <div style="border-style:solid; border-color:red; border-width:2px; margin-left:50px; margin-top:30px; padding: 5px 5px 5px 5px; width:400px; text-align:left">
                        <asp:Label ID="Label1" runat="server" Text="Sorry the Gallery you are trying to view is inactive or does not exist. <br /><br />  If you think this is in error, you should contact the Sales Representitive to have him or her resend the gallery link to you. <br /><br />  Thanks. <br /> Phoenix Art Group"></asp:Label>
                    </div>            
                </td>
            </tr>
        </table>
        
        
    </div>
    </form>
</body>
</html>
