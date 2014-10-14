
Partial Class Gallery_Email
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Me.IsPostBack = False Then
            'ctlSendEmail1.OriginalGalleryID = Session("email.OriginalGalleryID")
            ctlSendEmail1.OriginalGalleryID = 0
            ctlSendEmail1.GalleryID = Session("email.GalleryID")
            ctlSendEmail1.GalleryName = Session("email.GalleryName")
            ctlSendEmail1.Mode = Session("email.Mode")

            If Page.Request.QueryString("MailMode") = 1 Then
                ctlSendEmail1.MailMode = Controls_ctlSendEmail.MailModes.LinkMode
            Else
                ctlSendEmail1.MailMode = Controls_ctlSendEmail.MailModes.EmbedMode
            End If
            ctlSendEmail1.DataBind()
        End If
        
    End Sub

    Protected Sub ctlSendEmail1_SendComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles ctlSendEmail1.SendComplete
        Page.RegisterStartupScript("closeme", "<script language=""JavaScript"">window.close();</script>")

    End Sub
End Class
