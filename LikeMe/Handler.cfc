<cfcomponent extends="BasePlugin">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset setManager(arguments.mainManager) />
			<cfset setPreferencesManager(arguments.preferences) />
			<cfset setPackage("com/visual28/mango/plugins/LikeMe") />
			
			<cfset initSettings(
					LayoutStyle = "standard",
					ShowFaces = "false",
					Width = "400",
					DisplayVerb = 'like',
					Font = 'verdana',
					ColorScheme = 'light',
					ShowPod = 'false',
					ShowPostFoot = 'true'
				) />
		
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		
		<cfreturn "plugin activated. Please <a href='generic_settings.cfm?event=showLikeMeSettings&amp;owner=LikeMe&amp;selected=showLikeMeSettings'>configure your settings now</a>." />
	</cffunction>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "Deactivated Plugin: Was it something I said? Have problems with it? For support go to <a href='http://www.visual28.com'>www.visual28.com</a>" />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			<cfset var LikeMeOutput = "" />
			<cfset var data =  "" />
			<cfset var pod = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			<cfset var eventName = arguments.event.name />
			<cfset outputData =  arguments.event.getOutputData() />
            <cfset blog = request.blogManager.getBlog() />
			
			<cfif eventName EQ "beforePostContentEnd">
				<cfsavecontent variable="LikeMeOutput"><cfoutput>
<iframe src="http://www.facebook.com/plugins/like.php?href=#arguments.event.contextData.currentPost.getPermalink()#&amp;layout=#getSetting("LayoutStyle")#&amp;show_faces=#getSetting("ShowFaces")#&amp;width=#getSetting("Width")#&amp;action=#getSetting("DisplayVerb")#&amp;font=#getSetting("Font")#&amp;colorscheme=#getSetting("ColorScheme")#&amp;height=<cfif getSetting("ShowFaces") eq true>80<cfelse>25</cfif>" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:#getSetting("Width")#px; height:<cfif getSetting("ShowFaces") eq true>80<cfelse>25</cfif>px;" allowTransparency="true"></iframe>
				</cfoutput></cfsavecontent>
				
				<cfset arguments.event.setOutputData(outputData & LikeMeOutput) />
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "LikeMe">
				<cfset link.page = "settings" />
				<cfset link.title = "LikeMe" />
				<cfset link.eventName = "showLikeMeSettings" />
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showLikeMeSettings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(
							LayoutStyle = data.externaldata.LayoutStyle,
							ShowFaces = data.externaldata.ShowFaces,
							Width = data.externalData.Width,
							DisplayVerb = data.externalData.DisplayVerb,
							Font = data.externalData.Font,
							ColorScheme = data.externalData.ColorScheme
						) />
					
					<cfset persistSettings() />
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("LikeMe Settings Updated") />
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("Facebook Like Button Settings") />
					<cfset data.message.setData(page) />
	
			</cfif>
		<cfreturn arguments.event />
	</cffunction>
	
</cfcomponent>