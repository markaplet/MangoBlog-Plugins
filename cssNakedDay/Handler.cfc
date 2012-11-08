<cfcomponent extends="BasePlugin">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset setManager(arguments.mainManager) />
			<cfset setPreferencesManager(arguments.preferences) />
			<cfset setPackage("com/visual28/mango/plugins/cssNakedDay") />
			
			<cfset initSettings(
					cssNakedDayMessage = ""
				) />
		
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		
		<cfreturn "<strong>Thanks for participating in CSS Naked Day on April 9th!</strong> <br> 
		Feel free to <a href='generic_settings.cfm?event=showCSSNakedDaySettings&amp;owner=cssNakedDay&amp;selected=showCSSNakedDaySettings'>customize your message</a> or preview the default notice." />
	</cffunction>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "CSS Naked Day Plugin Deactivated! Was it something I said? Have problems? For support go to <a href='http://www.visual28.com'>www.visual28.com</a>" />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			
			<cfset var removeScripts = "" />
			<cfset var addMessage = "" />
			<cfset var cssNakedDayMessage = "" />
			<cfset var data =  "" />
			<cfset var eventName = arguments.event.name />
			
			<cfif eventName EQ "beforeHtmlHeadEnd">	
			
				<cfif day(now()) eq 9 and month(now()) eq 4>
				
					<cfsavecontent variable="removeScripts"><cfoutput>
					<script language="javascript">
					for ( i=0; i<document.styleSheets.length; i++) {
						void(document.styleSheets.item(i).disabled=true);
					}
					</script>
					</cfoutput></cfsavecontent>
					
					<cfset data = arguments.event.outputData />
					<cfset data = data & removeScripts />
					<cfset arguments.event.outputData = data />
					
				</cfif>	
				
			
			<cfelseif eventName EQ "beforeHtmlBodyStart">
			
				<cfif day(now()) eq 9 and month(now()) eq 4>
				
					<cfsavecontent variable="addMessage"><cfoutput>
						<cfif getSetting("cssNakedDayMessage") neq "">
						#getSetting("cssNakedDayMessage")#
						<cfelse><div id="naked" style="background:##ffc;padding:5px;color:##900;">
						<h3>What happened to the design?</h3>
						<p>To know more about why styles are disabled on this website visit the
						<a href="http://naked.dustindiaz.com" title="Web Standards Naked Day Host Website">Annual CSS Naked Day</a> website for more information.</p></div>
						</cfif>
					</cfoutput></cfsavecontent>
					
					<cfset data = arguments.event.outputData />
					<cfset data = data & addMessage />
					<cfset arguments.event.outputData = data />
					
				</cfif>		
					
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "cssNakedDay">
				<cfset link.page = "settings" />
				<cfset link.title = "CSS Naked Day" />
				<cfset link.eventName = "showCSSNakedDaySettings" />
				
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showCSSNakedDaySettings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(
							cssNakedDayMessage = data.externaldata.cssNakedDayMessage
						) />
					<cfset persistSettings() />
					
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("CSS Naked Day Setting Updated")/>
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("CSS Naked Day Settings") />
					<cfset data.message.setData(page) />
			
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>