<cfcomponent extends="BasePlugin">

<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: INITIALIZE PLUGIN ::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
		<cfset setManager(arguments.mainManager) />
		<cfset setPreferencesManager(arguments.preferences) />
		<cfset setPackage("com/visual28/mango/plugins/anchorslider") />
		<cfreturn this/>
	</cffunction>

<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: SETUP ::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="setup" hint="This is run when a plugin is activated" access="public" output="false" returntype="any">
		<cfreturn "<strong>Anchor Slider has been activated:</strong>" />
	</cffunction>
	
<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: UNSETUP ::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<cfreturn "<strong>Anchor Slider has been deactivated</strong>" />
	</cffunction>

<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: EVENT HANDLER ::::::::::::::::::::::::::::::::::::::::::::::::::: --->
	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />		
		<cfreturn />
	</cffunction>

<!--- ::::::::::::::::::::::::::::::::::::::::::::::::::: PROCESS EVENTS ::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	<cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />
		<cfset var anchorSliderScript = "" />
		<cfset var data =  "" />
		<cfset var eventName = arguments.event.name />
		<cfif eventName EQ "beforeHtmlHeadEnd">	
			
			<cfsavecontent variable="anchorSliderScript">
			<cfoutput>
	<script type="text/javascript" src="#getAssetPath()#jquery.anchor.js"></script>
			</cfoutput>
			</cfsavecontent>
			<cfset data = arguments.event.outputData />
			<cfset data = data & anchorSliderScript />
			<cfset arguments.event.outputData = data />
	
		</cfif>
		<cfreturn arguments.event />
	</cffunction>

</cfcomponent>