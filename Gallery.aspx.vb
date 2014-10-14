
Partial Class Gallery
    Inherits System.Web.UI.Page
    Enum ControlMode
        SalesRep
        Customer
        Report
    End Enum
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim da As PhoenixArtDatasetTableAdapters.GalleryIsActiveTableAdapter = New PhoenixArtDatasetTableAdapters.GalleryIsActiveTableAdapter
        'Added by nidhi to show all
        ctlGallery1.Active = -1
        Session.Add("IsCustomerGallery", "1")
        Session("IsAvai_Gallery") = Nothing
        Session("IsGallery") = Nothing

      
        '****************
        Dim galleryID As Int32 = 0
        Dim blShowPrice As Boolean = False
        Dim ShowPrice As Int32 = 0
        Dim blWatermarks As Boolean = False
        Dim ShowWatermark As Int32 = 0
        Dim GalleryInStr As String = ""
        Dim IDPart As Int32 = 0
        Dim IDEnd As Int32 = 0

        If Page.IsPostBack = False Then

            Try
                ctlGallery1.DataBind()
                'Dim lnkAddGalleryAll As LinkButton = DirectCast(ctlGallery1.FindControl("lnkAddGalleryAll"), LinkButton)
                'lnkAddGalleryAll.Visible = True
                Dim count As Integer = ctlGallery1.ItemCount

                If Page.Request.QueryString("ID") IsNot Nothing Then
                    GalleryInStr = Page.Request.QueryString("ID").ToString.Trim
                    GalleryInStr = Encoding.UTF8.GetString(Convert.FromBase64String(GalleryInStr))
                    GalleryInStr = KitFramework.Cryptography.TripleDes.Decrypt(GalleryInStr)

                End If
               
                IDPart = InStr(GalleryInStr, "&")
                If IDPart > 0 Then
                    galleryID = CInt(Mid$(GalleryInStr, 1, IDPart - 1))

                End If

                If Cache("MyData") Is Nothing Then
                    Dim dtC As PhoenixArtDataset.SearchItemsDataTable = Nothing
                    Dim daC As PhoenixArtDatasetTableAdapters.SearchItemsTableAdapter = New PhoenixArtDatasetTableAdapters.SearchItemsTableAdapter
                    daC.SetCommandTimeOut(720)
                    dtC = daC.GetData()

                    Cache.Insert("MyData", dtC)
                End If

                ctlGallery1.NewSearch = True

                If Session("Datalist") Is Nothing Then
                Else
                    Session("DataList") = Nothing

                End If

                Dim dt As PhoenixArtDataset.GalleryIsActiveDataTable = da.GetData(galleryID)
                Dim dr As PhoenixArtDataset.GalleryIsActiveRow = Nothing

                If dt.Rows.Count > 0 Then
                    dr = dt.Rows(0)
                    If dr.IsActive = False Then
                        Page.Response.Redirect("~/Customers/InActive.aspx")
                    End If
                End If
                Try

                    Dim hdnGalleryID As HiddenField = DirectCast(ctlGalleryStrip1.FindControl("hdnGalleryID"), HiddenField)
                    hdnGalleryID.Value = galleryID
                    ' Response.Write(Controls_ctlGallery.ControlMode.Customer.ToString())
                    ctlGallery1.GalleryID = galleryID
                    ctlGallery1.Mode = ControlMode.Customer

                    ctlGallery1.ItemsToShow = 5
                    ctlGallery1.ShowText = False
                    ctlGallery1.DataBind()
                Catch ex As Exception
                    Response.Write(ex.Message.ToString())
                End Try

               

                Dim coun2 As Integer = ctlGallery1.ItemCount

                ctlSearch1.GalleryID = galleryID
                ctlSearch1.Mode = ControlMode.Customer
                ctlSearch1.DataBind()
                Try
                    ctlGalleryStrip1.UserID = ctlGallery1.UserID
                    Session.Add("RecpGalleryName", ctlGallery1.GalleryName)
                    If Session("RecpGalleryName").ToString.Contains("reply") Then
                        tdGalleryStrip.Visible = True
                    Else
                        tdGalleryStrip.Visible = True
                    End If


                    ctlGalleryStrip1.Mode = ControlMode.Customer
                    ctlGalleryStrip1.GalleryName = ctlGallery1.GalleryName

                    ctlGalleryStrip1.GalleryID = galleryID
                    If ctlGallery1.GalleryStripID = 0 Or ctlGallery1.GalleryStripID Is Nothing Then
                        ctlGalleryStrip1.GalleryStripID = 0
                    End If

                Catch ex As Exception

                End Try

                intTimeout.Value = ConfigurationManager.AppSettings.Item("PageTimeout")
                IDPart = InStr(GalleryInStr, "SP=")
                If IDPart > 0 Then
                    ShowPrice = CInt(Mid$(GalleryInStr, IDPart + 3, 1))
                    If ShowPrice = 1 Then
                        ctlGallery1.ShowPrices = True
                        Session("Thumbnail.ShowPrices") = True
                        Session("Details.ShowPrices") = True
                    Else
                        ctlGallery1.ShowPrices = False
                        Session("Thumbnail.ShowPrices") = False
                        Session("Details.ShowPrices") = False
                    End If
                End If

                IDPart = InStr(GalleryInStr, "WM=")

                If IDPart > 0 Then
                    ShowWatermark = CInt(Mid$(GalleryInStr, IDPart + 3, 1))
                    If ShowWatermark = 1 Then
                        ctlGallery1.ShowWatermarks = True
                        Session("Thumbnail.ShowWatermarks") = True
                        Session("Details.ShowWatermarks") = True
                    Else
                        ctlGallery1.ShowWatermarks = False
                        Session("Thumbnail.ShowWatermarks") = False
                        Session("Details.ShowWatermarks") = False
                    End If
                End If

                IDPart = InStr(GalleryInStr, "FR=")
                IDEnd = InStr(GalleryInStr, "TO=")
                If IDPart > 0 Then
                    Session("Email.From") = Mid$(GalleryInStr, IDPart + 3, (IDEnd - 4) - IDPart)
                End If

                IDPart = InStr(GalleryInStr, "TO=")
                IDEnd = InStr(GalleryInStr, "SU=")

                If IDPart > 0 Then
                    Session("Email.To") = Mid$(GalleryInStr, IDPart + 3, (IDEnd - 4) - IDPart)
                End If

                IDPart = InStr(GalleryInStr, "SU=")

                If IDPart > 0 Then
                    Session("Email.Subject") = Mid$(GalleryInStr, IDPart + 3)
                End If
            Catch ex As Exception

            End Try

        End If
    End Sub

    Public Sub ClearSearch()
        If ctlGallery1.GalleryID = 0 Then
            ctlGallery1.GalleryID = Nothing
        End If
        ctlGallery1.Artist = Nothing
        ctlGallery1.Style = Nothing
        ctlGallery1.Medium = Nothing
        ctlGallery1.ItemCode = Nothing
        ctlGallery1.Title = Nothing
        ctlGallery1.InStock = False
        ctlGallery1.ColorID = 0
        'change by  by nidhi to show all 
        'ctlGallery1.Active =0

        ctlGallery1.Active = 2

        ctlGallery1.DataBind()
    End Sub

    Protected Sub ctlSearch1_ClearSearch(ByVal sender As Object, ByVal e As System.EventArgs) Handles ctlSearch1.ClearSearch
        If Session("Reset") Is Nothing Then
        Else
            If Session("Reset") = True Then
                ctlGallery1.PageIndex = 0
                Session("Reset") = Nothing
            End If
        End If
        ClearSearch()
    End Sub

    Protected Sub ctlSearch1_SearchChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ctlSearch1.SearchChanged
        ctlGallery1.Artist = ctlSearch1.Artist
        ctlGallery1.Style = ctlSearch1.Style
        ctlGallery1.Medium = ctlSearch1.Medium
        ctlGallery1.ItemCode = ctlSearch1.ItemCode
        ctlGallery1.Title = ctlSearch1.Title
        ctlGallery1.InStock = ctlSearch1.InStock
        ctlGallery1.Active = ctlSearch1.Active
        ctlGallery1.NewSearch = True
        ctlGallery1.CacheLoaded = True
        ctlGallery1.ColorID = ctlSearch1.ColorID
        If ctlSearch1.GalleryID > 0 Then
            ctlGallery1.GalleryID = ctlSearch1.GalleryID
        End If

        ctlGallery1.NewSearch = True
        ctlGallery1.CacheLoaded = True

        If Session("Reset") Is Nothing Then
        Else
            If Session("Reset") = True Then
                ctlGallery1.PageIndex = 0
                Session("Reset") = Nothing
            End If
        End If

        ctlGallery1.DataBind()
        ctlGallery1.m_AllReadyloaded = False
    End Sub

    Protected Sub ctlGallery1_GalleryItemAdded(ByVal sender As Object, ByVal e As System.EventArgs) Handles ctlGallery1.GalleryItemAdded
        ctlGalleryStrip1.GalleryAdded(ctlGallery1.GalleryStripID)
        ctlGalleryStrip1.DataBind()
    End Sub

    Protected Sub cmdRows_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdRows.Click
        If lstShowItems Is Nothing Then
            ctlGallery1.ItemsToShow = 5
            ctlGallery1.ChangePageSize(5)
        Else
            If lstShowItems.SelectedValue < 1 Then
                ctlGallery1.ItemsToShow = 5
                ctlGallery1.ChangePageSize(5)
            Else
                ctlGallery1.ItemsToShow = CInt(lstShowItems.SelectedValue)
                ctlGallery1.ChangePageSize(lstShowItems.SelectedValue)
            End If
        End If
    End Sub

    Protected Sub cbSort_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cbSort.SelectedIndexChanged
        Dim SortText As String = ""
        If cbSort.SelectedItem.Value = 1 Then
            SortText = "AddDate"
        ElseIf cbSort.SelectedItem.Value = 2 Then
            SortText = "Artist"
        ElseIf cbSort.SelectedItem.Value = 3 Then
            SortText = "Medium"
        ElseIf cbSort.SelectedItem.Value = 4 Then
            SortText = "Style"
        ElseIf cbSort.SelectedItem.Value = 5 Then
            SortText = "ItemCode"
        ElseIf cbSort.SelectedItem.Value = 6 Then
            SortText = "ItemDescription"
        End If

        ctlGallery1.SortOrder = SortText
        ctlGallery1.DataBind()
    End Sub

    Protected Sub ctlGalleryStrip1_CreateNewGallery(ByVal sender As Object, ByVal e As System.EventArgs) Handles ctlGalleryStrip1.CreateNewGallery
        ctlGallery1.CreateNewGallery()
        ctlGalleryStrip1.DataBind()
    End Sub
End Class
