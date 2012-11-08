<cfcomponent extends="BasePlugin">

<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: INITIALIZE PLUGIN ::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		<cfset setManager(arguments.mainManager) />
		<cfset setPreferencesManager(arguments.preferences) />
		<cfset setPackage("com/visual28/mango/plugins/anchorfader") />
		
				<cfset initSettings(
					fadeTargetElement = "ul.links li",
					fadeStartColor = "black"
				) />
				
		<cfreturn this/>
	</cffunction>

<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: SETUP ::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		<cfreturn "<strong>Anchor Fader has been activated:</strong>" />
	</cffunction>
	
<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: UNSETUP ::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "<strong>Anchor Fader has been deactivated</strong>" />
	</cffunction>

<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: EVENT HANDLER ::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: PROCESS EVENTS ::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />
		<cfset var anchorFaderScript = "" />
		<cfset var fadeTargetElement = "" />
		<cfset var fadeStartColor = "" />
		<cfset var data =  "" />
		<cfset var eventName = arguments.event.name />
		<cfif eventName EQ "beforeHtmlHeadEnd">	
			
			<cfsavecontent variable="anchorFaderScript">
			<cfoutput>
<script type="text/javascript">
	function fadeElements(color) {
		var count = $("#getSetting('fadeTargetElement')#").size();
		var step = 90 / count;
			
		$("#getSetting('fadeTargetElement')#").each(function(i) {
		var value = 100 - (step * i);
			$(this).find("a").css("color", color).css("opacity", value == 100 ? "1" : "0." + parseInt(value));
		});
	}
	
		$(document).ready(function() {
		fadeElements("#getSetting('fadeStartColor')#");
	});
</script>
			</cfoutput>
			</cfsavecontent>
			<cfset data = arguments.event.outputData />
			<cfset data = data & anchorFaderScript />
			<cfset arguments.event.outputData = data />
	
		<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "anchorfader">
				<cfset link.page = "settings" />
				<cfset link.title = "Anchor Fader" />
				<cfset link.eventName = "showAnchorFaderSettings" />
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showAnchorFaderSettings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(
							fadeTargetElement = data.externaldata.fadeTargetElement,
							fadeStartColor = data.externalData.fadeStartColor
						) />
					
					<cfset persistSettings() />
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("Anchor Fader Settings Updated") />
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("Anchor Fader Settings") />
					<cfset data.message.setData(page) />

			</cfif>
			
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>