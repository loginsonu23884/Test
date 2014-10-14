<%@ Page Language="VB" MasterPageFile="~/MasterPages/Default.master"  EnableViewStateMac="false" AutoEventWireup="false" CodeFile="ShowAvailableInventory.aspx.vb" Inherits="Gallery_ShowAvailableInventory" Title="Phoenix Art Group - Available Inventory" %>

<%@ Register Src="~/Controls/ctlInventorySearch.ascx" TagName="ctlInventorySearch" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctlInventoryGallery.ascx" TagName="ctlInventoryGallery" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctlDetails.ascx" TagName="ctlDetails" TagPrefix="uc1" %>
<%@ Register Src="~/Controls/ctlGalleryStrip.ascx" TagName="ctlGalleryStrip" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentMain" runat="Server">

<script type="text/javascript" src="../Js/jquery.min.js"></script>
<%--    <script type="text/javascript" src="../Js/jquery.js"></script>--%>

    <script type="text/javascript" src="../Js/blockUI.js"></script>

<script type="text/javascript" src="../Js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="../Js/sexyalertbox.v1.2.jquery.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../App_Themes/Default/sexyalertbox.css"/>
    <div id="demo2">
    </div>

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
    <span style="display: none;">
        <asp:Button runat="server" OnClick="btnAddAll_Click" ID="btnAddAll" /></span>
    <asp:UpdatePanel ID="AllGallery" UpdateMode="Always" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="intCount" runat="server" Value="0" />
            <asp:HiddenField ID="intTimeout" runat="server" Value="0" />
            <dxt:ASPxTimer ID="tmrLogout" ClientInstanceName="tmrLogout1" Interval="60000" Enabled="true"
                runat="server">
                <ClientSideEvents Tick="function (s,e) {AddCount();}" />
                <ClientSideEvents Init="function (s,e) {ClearCount();}" />
            </dxt:ASPxTimer>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <font color="red" style="font-family: Verdana; font-size: 18px;"><b>Please wait...</b></font>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <table cellpadding="0" cellspacing="2" class="GalleryImages" onmousemove="ClearCount();">
                <tr>
                    <td>
                        <uc1:ctlInventorySearch ID="ctlSearch1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="tblTemplate" runat="server" CssClass="Gallery Border_Gallery">
                            <table width="100%">
                                <tr>
                                    <td valign="middle" align="right" width="100px">
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
                                    <td width="20px">
                                        <asp:Button ID="cmdRows" OnClientClick="javascript:CallFunction();"  runat="server" AutoPostBack="true" Text="Apply"></asp:Button>
                                    </td>
                                    <td align="right" width="30px">
                                        <asp:Label ID="Label2" runat="server" Text="Sort By: " Width="75px"></asp:Label>
                                    </td>
                                    <td align="left" width="230px">
                                        <dxe:ASPxComboBox ID="cbSort" ClientInstanceName="cbSortList" runat="server" ValueType="System.String"
                                            AutoPostBack="True" CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass"
                                            ImageFolder="~/App_Themes/BlackGlass/{0}/">
                                            <ButtonStyle Cursor="pointer" Width="11px">
                                            </ButtonStyle>
                                            <ValidationSettings ErrorText="Error has occurred">
                                                <ErrorImage Height="14px" Width="14px" Url="~/App_Themes/BlackGlass/Editors/Error.gif" />
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
                                                <dxe:ListEditItem Text="Subject" Value="7" />
                                                <dxe:ListEditItem Text="Largest to smallest size" Value="8" />
                                                <dxe:ListEditItem Text="Smallest to largest size" Value="9" />
                                            </Items>
                                              <ClientSideEvents SelectedIndexChanged="function(s, e) {   CallFunction();}" />
                                        </dxe:ASPxComboBox>
                                    </td>
                                    <td align="right" width="150px" valign="top" style="padding-top: 3px">
                                        <asp:Label ID="ASPxLabel1" runat="server" Text="Go To Page:" Width="150px" />
                                    </td>
                                    <td valign="middle">
                                        <dxe:ASPxTextBox ID="txtGoTo" runat="server" Width="50px" />
                                    </td>
                                    <td style="padding-right: 20px">
                                        <dxe:ASPxButton ID="cmdGoTo" runat="server" Text="Go" AutoPostBack="true" CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css"
                                            CssPostfix="BlackGlass">
                                             <ClientSideEvents Click="function(s, e) { CallFunction(); }" />
                                        </dxe:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <uc1:ctlInventoryGallery ID="ctlInventoryGallery1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <uc1:ctlGalleryStrip ID="ctlGalleryStrip1"  runat="server" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    
    <dxt:ASPxTimer ID="ASPxTimer1" ClientInstanceName="timer1" runat="server" Interval="800">
        <ClientSideEvents Tick="function(s, e) {timer1.SetEnabled(false);ShowPopup();}" Init="function(s,e) {timer1.SetEnabled(false);}" />
    </dxt:ASPxTimer>

    <script type="text/javascript">
    var _CurrentPopupElement = null;

    function SetCurrentPopupElement(obj) {
        _CurrentPopupElement = obj;
    }

    function AddCount() {
        var intCnt = document.getElementById('ctl00_ContentMain_intCount');
        
        intCnt.value = parseInt(intCnt.value) + 1;
        RedirectNow();
    }

    function ClearCount() {
        var intCnt = document.getElementById('ctl00_ContentMain_intCount');
        
        intCnt.value = 0;
    }

    function RedirectNow() {
        var intCnt = document.getElementById('ctl00_ContentMain_intCount');
        var intTimeOut = document.getElementById('ctl00_ContentMain_intTimeout');
        
        if (parseInt(intCnt.value) >= parseInt(intTimeOut.value))
        {
            document.location='../Login.aspx?timeout=1';
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
    function ShowPopup(){
        if (_CurrentPopupElement != null) {
            checkclassName();
            timer1.SetEnabled(false);
            Details.Hide();
           
            PopupCallback1.PerformCallback(_CurrentPopupElement.id);        
            Details.ShowAtElementByID(_CurrentPopupElement.id);
        }
        else {timer1.SetEnabled(false);}
    }

    function popup(mylink) {

        
        if (! window.focus)return true;
            var href;
        if (typeof(mylink) == 'string')
            href=mylink;
        else
            href=mylink.href;
//        window.open(href, 'reportpopup', 'location=0,status=1,scrollbars=1,resizable=yes,width=900,height=600,toolbar=1');
//        return false;

          href=href+"&Div=1";
          var win = window.open(href, '_blank');
          win.focus();

         //GB_myShow('Report popup window',href );
    }

    function popupEmail(mylink) {
       
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

    function popup2(mylink) 
    {
       if (! window.focus) return true;
       var href;
        if (typeof (mylink) == 'string')
            href = mylink;
        else
            href = mylink.href;
        window.open(href, 'Help', 'location=0,status=1,scrollbars=1,resizable=yes,width=900,height=600,toolbar=1');
        return false;
    }

    function chkPopup() 
    {
        var test = document.getElementById('ctl00$ContentMain$ctlGallery1$cboGalleries')
        var click = document.getElementById('ctl00$ContentMain$ctlGallery1$clickTest')
        if (test.value == '') {
            click.value ='pop';
        }
    }
    function EndRequestHandler() {


        CallFunctionEnd();
    }

    load();
       
    </script>
<script type="text/javascript">


    function PopupMessage(s, e) {
       
        if (document.getElementById("ctl00_ContentMain_ctlGalleryStrip1_cboGalleries1_I") == null || document.getElementById("ctl00_ContentMain_ctlGalleryStrip1_cboGalleries1_I").value == "") {
            //alert("You must create a new gallery or open an existing gallery to continue.")
            Sexy.alert('<h1>Unable to email/print</h1><p>You must create a new gallery or open an existing gallery to continue.</p>');
            return false; 
           
        }
        else {
   
            if (document.getElementById("ctl00_ContentMain_ctlGalleryStrip1_ASPxDataView1_PPTBL_lblCount") == null || document.getElementById("ctl00_ContentMain_ctlGalleryStrip1_ASPxDataView1_PPTBL_lblCount").innerHTML == "" || document.getElementById("ctl00_ContentMain_ctlGalleryStrip1_ASPxDataView1_PPTBL_lblCount").innerHTML == "0") {
                //alert("You must add selections to your gallery to continue.")
                Sexy.alert('<h1>Add images to continue</h1><p>You must add selections to your gallery to continue.</p>');
                return false;
            }
            else {
           
                return true;
            }
            
        }
       
        }

   
        

</script>

</asp:Content>
