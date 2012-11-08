<cfoutput>

<form method="post" action="#cgi.script_name#">

	<fieldset>
		
		<legend>CSS Naked Day Settings</legend>
		
		<p>
			<label for="cssNakedDayMessage">Naked Day Message:</label>
			<span class="hint">Customize the message your visitors see upon arrival to your site on Naked Day! (HTML Okay) Leave it blank to use the default message. </span>
			<span class="field">
				<textarea name="cssNakedDayMessage" id="cssNakedDayMessage" cols="80" rows="5">#getSetting("cssNakedDayMessage")#</textarea>
			</span>
		</p>
	
	</fieldset>
	
	<p><strong>Default Message</strong></p>
		<div id="naked" style="background:##ffc;padding:5px;color:##900;"><h3>What happened to the design?</h3><p>To know more about why styles are disabled on this website visit the  <a href="http://naked.dustindiaz.com" title="Web Standards Naked Day Host Website">Annual CSS Naked Day</a> website for more information.</p></div>
		
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="showCSSNakedDaySettings" name="event" />
		<input type="hidden" value="cssNakedDay" name="selected" />
	</p>

</form>

</cfoutput>