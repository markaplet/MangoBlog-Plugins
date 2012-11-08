<style type="text/css">
<!--
fieldset {
	margin-bottom: 1em;
	border: 1px solid #E8E8E8;
}
legend {
	font-weight: bold;
	padding: 0 5px 0 5px;
}

label {
	display: block;
	width: 160px;
	float: left;
	padding-left: 5px;
}
-->
</style>
<cfoutput>
	<form method="post" action="#cgi.script_name#">
		<fieldset>
		<legend>Search Criteria</legend>
		<div>
			<label for="flickrID">flickr ID:</label>
			<input type="text" id="flickrID" name="flickrID" value="#variables.flickrID#" size="20"/>
			Use <a href="http://idgettr.com" target="_blank">idGettr</a> to locate your user id or group id </div>
		<div>
			<label for="flickrTags">Tags:</label>
			<input type="text" id="flickrTags" name="flickrTags" value="#variables.flickrTags#" size="20"/>
			Comma seperated, no spaces </div>
		</fieldset>
		<fieldset>
		<legend>Photo Display</legend>
		<div>
			<label for="beforeIMG">Photos to display:</label>
			<input type="text" id="flickrCount" name="flickrCount" value="#variables.flickrCount#" size="5"/>
		</div>
		<div>
			<label for="photoSize">Photos Size:</label>
			<select id="photoSize" name="photoSize" class="required">
				<option value="thumbnail"<cfif variables.photoSize is "thumbnail"> selected="selected"</cfif>>thumbnail</option>
				<option value="medium"<cfif variables.photoSize is "medium"> selected="selected"</cfif>>medium</option>
			</select>
		</div>
		</fieldset>
		<fieldset>
		<legend>HTML Markup</legend>
		<div>
			<label for="flickrTitle">Title &lt;h2&gt;:</label>
			<input type="text" id="flickrTitle" name="flickrTitle" value="#variables.flickrTitle#" size="20"/>
			(blank = none)
		</div>
		<div>
		<div>
			<label for="beforeIMG">Before Image:</label>
			<input type="text" id="beforeIMG" name="beforeIMG" value="#variables.beforeIMG#" size="5"/>
			e.g. &lt;li&gt;,&lt;p&gt;</div>
		<div>
			<label for="beforeIMG">After Image:</label>
			<input type="text" id="afterIMG" name="afterIMG" value="#variables.afterIMG#" size="5"/>
			e.g. &lt;/li&gt;,&lt;/p&gt;&lt;br /&gt;</div>
		</fieldset>
		<div class="actions">
			<input type="submit" class="primaryAction" value="Submit"/>
			<input type="hidden" value="event" name="action" />
			<input type="hidden" value="showFlickrSettings" name="event" />
			<input type="hidden" value="true" name="apply" />
			<input type="hidden" value="flickrPics" name="selected" />
		</div>
	</form>
</cfoutput>