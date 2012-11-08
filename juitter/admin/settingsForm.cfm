<style type="text/css">
<!--
.selector { color: #C39; }
.property {}
.value { color: #039; }
.comment { color: #999; font-style: italic; }
-->
</style>
<cfoutput>

<form method="post" action="#cgi.script_name#">

	<fieldset>
	
		<legend>Juitter Settings</legend>
		
		<p>
			<label for="juitterTitle">Juitter Title:</label>
			<span class="hint">leave blank to remove title</span>
			<span class="field">
				<input type="text" id="juitterTitle" name="juitterTitle" value="#getSetting("juitterTitle")#" size="20"/>
			</span>
		</p>
		
		<p>
			<label for="juitterSearchType">Search Type:</label>
			<span class="field">
				<select id="juitterSearchType" name="juitterSearchType">
					<option value="searchWord"<cfif getSetting("juitterSearchType") is "searchWord"> selected="selected"</cfif>>Search Word</option>
					<option value="fromUser"<cfif getSetting("juitterSearchType") is "fromUser"> selected="selected"</cfif>>From User</option>
					<option value="toUser"<cfif getSetting("juitterSearchType") is "toUser"> selected="selected"</cfif>>To User</option>
				</select>
			</span>
		</p>
		
		<p>
			<label for="juitterSearchObject">Search Word:</label>
			<span class="hint">you can insert a username here or a word to be searched for, if you wish multiple search, separate the words by comma.</span>
			<span class="field">
				<input type="text" id="juitterSearchObject" name="juitterSearchObject" value="#getSetting("juitterSearchObject")#" size="20"/>
			</span>
		</p>
		
	</fieldset>
	
	<fieldset>
	
		<legend>Additional Settings</legend>
		
		<p>
			<label for="juitterCount">Display Count:</label>
			<span class="hint">number of tweets to be show - max 100</span>
			<span class="field">
				<input type="text" id="juitterCount" name="juitterCount" value="#getSetting("juitterCount")#" size="20"/>
			</span>
		</p>
		
		<p>
			<label for="juitterLanguage">Language:</label>
			<span class="hint">restricts the search by the given language.</span>
			<span class="field">
				<input type="text" id="juitterLanguage" name="juitterLanguage" value="#getSetting("juitterLanguage")#" size="20"/>
			</span>
		</p>
		
		<p>
			<label for="juitterReadMore">Read More Message:</label>
			<span class="hint">read more message to be show after the tweet content</span>
			<span class="field">
				<input type="text" id="juitterReadMore" name="juitterReadMore" value="#getSetting("juitterReadMore")#" size="20"/>
			</span>
		</p>
		
		<p>
			<label for="juitterOpenExternalLinks">External Links:</label>
			<span class="field">
				<select id="juitterOpenExternalLinks" name="juitterOpenExternalLinks">
					<option value="newWindow"<cfif getSetting("juitterOpenExternalLinks") is "newWindow"> selected="selected"</cfif>>New Window</option>
					<option value="sameWindow"<cfif getSetting("juitterOpenExternalLinks") is "sameWindow"> selected="selected"</cfif>>Same Window</option>
				</select>
			</span>
		</p>
		
		<p>
			<label for="juitterNameUser">Identify User:</label>
			<span class="field">
				<select id="juitterNameUser" name="juitterNameUser">
					<option value="image"<cfif getSetting("juitterNameUser") is "image"> selected="selected"</cfif>>Avatar</option>
					<option value="text"<cfif getSetting("juitterNameUser") is "text"> selected="selected"</cfif>>Text Name</option>
				</select>
			</span>
		</p>
		
		<p>
			<label for="juitterLoadMSG">Loading Message:</label>
			<span class="hint">Loading message, if you want to show an image, fill it with "image/gif" and go to the next variable to set which image you want to use on</span>
			<span class="field">
				<input type="text" id="juitterLoadMSG" name="juitterLoadMSG" value="#getSetting("juitterLoadMSG")#" size="20"/>
			</span>
		</p>
		
		<p>
			<label for="juitterImgName">Loading Image:</label>
			<span class="hint">Loading image, to enable it, go to the loadMSG var above and change it to "image/gif"</span>
			<span class="field">
				<input type="text" id="juitterImgName" name="juitterImgName" value="#getSetting("juitterImgName")#" size="20"/>
			</span>
		</p>
		
		<p>
			<label for="juitterFilter">Bad Word Filter:</label>
			<span class="hint">insert the words you want to hide from the tweets followed by what you want to show instead example: "sex->censured" or "porn->BLOCKED WORD" you can define as many as you want, if you don't want to replace the word, simply remove it, just add the words you want separated like this "porn,sex,fuck"... Be aware that the tweets will still be showed, only the bad words will be removed</span>
			<span class="field">
				<textarea id="juitterFilter" name="juitterFilter" rows="7" cols="70">#getSetting("juitterFilter")#</textarea>
			</span>
		</p>
		
	
	</fieldset>
	
	<fieldset>
	
		<legend>Custom CSS</legend>
	
		<p>
			<label for="juitterCSS">Juitter CSS:</label>
			<span class="hint">using css inside the plugin is <strong>not recommended</strong> as hash tags cause the plugin to crash. It's best to add the css to your themes stylesheet.</span>
			<span class="field">
				<textarea id="juitterCSS" name="juitterCSS" rows="7" cols="70">#getSetting("juitterCSS")#</textarea>
			</span>
		</p>
		
	</fieldset>
		
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showJuitterSettings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="juitter" name="selected" />
	</p>

</form>

</cfoutput><h3>Jitter Stylesheet
</h3>
<p><span class="selector">.twittList</span> {} <span class="comment">/* UL that will contain the list of tweets */<br />
	</span><span class="selector">.twittLI </span>{}<br />
	<span class="selector">.twittList SPAN.time</span> {}<br />
	<span class="selector">.twittList a </span>{} <span class="comment">/*Links inside the tweets list */<br />
	</span><span class="selector">.juitterAvatar </span>{}<br />
	<span class="selector">.jRM </span>{} <span class="comment">/*read it on twitter link*/<br />
	</span><span class="selector">.extLink </span>{} <span class="comment">/*CSS for the external links*/<br />
</span><span class="selector">.hashLink</span> {} <span class="comment">/*CSS for the hash links*/</span></p>
