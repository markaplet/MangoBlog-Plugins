<cfcomponent extends="BasePlugin">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset setManager(arguments.mainManager) />
			<cfset setPreferencesManager(arguments.preferences) />
			<cfset setPackage("com/visual28/mango/plugins/honeypot") />
			
			<cfset initSettings(
				honeypotURL = "", 
				honeypotPromote = "none", 
				honeypotBadgeURL = "", 
				honeypotRefNumber = "60023",
				honeypotTitle = ""
			) />
		
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		
		<cfreturn "Project Honeypot plugin activated. Please <a href='generic_settings.cfm?event=showHoneypotSettings&amp;owner=honeypot&amp;selected=showHoneypotSettings'>configure it now</a>" />
	</cffunction>
	
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "Plugin Deactivated" />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			<cfset var honeypotPromote = "" />
			<cfset var honeypotLink = "" />
			<cfset var data =  "" />
			<cfset var eventName = arguments.event.name />
			<cfset var pod = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			<cfset var hiddenLink = randrange(1, 9)>
			<cfset var thisIndex = "" />
			<cfset var thisString = "" />
			<cfset var stringlist = "commerce-broadgauge,apparatus,frosted-timber,occurrence-face,impotent-gastropod,truncated-rock,imported-ancestor,comparable,transitive,monaural,openmouthed,metre,inorganic,ambiguous,overwrought,witted,excess,respective-eponymous,sostenuto,generalpurpose,impediments,draw-trap,amazing,standup,bawdy-bulbous,stigmatic-wool,viral-abdomen,trabeated-promotion,entrails,punishment-molecule,pushbutton,disc-crystalline,leash-environment,assurance,denominative-lowborn,removed-superheterodyne,groggy,thunderous,such,fabian,masquerade-peaceful,flocculent-atempo,highpitched,daylight,maximal-condition,freeliving-pendular,periodical,abolition-dr,community,bushy,sufficient,grouping,predator,pentavalent-vertebrate,supreme-blast">
			
			<cfset currentListLength = listlen(stringlist,',') />
			<cfset thisIndex = randrange(1,currentListLength) />
			<cfset thisString = listgetat(stringlist,thisIndex,',') />
			
			
			<cfif eventName EQ "getPods">
				
				<!--- make sure we can add this to the pods list --->
				<cfif event.allowedPodIds EQ "*" OR listfindnocase(event.allowedPodIds, "honeypot")>
					<cfsavecontent variable="honeypotPromote"><cfoutput>
						<cfif getSetting("honeypotPromote") eq "large">
							<a href="http://www.projecthoneypot.org/?rf=#getSetting("honeypotRefNumber")#" class="honeypotbadge"><img src="#getAssetPath()#project_honey_pot_button.gif" alt="Project Honey Pot" /></a>
						<cfelseif getSetting("honeypotPromote") eq "mini">
							<a href="http://www.projecthoneypot.org/?rf=#getSetting("honeypotRefNumber")#" class="honeypotbadge"><img src="#getAssetPath()#mini_phpot_link.gif" alt="Project Honey Pot" /></a>
						<cfelseif getSetting("honeypotPromote") eq "custom">
							<a href="http://www.projecthoneypot.org/?rf=#getSetting("honeypotRefNumber")#" class="honeypotbadge"><img src="#getSetting("honeypotBadgeURL")#" alt="Project Honey Pot" /></a>
						</cfif>
						
					</cfoutput></cfsavecontent>
						
					<cfset pod = structnew() />
					<cfset pod.title = getSetting("honeypotTitle") />
					<cfset pod.content = honeypotPromote />	
					<cfset pod.id = "honeypot" />
					<cfset arguments.event.addPod(pod)>
				</cfif>
			
			
			<cfelseif eventName EQ "beforeHtmlBodyEnd">	
				<cfsavecontent variable="honeypotLink"><cfoutput>
					<cfparam name="hiddenLink" default="#randrange(1, 9)#">
					<cfif hiddenLink is "1">
							<a href="#getSetting("honeypotURL")#"><!-- #thisString# --></a>
						<cfelseif hiddenLink is "2">
							<a href="#getSetting("honeypotURL")#"><img src="#thisString#.gif" height="1" width="1" border="0"></a>
						<cfelseif hiddenLink is "3">
							<a href="#getSetting("honeypotURL")#" style="display: none;">#thisString#</a>
						<cfelseif hiddenLink is "4">
							<div style="display: none;"><a href="#getSetting("honeypotURL")#">#thisString#</a></div>
						<cfelseif hiddenLink is "5">
							<a href="#getSetting("honeypotURL")#"></a>
						<cfelseif hiddenLink is "6">
							<!-- <a href="#getSetting("honeypotURL")#">#thisString#</a> -->
						<cfelseif hiddenLink is "7">
							<div style="position: absolute; top: -250px; left: -250px;"><a href="#getSetting("honeypotURL")#">#thisString#</a></div>
						<cfelseif hiddenLink is "8">
							<a href="#getSetting("honeypotURL")#"><span style="display: none;">#thisString#</span></a>
						<cfelseif hiddenLink is "9">
							<a href="#getSetting("honeypotURL")#"><div style="height: 0px; width: 0px;"></div></a>
					</cfif>
				</cfoutput></cfsavecontent>
				
				<cfset data = arguments.event.outputData />
				<cfset data = data & honeypotLink />
				<cfset arguments.event.outputData = data />
			
			
			
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "honeypot">
				<cfset link.page = "settings" />
				<cfset link.title = "Honeypot" />
				<cfset link.eventName = "showHoneypotSettings" />
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showHoneypotSettings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(
							honeypotURL = data.externaldata.honeypotURL,
							honeypotPromote = data.externaldata.honeypotPromote,
							honeypotBadgeURL = data.externaldata.honeypotBadgeURL,
							honeypotRefNumber = data.externaldata.honeypotRefNumber
						) />
					
					<cfset persistSettings() />
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("Honeypot Settings Updated") />
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("Honeypot Settings") />
					<cfset data.message.setData(page) />
			
			<cfelseif eventName EQ "getPodsList"><!--- no content, just title and id --->
				<cfset pod = structnew() />
				<cfset pod.title = "Honeypot" />
				<cfset pod.id = "honeypot" />
				<cfset arguments.event.addPod(pod)>
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>