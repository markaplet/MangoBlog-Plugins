<cfoutput>
<form method="post" action="#cgi.script_name#">
	<fieldset>
		<legend>Netflix Feed</legend>
		
		<p>
			<label for="netflixCount">Feed items to display</label>
			<span class="hint">Some feeds only have a few items in the list like &quot;Movies At Home&quot; Choosing a value higher than the numbers in the feed will result in an error.</span>
			<span class="field">
				<input type="text" id="netflixCount" name="netflixCount" value="#getSetting("netflixCount")#" size="5" class="required digits"/>
			</span>
		</p>
		
		<p>
			<label for="netflixTitle">Feed Title</label>
			<span class="field">
				<input type="text" id="netflixTitle" name="netflixTitle" value="#getSetting("netflixTitle")#"/>
			</span>
		</p>
		
		<p>
			<label for="netflixFeedURL">RSS Feed</label>
			<span class="hint">Use the full url for your personalized feeds or choose a public feed from your <a href="http://www.netflix.com/RSSFeeds?lnkctr=mfRSS" target="_blank">Netflix RSS Feeds</a> page</span>
			<span class="field">
				<input type="text" id="netflixFeedURL" name="netflixFeedURL" value="#getSetting("netflixFeedURL")#" class="required"/>
			</span>
		</p>
		
	</fieldset>
		
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showNetflixSettings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="netflix" name="selected" />
	</p>

</form>
</cfoutput>
