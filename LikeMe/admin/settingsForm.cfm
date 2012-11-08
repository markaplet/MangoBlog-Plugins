<cfoutput>
<form method="post" action="#cgi.script_name#">
<fieldset>
	
	<legend>Facebook Like Button Settings</legend>
	
	<!--- Layout Style --->
	<p>
		<label for="LayoutStyle">Layout Style</label>
		<span class="hint">Determines the size and amount of social context next to the button.</span>
		<span class="field">
			<select name="LayoutStyle" id="LayoutStyle">
				<option value="standard" <cfif getSetting("LayoutStyle") EQ "standard"> selected="selected"</cfif>>Standard</option>
				<option value="button_count" <cfif getSetting("LayoutStyle") EQ "button_count"> selected="selected"</cfif>>Button Count</option>
			</select>
		</span>
	</p>
		
	<!--- Show Faces --->	
	<p>
		<label for="ShowFaces">Show Faces</label>
		<span class="hint">Show profile pictures below the button.</span>
		<span class="field">
			<select name="ShowFaces" id="ShowFaces">
				<option value="true" <cfif getSetting("ShowFaces") EQ "true"> selected="selected"</cfif>>true</option>
				<option value="false" <cfif getSetting("ShowFaces") EQ "false"> selected="selected"</cfif>>false</option>
			</select>
		</span>
	</p>
	
	<!--- Width --->
	<p>
		<label for="Width">Width</label>
		<span class="hint">The width of the plugin, in pixels.</span>
		<span class="field">
			<input name="Width" id="Width" type="text" value="#getSetting('Width')#" size="10"  />
		</span>
	</p>
	
	<!--- Verb to display --->
	<p>
		<label for="DisplayVerb">Verb to display</label>
		<span class="hint">The verb to display in the button. Currently only 'like' and 'recommend' are supported.</span>
		<span class="field">
			<select name="DisplayVerb" id="DisplayVerb">
				<option value="like" <cfif getSetting("DisplayVerb") EQ "like"> selected="selected"</cfif>>like</option>
				<option value="recommend" <cfif getSetting("DisplayVerb") EQ "recommend"> selected="selected"</cfif>>recommend</option>
			</select>
		</span>
	</p>
	
	<!--- Font --->
	<p>
		<label for="Font">Font</label>
		<span class="hint">The font of the plugin.</span>
		<span class="field">
			<select name="Font" id="Font">
				<option value="arial" <cfif getSetting("Font") EQ "arial"> selected="selected"</cfif>>arial</option>
				<option value="lucida grande" <cfif getSetting("Font") EQ "lucida grande"> selected="selected"</cfif>>lucida grande</option>
				<option value="segoe ui" <cfif getSetting("Font") EQ "segoe ui"> selected="selected"</cfif>>segoe ui</option>
				<option value="tahoma" <cfif getSetting("Font") EQ "tahoma"> selected="selected"</cfif>>tahoma</option>
				<option value="trebuchet ms" <cfif getSetting("Font") EQ "trebuchet ms"> selected="selected"</cfif>>trebuchet ms</option>
				<option value="verdana" <cfif getSetting("Font") EQ "verdana"> selected="selected"</cfif>>verdana</option>
			</select>
		</span>
	</p>
	
	<!--- Color Scheme --->
	<p>
		<label for="ColorScheme">Color Scheme</label>
		<span class="hint">The color scheme of the plugin.</span>
		<span class="field">
			<select name="ColorScheme" id="ColorScheme">
				<option value="light" <cfif getSetting("ColorScheme") EQ "light"> selected="selected"</cfif>>light</option>
				<option value="dark" <cfif getSetting("ColorScheme") EQ "dark"> selected="selected"</cfif>>dark</option>
			</select>
		</span>
	</p>

</fieldset>
<div class="actions">
    <input type="submit" class="primaryAction" value="Submit"/>
	<input type="hidden" value="event" name="action" />
	<input type="hidden" value="showLikeMeSettings" name="event" />
	<input type="hidden" value="true" name="apply" />
	<input type="hidden" value="LikeMe" name="selected" />
  </div>
  
</form>
</cfoutput>