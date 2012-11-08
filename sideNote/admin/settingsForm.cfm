<cfoutput>
<form method="post" action="#cgi.script_name#">
<fieldset>
	
	<legend>Add Content to Side Notes</legend>
	
	<p>
	<label for="contentField">Content</label>
		<span class="field"><textarea id="sideNoteContent" name="sideNoteContent" rows="20" cols="60" class="htmlEditor">#variables.sideNoteContent#</textarea></span>
	</p>
	
</fieldset>
<div class="actions">
    <input type="submit" class="primaryAction" value="Submit"/>
	<input type="hidden" value="event" name="action" />
	<input type="hidden" value="showSideNoteSettings" name="event" />
	<input type="hidden" value="true" name="apply" />
	<input type="hidden" value="sideNote" name="selected" />
  </div>
  
</form>
</cfoutput>