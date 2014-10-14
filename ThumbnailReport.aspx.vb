
Partial Class Gallery_ThumbnailReport
    Inherits System.Web.UI.Page

    Public Property SortOrder() As String
        Get
            Return ViewState("SortOrder")
        End Get
        Set(ByVal value As String)
            ViewState("SortOrder") = value
        End Set
    End Property

    Public Property GalleryID() As Nullable(Of Int32)
        Get
            Return ViewState("GalleryID")
        End Get
        Set(ByVal value As Nullable(Of Int32))
            ViewState("GalleryID") = value
        End Set
    End Property

    Private Function GetData() As List(Of PhoenixArtDataset.SearchItemsRow)
        If Cache("MyData") Is Nothing Then
            Dim da As PhoenixArtDatasetTableAdapters.SearchItemsTableAdapter = New PhoenixArtDatasetTableAdapters.SearchItemsTableAdapter
            Dim dt As PhoenixArtDataset.SearchItemsDataTable = da.GetData()

            Cache.Insert("MyData", dt)

            Return FilterData(Cache.Item("MyData"))
        Else
            Return FilterData(Cache.Item("MyData"))
        End If
    End Function

    Private Function FilterData(ByVal dtIn As PhoenixArtDataset.SearchItemsDataTable) As List(Of PhoenixArtDataset.SearchItemsRow)
        Dim ReturnValue As List(Of PhoenixArtDataset.SearchItemsRow) = Nothing
        Dim Result As List(Of PhoenixArtDataset.SearchItemsRow) = Nothing

        If GalleryID.HasValue Then
            Dim daGalleryItems As PhoenixArtDatasetTableAdapters.ItemsInGallleryTableAdapter = New PhoenixArtDatasetTableAdapters.ItemsInGallleryTableAdapter
            Dim dtGalleryItems As PhoenixArtDataset.ItemsInGallleryDataTable = daGalleryItems.GetData(GalleryID)

            Dim query = From c In dtIn _
                        Join d In dtGalleryItems On d.ItemID Equals c.ItemID _
                        Select c
            If query Is Nothing Then
            Else
                Result = query.ToList
            End If
        Else
            Dim query = From c In dtIn Select c
            Result = query.ToList
        End If

        ReturnValue = SortData(Result)
        Return ReturnValue
    End Function

    Private Function SortData(ByVal InData As List(Of PhoenixArtDataset.SearchItemsRow)) As List(Of PhoenixArtDataset.SearchItemsRow)
        Dim ReturnValue As List(Of PhoenixArtDataset.SearchItemsRow)

        If SortOrder = "Artist" Then
            Dim q = From c In InData Order By c.ArtistName Select c
            ReturnValue = q.ToList
        ElseIf SortOrder = "Medium" Then
            Dim q = From c In InData Order By c.Medium Select c
            ReturnValue = q.ToList
        ElseIf SortOrder = "Style" Then
            Dim q = From c In InData Order By c.Style Select c
            ReturnValue = q.ToList
        Else
            Dim q = From c In InData Order By c.AddDate Select c
            ReturnValue = q.ToList
        End If

        Return ReturnValue
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ctlthumbnail1.Mode = Controls_ctlThumbnail.ControlMode.Report
        If Request.QueryString("GID") IsNot Nothing Then
            GalleryID = Convert.ToInt32(Request.QueryString("GID"))
        Else
            If Session("Thumbnail.GalleryID") Is Nothing Then
                GalleryID = Nothing
            Else
                If Session("Thumbnail.GalleryID") > 0 Then
                    GalleryID = Session("Thumbnail.GalleryID")
                Else
                    GalleryID = Nothing
                End If
            End If
        End If
       

        ctlthumbnail1.GalleryID = GalleryID
        ctlthumbnail1.ItemsToShow = 100000
        ctlthumbnail1.DataBind()
        Session("ItemsShown") = Nothing
    End Sub

End Class
