<cfcomponent>

	<cfset variables.name = "flickrPics">
	<cfset variables.id = "com.visual28.mango.plugins.flickrPics">
	<cfset variables.package = "com/visual28/mango/plugins/flickrPics"/>

	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset var blogid = arguments.mainManager.getBlog().getId() />
			<cfset var path = blogid & "/" & variables.package />
			<cfset variables.preferencesManager = arguments.preferences />
			<cfset variables.manager = arguments.mainManager />
			
			<cfset variables.flickrID = variables.preferencesManager.get(path,"flickrID","") />
			<cfset variables.flickrTags = variables.preferencesManager.get(path,"flickrTags","") />
			<cfset variables.flickrCount = variables.preferencesManager.get(path,"flickrCount","6") />
			<cfset variables.photoSize = variables.preferencesManager.get(path,"photoSize","thumbnail") />
			<cfset variables.flickrTitle = variables.preferencesManager.get(path,"flickrTitle","") />
			<cfset variables.beforeIMG = variables.preferencesManager.get(path,"beforeIMG","") />
			<cfset variables.afterIMG = variables.preferencesManager.get(path,"afterIMG","") />
			<cfset variables.title = variables.preferencesManager.get(path,"podTitle","Flickr Photos") />
			
		<cfreturn this/>
	</cffunction>

	
	<cffunction name="getName" access="public" output="false" returntype="string">
		<cfreturn variables.name />
	</cffunction>


	<cffunction name="setName" access="public" output="false" returntype="void">
		<cfargument name="name" type="string" required="true" />
		<cfset variables.name = arguments.name />
		<cfreturn />
	</cffunction>

	
	<cffunction name="getId" access="public" output="false" returntype="any">
		<cfreturn variables.id />
	</cffunction>
	
	
	<cffunction name="setId" access="public" output="false" returntype="void">
		<cfargument name="id" type="any" required="true" />
		<cfset variables.id = arguments.id />
		<cfreturn />
	</cffunction>
	
	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">

		<cfreturn "flickr pics plugin activated. Would you like to <a href='generic_settings.cfm?event=showFlickrSettings&amp;owner=flickrPics&amp;selected=showFlickrSettings'>configure it now</a>?" />
	</cffunction>
	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn />
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="remove" hint="This is run when a plugin is removed" access="public" output="false" returntype="any">
		<cfset var blogid = arguments.mainManager.getBlog().getId() />
		
		<cfset variables.preferencesManager.removeNode(blogid & "/" & variables.package) />
		
		<cfreturn "Removed Flickr Pictures Plugin" />
	</cffunction>	

	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			<cfset var flickrPics = "" />
			<cfset var data = ""/>
			<cfset var eventName = arguments.event.name />
			<cfset var pod = "" />
			<cfset var content = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			<cfset var path = "" />
			<cfset var XMLContent = "" />
			<cfset var cfhttp = "" />
			
			<cfif eventName EQ "getPods">
				<cfset pod = cacheCallback("com.visual28.FlickrPics", CreateTimeSpan(0,0,20,0), this.getFlickrData)/>
				<cfset arguments.event.addPod(pod)>
						
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "flickrPics">
				<cfset link.page = "settings" />
				<cfset link.title = "Flickr Pics" />
				<cfset link.eventName = "showFlickrSettings" />
				
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showFlickrSettings" AND variables.manager.isCurrentUserLoggedIn()>
				<cfset data = arguments.event.getData() />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset path = variables.manager.getBlog().getId() & "/" & variables.package />
					
					<cfset variables.flickrID = data.externaldata.flickrID />
					<cfset variables.preferencesManager.put(path,"flickrID",variables.flickrID) />
					
					<cfset variables.flickrTags = data.externaldata.flickrTags />
					<cfset variables.preferencesManager.put(path,"flickrTags",variables.flickrTags) />
					
					<cfset variables.flickrCount = data.externaldata.flickrCount />
					<cfset variables.preferencesManager.put(path,"flickrCount",variables.flickrCount) />
					
					<cfset variables.photoSize = data.externaldata.photoSize />
					<cfset variables.preferencesManager.put(path,"photoSize",variables.photoSize) />
					
					<cfset variables.flickrTitle = data.externaldata.flickrTitle />
					<cfset variables.preferencesManager.put(path,"flickrTitle",variables.flickrTitle) />
					
					<cfset variables.beforeIMG = data.externaldata.beforeIMG />
					<cfset variables.preferencesManager.put(path,"beforeIMG",variables.beforeIMG) />
					
					<cfset variables.afterIMG = data.externaldata.afterIMG />
					<cfset variables.preferencesManager.put(path,"afterIMG",variables.afterIMG) />
					
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") /> 
					<cfset data.message.settext("flickr info updated successfully")/>
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("flickrPics Settings") />
					<cfset data.message.setData(page) />
			
			<cfelseif eventName EQ "getPodsList"><!--- no content, just title and id --->
				<cfset pod = structnew() />
				<cfset pod.title = "Flickr Photos" />
				<cfset pod.id = "flickrPics" />
				<cfset arguments.event.addPod(pod)>
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>

	<cffunction name="getFlickrData" output="false" returntype="struct">
		<cfset var flickrPics = "" />
		<cfset var data = ""/>
		<!---<cfset var eventName = arguments.event.name />--->
		<cfset var pod = "" />
		<cfset var content = "" />
		<cfset var link = "" />
		<cfset var page = "" />
		<cfset var path = "" />
		<cfset var XMLContent = "" />
		<cfset var cfhttp = "" />
		<cfhttp url="http://api.flickr.com/services/feeds/photos_public.gne?id=#variables.flickrID#&tags=#variables.flickrTags#&lang=en-us&format=rss_200" method="GET" timeout="10"></cfhttp>
		
			<cfif cfhttp.StatusCode eq "200 OK">   
				
				<cfscript>
					XMLContent = trim(cfhttp.filecontent);
					XMLContent = XMLParse(XMLContent);
				</cfscript>
				
				<cfsavecontent variable="flickrPics">
				<cfoutput><div id="flickr"></cfoutput>
					<cfloop from="1" to="#variables.flickrCount#" index="i">
						<cfoutput>
						<cfif variables.beforeIMG neq "">#variables.beforeIMG#</cfif>
						<a href="#XMLContent.rss.channel.item[i].link.xmlText#" title="#XMLContent.rss.channel.item[i].title.xmlText#">
							<cfif variables.photoSize eq "thumbnail"><img src='#XMLContent.rss.channel.item[i]["media:thumbnail"].xmlattributes.url#' alt='#XMLContent.rss.channel.item[i].title.xmlText#' /></cfif>
							<cfif variables.photoSize eq "medium"><img src='#XMLContent.rss.channel.item[i]["media:content"].xmlattributes.url#' alt='#XMLContent.rss.channel.item[i].title.xmlText#' /></cfif>
						</a><cfif variables.afterIMG neq "">#variables.afterIMG#</cfif>
						</cfoutput>
					</cfloop>
				<cfoutput></div></cfoutput>
				</cfsavecontent>
				
			<cfelse>   
				
				<cfsavecontent variable="flickrPics"><cfoutput>
				<p>Error retreiving data</p>
				</cfoutput></cfsavecontent>
				 
			</cfif> 
		
		<cfset pod = structnew() />
		<cfset pod.title = variables.flickrTitle />
		<cfset pod.content = flickrPics />
		<cfset pod.id = "flickrPics" />
		
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