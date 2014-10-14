
Partial Class Gallery_DetailsReport
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

    Public Property ItemCode() As String
        Get
            Return ViewState("ItemCode")
        End Get
        Set(ByVal value As String)
            ViewState("ItemCode") = value
        End Set
    End Property
    Public Property IsWindow() As String
        Get
            Return ViewState("IsWindow")
        End Get
        Set(ByVal value As String)
            ViewState("IsWindow") = value


        End Set
    End Property
    Private Function GetDataAI() As List(Of PhoenixArtDataset.getItemwithAvialableInventoryRow)
        If Cache("MyDataNew") Is Nothing Then
            Dim daGalleryData As PhoenixArtDatasetTableAdapters.getItemwithAvialableInventoryTableAdapter = New PhoenixArtDatasetTableAdapters.getItemwithAvialableInventoryTableAdapter
            Dim dtGalleryData As PhoenixArtDataset.getItemwithAvialableInventoryDataTable = daGalleryData.GetData()
            HttpContext.Current.Cache.Insert("MyDataNew", dtGalleryData)
            Return FilterDataAI(Cache.Item("MyDataNew"))
        Else
            Return FilterDataAI(Cache.Item("MyDataNew"))
        End If
    End Function
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
    Private Function FilterDataAI(ByVal dtIn As PhoenixArtDataset.getItemwithAvialableInventoryDataTable) As List(Of PhoenixArtDataset.getItemwithAvialableInventoryRow)
        Dim ReturnValue As List(Of PhoenixArtDataset.getItemwithAvialableInventoryRow) = Nothing
        Dim Result As List(Of PhoenixArtDataset.getItemwithAvialableInventoryRow) = Nothing

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

        If ItemCode Is Nothing Then
        Else
            Dim query = From c In Result _
                        Where c.ItemCode = ItemCode _
                        Select c

            If query Is Nothing Then
            Else
                Result = query.ToList
            End If
        End If

        ReturnValue = SortDataAI(Result)
        Return ReturnValue
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

        If ItemCode Is Nothing Then
        Else
            Dim query = From c In Result _
                        Where c.ItemCode = ItemCode _
                        Select c

            If query Is Nothing Then
            Else
                Result = query.ToList
            End If
        End If

        ReturnValue = SortData(Result)
        Return ReturnValue
    End Function
    Private Function SortDataAI(ByVal InData As List(Of PhoenixArtDataset.getItemwithAvialableInventoryRow)) As List(Of PhoenixArtDataset.getItemwithAvialableInventoryRow)
        Dim ReturnValue As List(Of PhoenixArtDataset.getItemwithAvialableInventoryRow)


        If SortOrder = "Artist" Then
            Dim q = From c In InData Order By c.ArtistName, c.ItemDescription Select c
            ReturnValue = q.ToList
        ElseIf SortOrder = "Medium" Then
            Dim q = From c In InData Order By c.Medium, c.ItemDescription Select c
            ReturnValue = q.ToList
        ElseIf SortOrder = "Style" Then
            Dim q = From c In InData Order By c.Style, c.ItemDescription Select c
            ReturnValue = q.ToList
        ElseIf SortOrder = "ItemCode" Then
            Dim q = From c In InData Order By c.ItemCode, c.ItemDescription Select c
            ReturnValue = q.ToList
        ElseIf SortOrder = "ItemDescription" Then
            Dim q = From c In InData Order By c.ItemDescription Select c
            ReturnValue = q.ToList

        ElseIf SortOrder = "Subject" Then
            Dim q = From c In InData Order By c.Subject Select c
            ReturnValue = q.ToList
        ElseIf SortOrder = "Largesttosmallestsize" Then
            Dim q = From c In InData Order By c.SizeSortOrder Descending Select c
            ReturnValue = q.ToList
        ElseIf SortOrder = "Smallesttolargestsize" Then
            Dim q = From c In InData Order By c.SizeSortOrder Ascending Select c
            ReturnValue = q.ToList
        Else
            Dim q = From c In InData Order By c.AddDate Descending, c.ItemDescription Select c
            ReturnValue = q.ToList
        End If

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
            Dim q = From c In InData Order By c.AddDate Descending Select c
            ReturnValue = q.ToList
        End If

        Return ReturnValue
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim IDPart As Int32 = 0
        Dim ShowPrice As Int32 = 0
        Dim ShowWatermark As Int32 = 0
        'Dim Details As ASP.controls_ctldetails_ascx = Nothing

        If Not Page.Request.QueryString("IsWindow") Is Nothing Then
            IsWindow = Request.QueryString("IsWindow").ToString()
        Else
            IsWindow = "0"
        End If
        If Page.Request.QueryString("ID") Is Nothing Then
            Try
                If Request.QueryString("GID") IsNot Nothing Then
                    GalleryID = Convert.ToInt32(Request.QueryString("GID"))
                Else
                    If Session("Details.GalleryID") Is Nothing Then
                        GalleryID = 0
                    Else
                        If Session("Details.GalleryID") > 0 Then
                            GalleryID = Session("Details.GalleryID")
                        Else
                            GalleryID = 0
                        End If
                    End If
                End If

                If Request.QueryString("AI") Is Nothing Then
                    ListView1.DataSource = GetData()
                Else
                    ListView1.DataSource = GetDataAI()
                End If
                ListView1.DataBind()

                'Details = ListView1.Items(0).FindControl("details1")

                'If Details Is Nothing Then
                'Else
                '    If ListView1.Items.Count > 1 Then
                '        Details.GetLineBreak = "LineBreak"
                '    Else
                '        Details.GetLineBreak = "NoLineBreak"
                '    End If
                'End If
            Catch ex As Exception

            End Try
        Else
            Dim QStr As String = Page.Request.QueryString("ID")

            If QStr.Trim.Length > 0 Then
                QStr = Encoding.UTF8.GetString(Convert.FromBase64String(QStr))
                QStr = KitFramework.Cryptography.TripleDes.Decrypt(QStr)

                IDPart = InStr(QStr, "&")
                If IDPart > 0 Then
                    ItemCode = Mid$(QStr, 1, IDPart - 1)
                End If

                IDPart = InStr(QStr, "SP=")

                If IDPart > 0 Then
                    ShowPrice = CInt(Mid$(QStr, IDPart + 3, 1))
                    If ShowPrice = 1 Then
                        Session("Details.ShowPrices") = True
                    Else
                        Session("Details.ShowPrices") = False
                    End If
                End If

                IDPart = InStr(QStr, "WM=")

                If IDPart > 0 Then
                    ShowWatermark = CInt(Mid$(QStr, IDPart + 3, 1))
                    If ShowWatermark = 1 Then
                        Session("Details.ShowWatermarks") = True
                    Else
                        Session("Details.ShowWatermarks") = False
                    End If
                End If

                If Request.QueryString("AI") Is Nothing Then
                    ListView1.DataSource = GetData()
                Else
                    ListView1.DataSource = GetDataAI()
                End If
                ListView1.DataBind()
                'If ListView1.Items.Count > 0 Then
                '    Details = ListView1.Items(0).FindControl("details1")

                'End If


                'If Details Is Nothing Then
                'Else
                '    If ListView1.Items.Count > 1 Then
                '        Details.GetLineBreak = "LineBreak"
                '    Else
                '        Details.GetLineBreak = "NoLineBreak"
                '    End If

                'End If
            Else
                GalleryID = 0
                If Request.QueryString("AI") Is Nothing Then
                    ListView1.DataSource = GetData()
                Else
                    ListView1.DataSource = GetDataAI()
                End If
                ListView1.DataBind()
            End If
        End If
    End Sub

    

End Class
