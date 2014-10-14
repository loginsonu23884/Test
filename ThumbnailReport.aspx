<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ThumbnailReport.aspx.vb" Inherits="Gallery_ThumbnailReport" title="Phoenix Art Group - Thumbnail Report" %>

<%@ Register src="../Controls/ctlThumbnail.ascx" tagname="ctlThumbnail" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Phoenix Art Group - Thumbnail Report</title>
</head>
<body>
    <form id="form1" runat="server">

        <uc1:ctlThumbnail ID="ctlthumbnail1" runat="server" />
    </form>
 </body>
 </html>

