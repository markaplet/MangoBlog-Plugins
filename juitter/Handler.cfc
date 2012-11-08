<cfcomponent extends="BasePlugin">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		
			<cfset setManager(arguments.mainManager) />
			<cfset setPreferencesManager(arguments.preferences) />
			<cfset setPackage("com/visual28/mango/plugins/juitter") />
			
			<cfset initSettings(
					juitterTitle = "Twitter Reactions",
					juitterSearchType = "searchWord",
					juitterSearchObject = "mangoblog",
					juitterCount = "20",
					juitterLanguage = "EN",
					juitterReadMore = "Read it on Twitter",
					juitterOpenExternalLinks = "newWindow",
					juitterNameUser = "image",
					juitterLoadMSG = "Loading messages...",
					juitterImgName = "loader.gif",
					juitterFilter = "sex->*BAD word*,porn->*BAD word*,fuck->*BAD word*,shit->*BAD word*",
					juitterCSS = "
.twittList {margin:0;padding:0;}
.twittLI { list-style:none; margin:0; padding:5px 0 0 0; border-bottom:1px solid; }
.juitterAvatar { float:left; margin-right:5px; width:48px; ; height:48px; }
.jRM {float:right;clear:both}
.twittList SPAN.time{font-size:0.9em}"

				) />
		
		<cfreturn this/>
	</cffunction>

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		
		<cfreturn "Juitter plugin activated. You may wish to <a href='generic_settings.cfm?event=showJuitterSettings&amp;owner=juitter&amp;selected=showJuitterSettings'>configure it now</a>" />
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

			<cfset var juitterContainer = "" />
			<cfset var juitterJS = "" />
			<cfset var data =  "" />
			<cfset var eventName = arguments.event.name />
			<cfset var pod = "" />
			<cfset var link = "" />
			<cfset var page = "" />
			
			<cfif eventName EQ "getPods">
				
				<!--- make sure we can add this to the pods list --->
				<cfif event.allowedPodIds EQ "*" OR listfindnocase(event.allowedPodIds, "juitter")>
					<cfsavecontent variable="juitterContainer"><cfoutput>
						<div id="juitterContainer"></div>
					</cfoutput></cfsavecontent>
						
					<cfset pod = structnew() />
					<cfset pod.title = getSetting("juitterTitle") />	
					<cfset pod.content = juitterContainer />
					<cfset pod.id = "juitter" />
					<cfset arguments.event.addPod(pod)>
				</cfif>
			
			
			<cfelseif eventName EQ "beforeHtmlHeadEnd">	
				<cfsavecontent variable="juitterJS"><cfoutput>
<script type="text/javascript" src="#getAssetPath()#jquery.juitter.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$.Juitter.start({
		searchType:"#getSetting('juitterSearchType')#", 
		searchObject:"#getSetting('juitterSearchObject')#", 
		lang:"#getSetting('juitterLanguage')#", 
		live:"live-15", 
		placeHolder:"juitterContainer", 
		loadMSG: "#getSetting('juitterLoadMSG')#",  
		imgName: "#getSetting('juitterImgName')#", 
		total: #getSetting('juitterCount')#, 
		readMore: "#getSetting('juitterReadMore')#", 
		nameUser:"#getSetting('juitterNameUser')#", 
		openExternalLinks:"#getSetting('juitterOpenExternalLinks')#", 
                filter:"#getSetting('juitterFilter')#"
	});
	$("##aRodrigo").click(function(){
		$(".jLinks").removeClass("on");
		$(this).addClass("on");									  
		$.Juitter.start({
			searchType:"fromUser",
			searchObject:"mrjuitter,rodrigofante",
			live:"live-120" // it will be updated every 120 seconds/2 minutes
		});
	});
	$("##aIphone").click(function(){
		$(".jLinks").removeClass("on");
		$(this).addClass("on");									   
		$.Juitter.start({
			searchType:"searchWord",
			searchObject:"iPhone,apple,ipod",
			live:"live-20"  // it will be update every 20 seconds 
		});
	});
	$("##aJuitter").click(function(){
		$(".jLinks").removeClass("on");
		$(this).addClass("on");								  
		$.Juitter.start({
			searchType:"searchWord",
			searchObject:"Juitter",
			live:"live-180" // it will be updated every 180 seconds/3 minutes
		});
	});
        $("##juitterSearch").submit(function(){

									  

		$.Juitter.start({

			searchType:"searchWord",

			searchObject:$(".juitterSearch").val(),
			live:"live-20", // it will be updated every 180 seconds/3 minutes
			filter:"sex->*BAD word*,porn->*BAD word*,fuck->*BAD word*,shit->*BAD word*"
		});
                return false;

	});
        $(".juitterSearch").blur(function(){
            if($(this).val()=="") $(this).val("Type a word and press enter");
        });
        $(".juitterSearch").click(function(){
            if($(this).val()=="Type a word and press enter") $(this).val("");
        });
        
        
});
</script>
<cfif getSetting("juitterCSS") neq "">
<style type="text/css">
#getSetting('juitterCSS')#
</style>
</cfif>
				</cfoutput></cfsavecontent>
				
				<cfset data = arguments.event.outputData />
				<cfset data = data & juitterJS />
				<cfset arguments.event.outputData = data />
			
			
			
			
			<!--- admin nav event --->
			<cfelseif eventName EQ "settingsNav">
				<cfset link = structnew() />
				<cfset link.owner = "juitter">
				<cfset link.page = "settings" />
				<cfset link.title = "Juitter" />
				<cfset link.eventName = "showJuitterSettings" />
				<cfset arguments.event.addLink(link)>
			
			
			<!--- admin event --->
			<cfelseif eventName EQ "showJuitterSettings" AND getManager().isCurrentUserLoggedIn()>
				<cfset data = arguments.event.data />				
				<cfif structkeyexists(data.externaldata,"apply")>
					
					<cfset setSettings(
							juitterTitle = data.externaldata.juitterTitle,
							juitterSearchType = data.externaldata.juitterSearchType,
							juitterSearchObject = data.externaldata.juitterSearchObject,
							juitterCount = data.externaldata.juitterCount,
							juitterLanguage = data.externaldata.juitterLanguage,
							juitterReadMore = data.externaldata.juitterReadMore,
							juitterOpenExternalLinks = data.externaldata.juitterOpenExternalLinks,
							juitterNameUser = data.externaldata.juitterNameUser,
							juitterLoadMSG = data.externaldata.juitterLoadMSG,
							juitterImgName = data.externaldata.juitterImgName,
							juitterFilter = data.externaldata.juitterFilter,
							juitterCSS = data.externaldata.juitterCSS
						) />
					
					<cfset persistSettings() />
					<cfset data.message.setstatus("success") />
					<cfset data.message.setType("settings") />
					<cfset data.message.settext("Juitter Settings Updated") />
				</cfif>
				
				<cfsavecontent variable="page">
					<cfinclude template="admin/settingsForm.cfm">
				</cfsavecontent>
					
					<!--- change message --->
					<cfset data.message.setTitle("Juitter Settings") />
					<cfset data.message.setData(page) />
			
			<cfelseif eventName EQ "getPodsList"><!--- no content, just title and id --->
				<cfset pod = structnew() />
				<cfset pod.title = "Juitter" />
				<cfset pod.id = "juitter" />
				<cfset arguments.event.addPod(pod)>
			</cfif>
		
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>