<cfoutput>

<form method="post" action="#cgi.script_name#">

	<fieldset>
	
		<legend>sIFR3 Settings</legend>

		<p>
			<label for="sifr3Selector">CSS Selector:</label>
			<span class="hint">Defines what css selector sIFR3 needs to replace.</span>
			<span class="field">
				<input type="text" id="sifr3Selector" name="sifr3Selector" value="#getSetting("sifr3Selector")#" size="20" class="required"/>
			</span>
		</p>
		
		<p>
			<label for="sifr3Font">sIFR Font:</label>
			<span class="hint">Exact name of your .swf file. You can use the free <a href="http://www.sifrgenerator.com/wizard.html">sIFR Generator</a> to create your swf file and upload it to your site.</span>
			<span class="field">
				<input type="text" id="sifr3Font" name="sifr3Font" value="#getSetting("sifr3Font")#" size="20" class="required"/>.swf
			</span>
		</p>
		
	</fieldset>
	
	<fieldset>
	
		<legend>Advanced Styling</legend>
		<p>It is better to style your sIFR text in your themes css, however you may also use the <a href="http://wiki.novemberborn.net/sifr3/Styling">advance styling options</a> available to sIFR</p>
		
		<p>
			<label for="sifr3AdvancedCSS">Advanced CSS:</label>
			<span class="field">
				<textarea name="sifr3AdvancedCSS" id="sifr3AdvancedCSS" cols="100" rows="10">#getSetting("sifr3AdvancedCSS")#</textarea>
			</span>
		</p>
		
	
	</fieldset>
		
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showsIFR3Settings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="sIFR3" name="selected" />
	</p>

</form>

</cfoutput>