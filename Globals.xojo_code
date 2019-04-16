#tag Module
Protected Module Globals
	#tag Method, Flags = &h0
		Sub OpenDatabase()
		  '#BeforeDatabaseConnection
		  
		  g_db = New MySQLCommunityServer
		  
		  g_db.Host = "127.0.0.1"
		  g_db.UserName = "capp"
		  g_db.Password = "capp"
		  g_db.DatabaseName = "test"
		  
		  If g_db.Connect Then
		    g_db.SQLExecute "SET NAMES 'utf8'"
		    g_connected = True
		    g_status = "Connected to MySQL"
		  Else
		    g_connected = False
		    g_status = "Error connecting to MySQL: " + g_db.ErrorMessage
		  End If
		  
		  '#AfterDatabaseConnection
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		g_connected As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		g_date As Date
	#tag EndProperty

	#tag Property, Flags = &h0
		g_db As MySQLCommunityServer
	#tag EndProperty

	#tag Property, Flags = &h0
		g_record As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		g_sql As String
	#tag EndProperty

	#tag Property, Flags = &h0
		g_status As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="g_connected"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="g_sql"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="g_status"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="g_record"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
