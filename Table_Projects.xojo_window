#tag Window
Begin Window Table_Projects
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Projects Table View"
   Visible         =   True
   Width           =   600
   Begin Listbox DataList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   360
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   0
      ScrollbarHorizontal=   True
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub myOpen()
		  '
		  ' set headings
		  '
		  DataList.HasHeading = True
		  DataList.ColumnCount = 15
		  DataList.ScrollBarHorizontal = True
		  DataList.ScrollBarVertical = True
		  '
		  DataList.Heading(0) = "ProjectID"    ' int(11)
		  '
		  DataList.Heading(1) = "Project"      ' text
		  '
		  DataList.Heading(2) = "Rate"         ' double
		  DataList.ColumnAlignment(2) = DataList.AlignRight
		  DataList.ColumnAlignmentOffset(2) = -10
		  '
		  DataList.Heading(3) = "ProjectName"  ' varchar(100)
		  '
		  DataList.Heading(4) = "OrderDate"    ' date
		  DataList.ColumnAlignment(4) = DataList.AlignCenter
		  '
		  DataList.Heading(5) = "StartTime"    ' datetime
		  DataList.ColumnAlignment(5) = DataList.AlignCenter
		  '
		  DataList.Heading(6) = "YesNo"        ' boolean
		  DataList.ColumnType(6) = ListBox.TypeCheckbox
		  DataList.ColumnAlignment(6) = DataList.AlignCenter
		  '
		  DataList.Heading(7) = "SmallInt"     ' smallint(6)
		  DataList.ColumnAlignment(7) = DataList.AlignRight
		  DataList.ColumnAlignmentOffset(7) = -10
		  '
		  DataList.Heading(8) = "SmallUnsig"   ' smallint(5) unsigned
		  DataList.ColumnAlignment(8) = DataList.AlignRight
		  DataList.ColumnAlignmentOffset(8) = -10
		  '
		  DataList.Heading(9) = "MediumInt"     ' mediumint(9)
		  DataList.ColumnAlignment(9) = DataList.AlignRight
		  DataList.ColumnAlignmentOffset(9) = -10
		  '
		  DataList.Heading(10) = "SimpleInt"    ' simpleint(11)
		  DataList.ColumnAlignment(10) = DataList.AlignRight
		  DataList.ColumnAlignmentOffset(10) = -10
		  '
		  DataList.Heading(11) = "CharX"        ' char(5)
		  '
		  DataList.Heading(12) = "TimeStamp"    ' timestamp
		  DataList.ColumnAlignment(12) = DataList.AlignCenter
		  '
		  DataList.Heading(13) = "Decimal"      ' decimal
		  DataList.ColumnAlignment(13) = DataList.AlignRight
		  DataList.ColumnAlignmentOffset(13) = -10
		  '
		  DataList.Heading(14) = "Year"         ' year(4)
		  DataList.ColumnAlignment(14) = DataList.AlignCenter
		  '
		  ' fill rows
		  '
		  If Not g_connected Then
		    g_status = "Connect to the database first."
		    Return
		  End If
		  '
		  DataList.DeleteAllRows
		  '
		  g_sql = "SELECT * FROM projects;"
		  l_Lastline = 0
		  '
		  Dim data As RecordSet
		  Dim ret As Boolean
		  '
		  ' dimension date fields (only yet)
		  '
		  Dim m_OrderDate As New Date
		  Dim m_StartTime As New Date
		  Dim m_TimeStamp As New Date
		  Dim m_Check As New CheckBox
		  '
		  ' data = g_db.SQLSelect("SET NAMES 'utf8';")
		  data = g_db.SQLSelect(g_sql)
		  
		  If g_db.Error Then
		    g_status = "DB Error: " + g_db.ErrorMessage
		    Return
		  End If
		  
		  If data <> Nil Then
		    While Not data.EOF
		      '
		      ' set date fields 
		      '
		      m_OrderDate = data.Field("OrderDate").DateValue
		      If m_OrderDate = Nil Then 
		        ret = ParseDate("01/01/1900",m_OrderDate)
		      End If
		      '
		      m_StartTime = data.Field("StartTime").DateValue
		      If m_StartTime = Nil Then 
		        ret = ParseDate("01/01/1900",m_StartTime)
		      End If
		      '
		      m_TimeStamp = data.Field("TimeStamp").DateValue
		      If m_TimeStamp = Nil Then 
		        ret = ParseDate("01/01/1900",m_TimeStamp)
		      End If
		      '
		      DataList.AddRow
		      DataList.Cell( DataList.LastIndex, 0 ) = CStr(data.Field ("ProjectID").IntegerValue)
		      DataList.Cell( DataList.LastIndex, 1 ) = data.Field("Project").StringValue.DefineEncoding(encodings.utf8)
		      DataList.Cell( DataList.LastIndex, 2 ) = CStr(data.Field("Rate").DoubleValue)
		      DataList.Cell( DataList.LastIndex, 3 ) = data.Field("ProjectName").StringValue.DefineEncoding(encodings.utf8)
		      DataList.Cell( DataList.LastIndex, 4 ) = m_OrderDate.AbbreviatedDate
		      DataList.Cell( DataList.LastIndex, 5 ) = m_StartTime.ShortTime
		      DataList.CellCheck( DataList.LastIndex, 6 ) = data.Field("YesNo").BooleanValue
		      DataList.Cell( DataList.LastIndex, 7 ) = CStr(data.Field("SmallInteger").Value)
		      DataList.Cell( DataList.LastIndex, 8 ) = CStr(data.Field("SmallIntUnsigned").Value)
		      DataList.Cell( DataList.LastIndex, 9 ) = CStr(data.Field("MediumInteger").Value)
		      DataList.Cell( DataList.LastIndex, 10 ) = CStr(data.Field("SimpleInt").Value)
		      DataList.Cell( DataList.LastIndex, 11 ) = data.Field("CharX").StringValue.DefineEncoding(encodings.utf8)
		      DataList.Cell( DataList.LastIndex, 12 ) = m_TimeStamp.ShortTime
		      DataList.Cell( DataList.LastIndex, 13 ) = CStr(data.Field("DecimalNumber").DoubleValue)
		      DataList.Cell( DataList.LastIndex, 14 ) = CStr(data.Field("Year").Value)
		      '
		      l_Lastline = l_Lastline + 1
		      data.MoveNext
		    Wend
		    data.Close
		  End If
		  
		  DataList.Selected(l_ActiveLine) = True
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		l_ActiveLine As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		l_Lastline As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events DataList
	#tag Event
		Sub Open()
		  l_ActiveLine = 0
		  myOpen
		End Sub
	#tag EndEvent
	#tag Event
		Sub DoubleClick()
		  Dim row As Integer
		  row = Me.RowFromXY(Me.MouseX - Me.Left , Me.MouseY - Me.Top)
		  Dim rv As New Record_Projects
		  l_ActiveLine = row
		  rv.myShow(Val(DataList.Cell(row, 0)))
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub KeyUp(Key As String)
		  ' MsgBox(Str(Asc(key)))
		  Select Case Asc(key)
		  Case 105,73, 63302
		    g_db.SQLExecute("INSERT INTO Projects (project) VALUES ('<new>')")
		    If g_db.Error Then
		      MsgBox("Database Error: " + g_db.ErrorMessage)
		    End If
		    myOpen
		    Dim rv As New Record_Projects
		    rv.myShow(Val(DataList.Cell(l_Lastline-1, 0)))
		    l_Activeline = l_Lastline-1
		  Case 100, 68, 127, 8
		    l_ActiveLine = DataList.ListIndex
		    g_db.SQLExecute("DELETE FROM Projects WHERE ProjectID=" + DataList.Cell(DataList.ListIndex, 0))
		    If g_db.Error Then
		      MsgBox("Database Error: " + g_db.ErrorMessage)
		    End If
		    l_ActiveLine = l_ActiveLine - 1
		    myOpen
		  Case 27
		    Self.close
		  Case 13 
		    l_ActiveLine = DataList.ListIndex
		    Dim rv As New Record_Projects
		    rv.myShow(Val(DataList.Cell(DataList.ListIndex, 0)))
		  End Select
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub GotFocus()
		  myOpen
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="l_ActiveLine"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
