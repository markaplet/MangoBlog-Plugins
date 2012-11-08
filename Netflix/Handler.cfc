<cfcomponent extends="BasePlugin">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset setManager(arguments.mainManager) />
			<cfset setPreferencesManager(arguments.preferences) />
			<cfset setPackage("com/visual28/mango/plugins/netflix") />
			
			<cfset initSettings(
					netflixTitle = "Netflix Feed",
					netflixCount = "3",
					netflixFeedURL = ""
				) />
		
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		
		<cfreturn "Netflix plugin activated. Please <a href='generic_settings.cfm?event=showNetflixSettings&amp;owner=netflix&amp;selected=showNetflixSettings'>configure your settings now</a>." />
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

			<cfset var netflixOutput = "" />
			<cfset var retweetSelfFoot = "" />
			<cfset var retweetJS = "" />
			<cfset var data =  "" />
			<cfset var eventName = arguments.event.name />
			<cfset var pod = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			
			<cfif eventName EQ "getPods">
				
				<!--- make sure we can add this to the pods list --->
				<cfif event.allowedPodIds EQ "*" OR listfindnocase(event.allowedPodIds, "netflix")>
					
					<cfset pod = cacheCallback("com.visual28.Netflix", CreateTimeSpan(0,0,20,0), this.getNetflixData)/>
					<cfset arguments.event.addPod(pod)>
						
				</cfif>
			
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "netflix">
				<cfset link.page = "settings" />
				<cfset link.title = "Netflix" />
				<cfset link.eventName = "showNetflixSettings" />
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showNetflixSettings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(
							netflixTitle = data.externaldata.netflixTitle,
							netflixCount = data.externaldata.netflixCount,
							netflixFeedURL = data.externalData.netflixFeedURL
						) />
					
					<cfset persistSettings() />
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("Netflix Settings Updated") />
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("Netflix RSS Feed Settings") />
					<cfset data.message.setData(page) />
			
			<cfelseif eventName EQ "getPodsList"><!--- no content, just title and id --->
				<cfset pod = structnew() />
				<cfset pod.title = "Netflix RSS Feeds" />
				<cfset pod.id = "netflix" />
				<cfset arguments.event.addPod(pod)>
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>
	
	<cffunction name="getNetflixData" output="false" returntype="struct">
		<cfset var netflixOutput = "" />
		<cfset var data = ""/>
		<cfset var pod = "" />
		<cfset var content = "" />
		<cfset var link = "" />
		<cfset var page = "" />
		<cfset var path = "" />
		<cfset var XMLContent = "" />
		<cfset var cfhttp = "" />
		
		<cfset var netflixFeedURL = getSetting("netflixFeedURL")>
		<cfset var netflixCount = getSetting("netflixCount")>
		<cfset var netflixTitle = getSetting("netflixTitle")>
		
		<cfhttp url="#netflixFeedURL#" method="GET" timeout="10"></cfhttp>
		
			<cfif cfhttp.StatusCode eq "200 OK">   
				
				<cfscript>
					XMLContent = trim(cfhttp.filecontent);
					XMLContent = XMLParse(XMLContent);
				</cfscript>
				
				<cfsavecontent variable="netflixOutput">
				<cfoutput><ul class="netflix sidelist"><!---<cfif netflixTitle neq ""><h2>#netflixTitle#</h2></cfif>---></cfoutput>
					<cfloop from="1" to="#netflixCount#" index="i">
						<cfif isNumeric(left(XMLContent.rss.channel.item[i].title.xmlText, 3)) AND right(left(XMLContent.rss.channel.item[i].title.xmlText, 4), 1) EQ "-"><cfset titleFixed = trim(Listlast(XMLContent.rss.channel.item[i].title.xmlText, '-'))><cfelse><cfset titleFixed = #XMLContent.rss.channel.item[i].title.xmlText#></cfif>
						<cfoutput>
						<li><a href="#XMLContent.rss.channel.item[i].link.xmlText#">#left(titleFixed,60)#<CFIF len(titleFixed) GTE 60>...</CFIF></a></li>
						</cfoutput>
					</cfloop>
				<cfoutput></ul></cfoutput>
				</cfsavecontent>
				
			<cfelse>   
				
				<cfsavecontent variable="netflixOutput"><cfoutput>
				<p>Error retreiving data</p>
				</cfoutput></cfsavecontent>
				 
			</cfif> 
		
		<cfset pod = structnew() />
		<cfset pod.title = netflixTitle />
		<cfset pod.content = netflixOutput />
		<cfset pod.id = "netflix" />
		
		<cfreturn pod />
	</cffunction>
	
<cfscript>
	function cacheCallback(cacheKey, duration, callback){
		var data = "";
		//optional argument: forceRefresh
		if (arrayLen(arguments) eq 4){arguments.forceRefresh=arguments[4];}else{arguments.forceRefresh=false;}
		//clean cachekey of periods that will cause errors
		arguments.cacheKey = replace(arguments.cacheKey, ".", "_", "ALL");
		//ensure cache structure is setup
		if (not structKeyExists(application, "CCBCache")){application.CCBCache = StructNew();}
		if (not structKeyExists(application.CCBCache, arguments.cacheKey)){application.CCBCache[arguments.cacheKey] = StructNew();}
		if (not structKeyExists(application.CCBCache[arguments.cacheKey], "timeout")){application.CCBCache[arguments.cacheKey].timeout = dateAdd('yyyy',-10,now());}
		if (not structKeyExists(application.CCBCache[arguments.cacheKey], "data")){application.CCBCache[arguments.cacheKey].data = '';}
		//update cache if expired
		if (arguments.forceRefresh or dateCompare(now(), application.CCBCache[arguments.cacheKey].timeout) eq 1){
			data = arguments.callback();
			application.CCBCache[arguments.cacheKey].data = data;
			application.CCBCache[arguments.cacheKey].timeout = arguments.duration;
		}
		return application.CCBCache[arguments.cacheKey].data;
	}
</cfscript>
</cfcomponent>