<cfoutput>

<form method="post" action="#cgi.script_name#">
<div>
    <label for="metaKeywords">Keywords:</label>
	<textarea id="metaKeywords" name="metaKeywords" rows="5" cols="50">#variables.metaKeywords#</textarea>
</div>
<div class="actions">
    <input type="submit" class="primaryAction" value="Submit"/>
	<input type="hidden" value="event" name="action" />
	<input type="hidden" value="showMetaSettings" name="event" />
	<input type="hidden" value="true" name="apply" />
	<input type="hidden" value="metaData" name="selected" />
  </div>
</form>

</cfoutput>