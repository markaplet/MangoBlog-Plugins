<cfcomponent extends="BasePlugin">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset setManager(arguments.mainManager) />
			<cfset setPreferencesManager(arguments.preferences) />
			<cfset setPackage("com/visual28/mango/plugins/sIFR3") />
			
			<cfset initSettings(
					sifr3Selector = "h2",
					sifr3Font = "gipsiero",
					sifr3AdvancedCSS = ""
				) />
		
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		
		<cfreturn "Congratulation the sIFR3 plugin activated! sIFR3 Will need to be setup before it will work. Would you like to <a href='generic_settings.cfm?event=showSIFR3Settings&amp;owner=sIFR3&amp;selected=showSIFR3Settings'>configure it now</a>?" />
	</cffunction>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "Deactivated sIFR3 Plugin: Was it something I said? Have problems with it? For support go to <a href='http://www.visual28.com'>www.visual28.com</a>" />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			
			<cfset var sIFR3scripts = "" />
			<cfset var data =  "" />
			<cfset var eventName = arguments.event.name />
			
			<cfif eventName EQ "beforeHtmlHeadEnd">	
			
				<cfsavecontent variable="sIFR3scripts"><cfoutput><link rel="stylesheet" href="#getAssetPath()#sifr.css" type="text/css">
				<script type="text/javascript" src="#getAssetPath()#sifr.js"></script>
				<script type="text/javascript">
					var #getSetting("sifr3Font")# = { src: '#getAssetPath()##getSetting("sifr3Font")#.swf' };
						sIFR.activate(#getSetting("sifr3Font")#);
						sIFR.replace(#getSetting("sifr3Font")#, {
							selector: '#getSetting("sifr3Selector")#'
							<cfif getSetting("sifr3AdvancedCSS") neq "">
							,css: [	#getSetting("sifr3AdvancedCSS")# ]</cfif>
					});
				</script>
				</cfoutput></cfsavecontent>
				
				<cfset data = arguments.event.outputData />
				<cfset data = data & sIFR3scripts />
				<cfset arguments.event.outputData = data />
					
					
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "sIFR3">
				<cfset link.page = "settings" />
				<cfset link.title = "sIFR3" />
				<cfset link.eventName = "showSIFR3Settings" />
				
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showSIFR3Settings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(
							sifr3Selector = data.externaldata.sifr3Selector,
							sifr3Selector = data.externaldata.sifr3Selector,
							sifr3AdvancedCSS = data.externaldata.sifr3AdvancedCSS
						) />
					<cfset persistSettings() />
					
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("sIFR3 setting updated")/>
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("sIFR3 settings") />
					<cfset data.message.setData(page) />
			
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>