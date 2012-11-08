<cfcomponent>


	<cfset variables.name = "metaData">
	<cfset variables.id = "com.visual28.mango.plugins.metaData">
	<cfset variables.package = "com/visual28/mango/plugins/metaData"/>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset var blogid = arguments.mainManager.getBlog().getId() />
			<cfset var path = blogid & "/" & variables.package />
			<cfset variables.preferencesManager = arguments.preferences />
			<cfset variables.manager = arguments.mainManager />
			<cfset variables.metaKeywords = variables.preferencesManager.get(path,"metaKeywords","YOUR_KEYWORDS_HERE") />
			
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="getName" access="public" output="false" returntype="string">
		<cfreturn variables.name />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setName" access="public" output="false" returntype="void">
		<cfargument name="name" type="string" required="true" />
		<cfset variables.name = arguments.name />
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="getId" access="public" output="false" returntype="any">
		<cfreturn variables.id />
	</cffunction>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setId" access="public" output="false" returntype="void">
		<cfargument name="id" type="any" required="true" />
		<cfset variables.id = arguments.id />
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		<cfset var path = variables.manager.getBlog().getId() & "/" & variables.package />
		<cfset variables.preferencesManager.put(path,"metaKeywords","YOUR_KEYWORDS_HERE") />
		
		<cfreturn "MetaData plugin activated. Would you like to <a href='generic_settings.cfm?event=showMetaSettings&amp;owner=metaData&amp;selected=showMetaSettings'>configure it now</a>?" />
	</cffunction>
	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			<cfset var metaKeywords = "" />
			<cfset var outputData = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			<cfset var data = ""/>
			<cfset var path = "" />
			<cfset var admin = "" />
			<cfset var eventName = arguments.event.name />
			
			<cfif eventName EQ "beforeHtmlHeadEnd">
				<cfset outputData =  arguments.event.getOutputData() />
					
				<cfsavecontent variable="metaKeywords"><cfoutput>
					<cfif variables.metaKeywords neq ""><meta name="keywords" content="#variables.metaKeywords#" /></cfif>
				</cfoutput></cfsavecontent>
				<cfset arguments.event.setOutputData(outputData & metaKeywords) />
			

				
			<!--- admin dashboard event --->
			<cfelseif eventName EQ "dashboardPod">			
				<cfif variables.metaKeywords EQ "YOUR_KEYWORDS_HERE">
					<!--- add a pod warning about missing twitter info --->
				
					<cfsavecontent variable="outputData">
					<cfoutput><p class="error">You have not entered any meta data. Would you link to <a href="generic_settings.cfm?event=showMetaSettings&amp;owner=metaData&amp;selected=showmetaSettings">configure it now?</a></p>
					</cfoutput>
					</cfsavecontent>			
					
					<cfset data = structnew() />
					<cfset data.title = "Meta Data" />
					<cfset data.content = outputData />
					<cfset arguments.event.addPod(data)>
				</cfif>
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "metaData">
				<cfset link.page = "settings" />
				<cfset link.title = "Meta Data" />
				<cfset link.eventName = "showMetaSettings" />
				
				<cfset arguments.event.addLink(link)>
			
			<!--- admin event --->
			<cfelseif eventName EQ "showMetaSettings">
				<cfset data = arguments.event.getData() />				
				<cfif structkeyexists(data.externaldata,"apply")>
					<cfset variables.metaKeywords = data.externaldata.metaKeywords />
					
					<cfset path = variables.manager.getBlog().getId() & "/" & variables.package />
					<cfset variables.preferencesManager.put(path,"metaKeywords",variables.metaKeywords) />
				
					
					<!--- this is a hack, just try to get the currently authenticated user --->
					<cftry>
						<cfif structkeyexists(session,"author")>
							<cfset variables.manager.getAdministrator().pluginUpdated(
									"twitter", variables.id, session.author) />
						</cfif>
						<cfcatch type="any"></cfcatch>
					</cftry>
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("Meta data updated")/>
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("Meta Data Settings") />
					<cfset data.message.setData(page) />
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>