<cffunction name="init" access="public" output="false" returntype="struct">
	<cfset variables.name = "Lightbox2">
	<cfset variables.id = "com.visual28.lightbox2">
	<cfset variables.package = "com/visual28/mango/plugins/lightbox2"/>
	<cfset variables.preferences = structnew() />
	
	<cffunction name="init" access="public" output="false" returntype="any">
		<cfargument name="mainManager" type="any" required="true" />
		<cfargument name="preferences" type="any" required="true" />
			
			<cfset var pref = "" />
			<cfset variables.preferencesManager = arguments.preferences />
		
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
		<!--- TODO: Implement Method --->
		<cfreturn />
	</cffunction>

	<cffunction name="unsetup" hint="This is run when a plugin is de-activated" access="public" output="false" returntype="any">
		<!--- TODO: Implement Method --->
		<cfreturn />
	</cffunction>

	<cffunction name="handleEvent" hint="Asynchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />
		<!--- TODO: Implement Method --->
		<cfreturn />
	</cffunction>
  
  
  <cffunction name="processEvent" hint="Synchronous event handling" access="public" output="false" returntype="any">
		<cfargument name="event" type="any" required="true" />

			<cfif arguments.event.getName() EQ "beforeHtmlHeadEnd">
				<cfset outputData =  arguments.event.getOutputData() />
        
        <cfsavecontent variable="js"><cfoutput>
        
        <!--- //----------------- Lightbox 2 code -----------------// --->  
        <link rel="stylesheet" href="../../components/plugins/user/lightbox2/lightbox.css" type="text/css" media="screen" />
        <script src="../../components/plugins/user/lightbox2/prototype.js" type="text/javascript"></script>
        <script src="../../components/plugins/user/lightbox2/scriptaculous.js?load=effects" type="text/javascript"></script>
        <script src="../../components/plugins/user/lightbox2/lightbox.js" type="text/javascript"></script>
        <script src="../../components/plugins/user/lightbox2/reflection.js" type="text/javascript"></script>
        
        </cfoutput></cfsavecontent>
		
		<cfreturn arguments.event />
	</cffunction>
  
  
  

</cffunction>

