<style type="text/css">
<!--
.badgePreview { float:right; width: 200px; background: #F7F7F7; padding: 10px; border: 1px solid #CCC; }
.badgePreview a img { border-style: none; }
-->
</style>
<cfoutput>
<form method="post" action="#cgi.script_name#">

	<fieldset>
	
		<legend>Project Honeypot Settings</legend>
		
		<p>
			<label for="honeypotURL">URL of honeypot page:</label>
			<span class="hint">use the path  specified when creating your honeypot project</span>
			<span class="field">
				<input type="text" id="honeypotURL" name="honeypotURL" value="#getSetting("honeypotURL")#" size="60" class="required" />
			</span>
		</p>
		
	</fieldset>
	

	<fieldset>
	
		<legend>Project Honeypot Badges</legend>
	
<p>Show your support for Project Honey Pot by adding the Project Honey Pot badge to your blogs sidebar.</p>
		
		<div class="badgePreview">
		<h3>Badge Preview</h3>
		<p><a href="http://www.projecthoneypot.org/?rf=#getSetting("honeypotRefNumber")#"><img src="#getAssetPath()#project_honey_pot_button.gif" /></a><br />Large</p>
		<p><a href="http://www.projecthoneypot.org/?rf=#getSetting("honeypotRefNumber")#"><img src="#getAssetPath()#mini_phpot_link.gif" /></a><br />Mini</p>
		<cfif getSetting("honeypotBadgeURL") neq ""><p><a href="http://www.projecthoneypot.org/?rf=#getSetting("honeypotRefNumber")#"><img src="#getSetting("honeypotBadgeURL")#" /></a><br />Custom Badge</p></cfif>
		</div>
		
		<p>
			<label for="honeypotPromote" class="preField">Honey pot badge</label>
			<span class="field">
				<select id="honeypotPromote" name="honeypotPromote">
					<option value="none"<cfif getSetting("honeypotPromote") is "none"> selected="selected"</cfif>>None</option>
					<option value="large"<cfif getSetting("honeypotPromote") is "large"> selected="selected"</cfif>>Large</option>
					<option value="mini"<cfif getSetting("honeypotPromote") is "mini"> selected="selected"</cfif>>Mini</option>
					<option value="custom"<cfif getSetting("honeypotPromote") is "custom"> selected="selected"</cfif>>Custom (Enter URL Below)</option>
				</select>
			</span>
		</p>
		
		
		<p>
			<label for="honeypotBadgeURL">Custom Badge URL</label>
			<span class="hint">url to your own button. Select "Custom" from the dropdown above in order to activate it.</span>
			<span class="field">
				<input type="text" id="honeypotBadgeURL" name="honeypotBadgeURL" value="#getSetting("honeypotBadgeURL")#" size="60"/>
			</span>
		</p>
		
		<p>
			<label for="honeypotRefNumber">Referral Number</label>
			<span class="field">
				<input type="text" id="honeypotRefNumber" name="honeypotRefNumber" value="#getSetting("honeypotRefNumber")#" size="20"/>
			</span>
		</p>
	
	</fieldset>

	
		
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showHoneypotSettings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="honeypot" name="selected" />
	</p>

</form>


</cfoutput><h3>Using The Project Honeypot Plugin</h3>
<ol>
	<li>Create a free account on <a href="http://www.projecthoneypot.org?rf=60023" target="_blank">http://www.projecthoneypot.org</a></li>
	<li>From the manage Honeypots page, create new honeypot</li>
	<li>Download the honeypot scripts to your hard drive</li>
	<li>Follow the installation instructions, and activate your honeypot</li>
	<li>Copy the url for your honeypot into the URL field above </li>
	<li>Copy the non-sense phrase or make up your own. </li>
</ol>
