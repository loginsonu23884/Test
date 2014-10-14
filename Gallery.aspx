<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Gallery.aspx.vb" Inherits="Gallery" ValidateRequest="false" %>

<%@ Register Src="~/Controls/ctlSearch.ascx" TagName="ctlSearch" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctlGallery.ascx" TagName="ctlGallery" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctlDetails.ascx" TagName="ctlDetails" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctlGalleryStrip.ascx" TagName="ctlGalleryStrip" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Phoenix Art Group - Gallery View</title>

    <script type="text/javascript">
        var GB_ROOT_DIR = "../greybox/";
    </script>

    <script type="text/javascript" src="../GreyBox/AJS.js"></script>

    <script type="text/javascript" src="../GreyBox/AJS_fx.js"></script>

    <script type="text/javascript" src="../GreyBox/gb_scripts.js"></script>

    <script type="text/javascript" src="../static_files/help.js"></script>

    <link href="../GreyBox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="../Js/jquery.min.js"></script>
<%--    <script type="text/javascript" src="../Js/jquery.js"></script>--%>

    <script type="text/javascript" src="../Js/blockUI.js"></script>

<script type="text/javascript" src="../Js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="../Js/sexyalertbox.v1.2.jquery.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../App_Themes/Default/sexyalertbox.css"/>


    <script type="text/javascript">
        $(document).ready(function() {
            $('#demo2').click(function() {

                $.blockUI({ css: {
                    border: 'none',
                    padding: '15px',
                    backgroundColor: '#000',
                    '-webkit-border-radius': '10px',
                    '-moz-border-radius': '10px',
                    opacity: '.5',
                    color: '#fff'
                }
                });


            });
        });


        function CallFunction() {

            $('#demo2').click();

        }
        function CallFunctionEnd() {

            setTimeout($.unblockUI, 100);

        }
        function load() {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        }

    </script>

    <script type="text/javascript">
        GB_myShow = function(caption, url, /* optional */height, width, callback_fn) {
            var options = {
                caption: caption,
                height: height || 700,
                width: width || 1024,
                fullscreen: true,
                show_loading: true,
                callback_fn: callback_fn
            }
            var win = new GB_Window(options);
            return win.show(url);
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="demo2">
    </div>
    <center>
        <div style="padding-top: 10px; width: 100%; text-align: center">
            <asp:ScriptManager ID="scrManager" runat="server" EnablePartialRendering="true">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="upGallery" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <asp:HiddenField ID="intCount" runat="server" Value="0" />
                    <asp:HiddenField ID="intTimeout" runat="server" Value="0" />
                    <dxt:ASPxTimer ID="tmrLogout" ClientInstanceName="tmrLogout1" Interval="60000" Enabled="true"
                        runat="server">
                        <ClientSideEvents Tick="function (s,e) {AddCount();}" />
                        <ClientSideEvents Init="function (s,e) {ClearCount();}" />
                    </dxt:ASPxTimer>
                    <div>
                        <table onmousemove="ClearCount();">
                            <tr>
                                <td>
                                    <asp:Label ID="lblTitle" runat="server" Font-Bold="true" Font-Size="Medium" Text="Phoenix Art Group - Gallery Selection"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                        <ProgressTemplate>
                                            <font color="red" style="font-family: Verdana; font-size: 18px;"><b>Please wait...</b></font>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" style="display: none;">
                                    <uc1:ctlSearch ID="ctlSearch1" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="display: none;">
                                    <table width="100%" id="tblTemplate" runat="server" class="Gallery Border_Gallery">
                                        <tr>
                                            <td valign="middle">
                                                <asp:Label ID="Label1" runat="server" Text="Images per page: " Width="110px"></asp:Label>
                                            </td>
                                            <td align="left" width="33px" style="padding-right: 3px">
                                                <asp:DropDownList ID="lstShowItems" runat="server">
                                                    <asp:ListItem Text="4" Value="1" />
                                                    <asp:ListItem Text="8" Value="2" />
                                                    <asp:ListItem Text="12" Value="3" />
                                                    <asp:ListItem Text="16" Value="4" />
                                                    <asp:ListItem Text="20" Value="5" Selected="True" />
                                                    <asp:ListItem Text="24" Value="6" />
                                                    <asp:ListItem Text="28" Value="7" />
                                                    <asp:ListItem Text="32" Value="8" />
                                                    <asp:ListItem Text="36" Value="9" />
                                                    <asp:ListItem Text="40" Value="10" />
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <dxe:ASPxButton ID="cmdRows" runat="server" AutoPostBack="true" Text="Apply" SkinID="Button_Gallery">
                                                </dxe:ASPxButton>
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="Label2" runat="server" Text="Sort By: " Width="75px"></asp:Label>
                                            </td>
                                            <td width="90%" align="left">
                                                <dxe:ASPxComboBox ID="cbSort" ClientInstanceName="cbSortList" runat="server" CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css"
                                                    CssPostfix="BlackGlass" ImageFolder="~/App_Themes/BlackGlass/{0}/" ValueType="System.String"
                                                    EnableViewState="true" AutoPostBack="true">
                                                    <ButtonStyle Cursor="pointer" Width="11px">
                                                    </ButtonStyle>
                                                    <ValidationSettings ErrorText="Error has occurred">
                                                        <ErrorImage Height="14px" Url="~/App_Themes/BlackGlass/Editors/Error.gif" Width="14px" />
                                                        <ErrorFrameStyle ImageSpacing="4px">
                                                            <ErrorTextPaddings PaddingLeft="4px" />
                                                        </ErrorFrameStyle>
                                                    </ValidationSettings>
                                                    <Items>
                                                        <dxe:ListEditItem Text="Latest Artwork" Value="1" />
                                                        <dxe:ListEditItem Text="Artist" Value="2" />
                                                        <dxe:ListEditItem Text="Medium" Value="3" />
                                                        <dxe:ListEditItem Text="Style" Value="4" />
                                                        <dxe:ListEditItem Text="Item #" Value="5" />
                                                        <dxe:ListEditItem Text="Title" Value="6" />
                                                    </Items>
                                                </dxe:ASPxComboBox>
                                            </td>
                                            <%-- <td align="right">
                                            <asp:Hyperlink ID="imgHelp" ImageUrl="~/Images/Icons/question.gif" NavigateUrl="javascript:(function(){popup2('../Customers/galleryhelp.htm');}())" runat="server" />
                                        </td>--%>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <uc1:ctlGallery ID="ctlGallery1"  runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" id="tdGalleryStrip" runat="server">
                                    <uc1:ctlGalleryStrip ID="ctlGalleryStrip1"  IsCustomer="true" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </center>
    <dxt:ASPxTimer ID="tmrDisplay" ClientInstanceName="timer1" Enabled="False" runat="server"
        Interval="800">
        <ClientSideEvents Tick="function(s, e) {timer1.SetEnabled(false);ShowPopup();}" Init="function(s,e) {timer1.SetEnabled(false);}" />
    </dxt:ASPxTimer>

    <script language="javascript" type="text/javascript">
        var _CurrentPopupElement = null;

        function SetCurrentPopupElement(obj) {
            _CurrentPopupElement = obj;
        }

        function AddCount() {
            var intCnt = document.getElementById('intCount');

            intCnt.value = parseInt(intCnt.value) + 1;
            RedirectNow();
        }

        function ClearCount() {
            var intCnt = document.getElementById('intCount');

            intCnt.value = 0;
        }


        function RedirectNow() {
            var intCnt = document.getElementById('intCount');
            var intTimeOut = document.getElementById('intTimeout');

            if (parseInt(intCnt.value) >= parseInt(intTimeOut.value)) {
                document.location = '../Login.aspx?timeout=1';
            }
        }

        function checkclassName() {
            //alert('checkclassname');
            var arr = document.getElementsByTagName("td");
            for (i = 0; i < arr.length; i++) {
                if (arr[i].className == 'dxpcControl') {

                    arr[i].className = '';
                    arr[i].className = 'PopupControlNewPopup';

                }
                if (arr[i].className == 'dxpcContent') {
                    arr[i].className = '';
                }
            }
        }
        checkclassName();
        function ShowPopup() {
            if (_CurrentPopupElement != null) {
                checkclassName();
                timer1.SetEnabled(false);
                Details.Hide();
                PopupCallback1.PerformCallback(_CurrentPopupElement.id);
                Details.ShowAtElementByID(_CurrentPopupElement.id);
            }
            else { timer1.SetEnabled(false); }
        }

        function popup(mylink) {
            if (!window.focus) return true;
            var href;
            if (typeof (mylink) == 'string')
                href = mylink;
            else
                href = mylink.href;
            href = href + "&Div=1";

            GB_myShow('Report popup window', href);

        }

        function popupEmail(mylink) {
            if (!window.focus) return true;
            var href;
            if (typeof (mylink) == 'string')
                href = mylink;
            else
                href = mylink.href;
        
            var options = {
                caption: 'Send Email',
                height: 600,
                width: 850,
                fullscreen: false,
                show_loading: true
            }
            var win = new GB_Window(options);
            return win.show(href);
        }

        function popup2(mylink) {
            if (!window.focus) return true;
            var href;
            if (typeof (mylink) == 'string')
                href = mylink;
            else
                href = mylink.href;
            window.open(href, 'Help', 'width=732,height=600,scrollbars=yes');
            return false;
        }
    </script>

    <script type="text/javascript">
        function EndRequestHandler() {


            CallFunctionEnd();
        }

        load();

        function PopupMessage(s, e) {
           
            if (document.getElementById("ctlGalleryStrip1_cboGalleries1_I") == null || document.getElementById("ctlGalleryStrip1_cboGalleries1_I").value == "") {
                //alert("You must create a new gallery or open an existing gallery to continue.")
                Sexy.alert('<h1>Unable to email/print</h1><p>You must create a new gallery or open an existing gallery to continue.</p>');
                return false;
               
            }
            else {

                if (document.getElementById("ctlGalleryStrip1_ASPxDataView1_PPTBL_lblCount") == null || document.getElementById("ctlGalleryStrip1_ASPxDataView1_PPTBL_lblCount").innerHTML == "" || document.getElementById("ctlGalleryStrip1_ASPxDataView1_PPTBL_lblCount").innerHTML == "0") {
                    //alert("You must add selections to your gallery to continue.")
                  //  Sexy.alert('<h1>Add images to continue</h1><p>You must add selections to your gallery to continue.</p>');
                    // return false;
                    return true;
                }
                else {

                    return true;
                }

            }

        }

   
        

    </script>

    </form>
</body>
</html>
