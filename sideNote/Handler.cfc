<cfcomponent>


	<cfset variables.name = "sideNote">
	<cfset variables.id = "com.visual28.mango.plugins.sideNote">
	<cfset variables.package = "com/visual28/mango/plugins/sideNote"/>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset var blogid = arguments.mainManager.getBlog().getId() />
			<cfset var path = blogid & "/" & variables.package />
			<cfset variables.preferencesManager = arguments.preferences />
			<cfset variables.manager = arguments.mainManager />
			<cfset variables.sideNoteContent = variables.preferencesManager.get(path,"sideNoteContent","") />
			<cfset variables.title = variables.preferencesManager.get(path,"podTitle","") />
		
			
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
		<cfset variables.preferencesManager.put(path,"sideNoteContent","") />
		
		<cfreturn "The sideNote plugin activated. Would you like to <a href='generic_settings.cfm?event=showSideNoteSettings&amp;owner=sideNote&amp;selected=showSideNoteSettings'>configure it now</a>?" />
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

			<cfset var sideNoteContent = "" />
			<cfset var outputData = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			<cfset var data = ""/>
			<cfset var path = "" />
			<cfset var admin = "" />
			<cfset var eventName = arguments.event.name />
			
			<cfif eventName EQ "getPods">
				<cfset outputData =  arguments.event.getOutputData() />
					
				<cfsavecontent variable="sideNoteContent"><cfoutput>
					<cfif variables.sideNoteContent neq "">#variables.sideNoteContent#"</cfif>
				</cfoutput></cfsavecontent>
				<cfset arguments.event.setOutputData(outputData & sideNoteContent) />
				
				<cfset pod = structnew() />
				<cfset pod.title = variables.title />
				<cfset pod.content = variables.sideNoteContent />
				<cfset pod.id = "sideNote" />
				<cfset arguments.event.addPod(pod)>
			
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "sideNote">
				<cfset link.page = "settings" />
				<cfset link.title = "sideNote" />
				<cfset link.eventName = "showSideNoteSettings" />
				
				<cfset arguments.event.addLink(link)>
			
			<!--- admin event --->
			<cfelseif eventName EQ "showSideNoteSettings">
				<cfset data = arguments.event.getData() />				
				<cfif structkeyexists(data.externaldata,"apply")>
					<cfset variables.sideNoteContent = data.externaldata.sideNoteContent />
					
					<cfset path = variables.manager.getBlog().getId() & "/" & variables.package />
					<cfset variables.preferencesManager.put(path,"sideNoteContent",variables.sideNoteContent) />
			
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("sideNote updated successfully")/>
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("sideNote Settings") />
					<cfset data.message.setData(page) />
			
			<cfelseif eventName EQ "getPodsList"><!--- no content, just title and id --->
				<cfset pod = structnew() />
				<cfset pod.title = "sideNote" />
				<cfset pod.id = "sideNote" />
				<cfset arguments.event.addPod(pod)>
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>