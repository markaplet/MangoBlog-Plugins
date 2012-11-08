<cfcomponent extends="BasePlugin">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset setManager(arguments.mainManager) />
			<cfset setPreferencesManager(arguments.preferences) />
			<cfset setPackage("com/visual28/mango/plugins/EasyRetweet") />
			
			<cfset initSettings(
					retweetTitle = "Please Retweet",
					ReTweetPod = "disabled",
					ReTweetContentEnd = "enabled"
				) />
		
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		
		<cfreturn "Retweet plugin activated. The sidebar retweet function is enabled by default. You may wish to review the <a href='generic_settings.cfm?event=showRetweetSettings&amp;owner=easyRetweet&amp;selected=showRetweetSettings'>configuration options</a> for this plugin." />
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

			<cfset var retweetSelf = "" />
			<cfset var retweetSelfFoot = "" />
			<cfset var retweetJS = "" />
			<cfset var data =  "" />
			<cfset var eventName = arguments.event.name />
			<cfset var pod = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			
			<cfif eventName EQ "getPods">
				
				<!--- make sure we can add this to the pods list --->
				<cfif event.allowedPodIds EQ "*" OR listfindnocase(event.allowedPodIds, "easyRetweet")>
					<!--- check if the pod was enabled in the settings --->
					<cfif getSetting("ReTweetPod") eq "enabled">
						<cfsavecontent variable="retweetSelf"><cfoutput>
							<div id="retweetself"><a class="retweet vert self" href="Handler.cfc"></a><br style="clear:both;"></div>
						</cfoutput></cfsavecontent>
						
						<cfset pod = structnew() />
						<cfset pod.title = getSetting("retweetTitle") />	
						<cfset pod.content = retweetSelf />
						<cfset pod.id = "easyRetweet" />
						<cfset arguments.event.addPod(pod)>
					</cfif>
				</cfif>
			
			
			<cfelseif eventName EQ "beforeHtmlHeadEnd">	
				<cfsavecontent variable="retweetJS"><cfoutput>
				<script type="text/javascript" src="#getAssetPath()#retweet.js"></script>
				</cfoutput></cfsavecontent>
				
				<cfset data = arguments.event.outputData />
				<cfset data = data & retweetJS />
				<cfset arguments.event.outputData = data />
			
			
			<cfelseif eventName EQ "beforePostContentEnd">
				<cfif getSetting("ReTweetContentEnd") eq "enabled">
					
					<cfsavecontent variable="retweetSelfFoot"><cfoutput>
						<p><a class="retweet" href="#arguments.event.contextData.currentPost.getPermalink()#">#arguments.event.contextData.currentPost.getTitle()#</a></p>
					</cfoutput></cfsavecontent>	
					
					<cfset data = arguments.event.outputData />
					<cfset data = data & retweetSelfFoot />
					<cfset arguments.event.outputData = data />	
				</cfif>	
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "easyRetweet">
				<cfset link.page = "settings" />
				<cfset link.title = "Easy Retweet" />
				<cfset link.eventName = "showRetweetSettings" />
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showRetweetSettings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(
							retweetTitle = data.externaldata.retweetTitle,
							ReTweetPod = data.externaldata.ReTweetPod,
							ReTweetContentEnd = data.externalData.ReTweetContentEnd
						) />
					
					<cfset persistSettings() />
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("Retweet Settings Updated") />
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("Retweet Settings") />
					<cfset data.message.setData(page) />
			
			<cfelseif eventName EQ "getPodsList"><!--- no content, just title and id --->
				<cfset pod = structnew() />
				<cfset pod.title = "Resig Easy Retweet Button" />
				<cfset pod.id = "easyRetweet" />
				<cfset arguments.event.addPod(pod)>
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>