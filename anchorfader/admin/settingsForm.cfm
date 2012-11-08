<cfoutput>
<form method="post" action="#cgi.script_name#">

	<fieldset>
	
		<legend>Fade Options</legend>
		
		<p>
			<label for="fadeTargetElement">Target Page Element:</label>
			<span class="hint">Example: "ul.links li" targets the anchors inside of the unordered list with a class of "links"</span>
			<span class="field">
				<input type="text" id="fadeTargetElement" name="fadeTargetElement" value="#getSetting("fadeTargetElement")#"  class="required"/>
			</span>
		</p>
		
		<p>
			<label for="fadeStartColor">Starting Color:</label>
			<span class="hint">Hexadecimal vale or <a href="http://www.w3schools.com/html/html_colornames.asp">HTML color names</a></span>
			<span class="field">
				<input type="text" id="fadeStartColor" name="fadeStartColor" value="#getSetting("fadeStartColor")#"  class="required"/>
			</span>
		</p>
		
	</fieldset>
		
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showAnchorFaderSettings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="anchorfader" name="selected" />
	</p>

</form>
</cfoutput>