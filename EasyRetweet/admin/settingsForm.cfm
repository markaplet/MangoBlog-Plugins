<script src="http://ejohn.org/files/retweet.js"></script>

<style type="text/css">
<!--
.syntax_hilite {
	font-family: Courier New;
	padding: 8px;
	margin: 8px;
	background: #F5F5F5;
	border-top: 1px solid #BBB;
	border-bottom: 1px solid #BBB;
	font-size: 14px;
}
th, tr, td, table { border:none;}
th { background:none;}
-->
</style>

<cfoutput>

<form method="post" action="#cgi.script_name#">

	<fieldset>
	
		<legend>Self Retweet</legend>
		
		<p>
			<label for="retweetTitle">Sidebar Pod Title:</label>
			<span class="hint">Leave blank for no title</span>
			<span class="field">
				<input type="text" id="retweetTitle" name="retweetTitle" value="#getSetting("retweetTitle")#" size="20"/>
			</span>
		</p>
		
		<p>
			<label for="ReTweetPod">Sidebar Retweet Pod:</label>
			<span class="hint">Enables or disables the self retweet pod in your sidebar. </span>
			<span class="field">
				<select id="ReTweetPod" name="ReTweetPod">
					<option value="enabled"<cfif getSetting("ReTweetPod") is "enabled"> selected="selected"</cfif>>Enabled</option>
					<option value="disabled"<cfif getSetting("ReTweetPod") is "disabled"> selected="selected"</cfif>>Disabled</option>
				</select>
			</span>
		</p>
		
		<p>
			<label for="ReTweetContentEnd">Post Footer Retweet:</label>
			<span class="hint">Enables or disables the retweet link at the end of post. <strong>NOTE:</strong> Your theme template must broadcast the mango event &quot;beforePostContentEnd&quot; after the post body in order to work.</span>
			<span class="field">
				<select id="ReTweetContentEnd" name="ReTweetContentEnd">
					<option value="enabled"<cfif getSetting("ReTweetContentEnd") is "enabled"> selected="selected"</cfif>>Enabled</option>
					<option value="disabled"<cfif getSetting("ReTweetContentEnd") is "disabled"> selected="selected"</cfif>>Disabled</option>
				</select>
			</span>
		</p>
		
	</fieldset>
		
	<p class="actions">
		<input type="submit" class="primaryAction" value="Submit"/>
		<input type="hidden" value="event" name="action" />
		<input type="hidden" value="showRetweetSettings" name="event" />
		<input type="hidden" value="true" name="apply" />
		<input type="hidden" value="easyRetweet" name="selected" />
	</p>

</form>



</cfoutput>
<p>Disabling the the sidebar pod, or the post footer retweets, does not remove the javascript from the page, It only removes the links. Even if you disable both locations you can still add links manually to your templates or to your post content. </p>
<p>If you would like to manually insert rewtweet links follow the reference links  below. For a complete explanation of options and customization features check out <a href="http://ejohn.org/blog/retweet/">John Resig's Blog</a>.</p>
<table>
	<tr>
		<td></td>
		<th>Sample Code</th>
	</tr>
	<tr>
		<td class="r" nowrap><a class="retweet" href="http://ejohn.org/">John Resig's Blog</a></td>
		<td><div class="syntax_hilite">
				<div id="html-1">
					<div><span style="color: #009900;"><a href="http://december.com/html/4/element/a.html"><span style="color: #000000; font-weight: bold;">&lt;a</span></a> <span style="color: #000066;">class</span>=<span style="color: #ff0000;">"retweet"</span> <span style="color: #000066;">href</span>=<span style="color: #ff0000;">"http://ejohn.org/"</span><a href="http://december.com/html/4/element/.html"><span style="color: #000000; font-weight: bold;">&gt;</span></a></span>John Resig's Blog<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/a&gt;</span></span></div>
				</div>
			</div>
			<p><strong>Tweet Text:</strong> "John Resig's Blog http://bit.ly/vqYAg"</p></td>
	</tr>
	<tr>
		<td class="r" nowrap><a class="retweet" href="http://jquery.com/">jQuery JavaScript Library</a></td>
		<td><div class="syntax_hilite">
				<div id="html-2">
					<div><span style="color: #009900;"><a href="http://december.com/html/4/element/a.html"><span style="color: #000000; font-weight: bold;">&lt;a</span></a> <span style="color: #000066;">class</span>=<span style="color: #ff0000;">"retweet"</span> <span style="color: #000066;">href</span>=<span style="color: #ff0000;">"http://jquery.com/"</span><a href="http://december.com/html/4/element/.html"><span style="color: #000000; font-weight: bold;">&gt;</span></a></span>jQuery JavaScript Library<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/a&gt;</span></span></div>
				</div>
			</div>
			<p><strong>Tweet Text:</strong> "jQuery JavaScript Library http://bit.ly/FGybD"</p></td>
	</tr>
	<tr>
		<td class="r" nowrap><a class="retweet" href="http://google.com/" title="Google Search Engine">Google</a></td>
		<td><div class="syntax_hilite">
				<div id="html-3">
					<div><span style="color: #009900;"><a href="http://december.com/html/4/element/a.html"><span style="color: #000000; font-weight: bold;">&lt;a</span></a> <span style="color: #000066;">class</span>=<span style="color: #ff0000;">"retweet"</span> <span style="color: #000066;">href</span>=<span style="color: #ff0000;">"http://google.com/"</span> <span style="color: #000066;">title</span>=<span style="color: #ff0000;">"Google Search Engine"</span><a href="http://december.com/html/4/element/.html"><span style="color: #000000; font-weight: bold;">&gt;</span></a></span>Google<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/a&gt;</span></span></div>
				</div>
			</div>
			<p><strong>Tweet Text:</strong> "Google Search Engine http://bit.ly/ScCbV"</p></td>
	</tr>
	<tr>
		<td class="r" nowrap><a class="retweet self" href=""></a></td>
		<td><div class="syntax_hilite">
				<div id="html-4">
					<div><span style="color: #009900;"><a href="http://december.com/html/4/element/a.html"><span style="color: #000000; font-weight: bold;">&lt;a</span></a> <span style="color: #000066;">class</span>=<span style="color: #ff0000;">"retweet self"</span> <span style="color: #000066;">href</span>=<span style="color: #ff0000;">""</span><a href="http://december.com/html/4/element/.html"><span style="color: #000000; font-weight: bold;">&gt;</span></a></span><span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/a&gt;</span></span></div>
				</div>
			</div>
			<p><strong>Tweet Text:</strong> "John Resig - Easy Retweet Button http://bit.ly/1cliT"</p></td>
	</tr>
</table>
<p><br style="clear:both;"/>
</p>
<p><strong>Vertical Style</strong></p>
<table>
	<tr>
		<td></td>
		<th>Sample Code</th>
	</tr>
	<tr>
		<td nowrap><a class="retweet vert" href="http://ejohn.org/">John Resig's Blog</a></td>
		<td><div class="syntax_hilite">
				<div id="html-5">
					<div><span style="color: #009900;"><a href="http://december.com/html/4/element/a.html"><span style="color: #000000; font-weight: bold;">&lt;a</span></a> <span style="color: #000066;">class</span>=<span style="color: #ff0000;">"retweet vert"</span> <span style="color: #000066;">href</span>=<span style="color: #ff0000;">"http://ejohn.org/"</span><a href="http://december.com/html/4/element/.html"><span style="color: #000000; font-weight: bold;">&gt;</span></a></span>John Resig's Blog<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/a&gt;</span></span></div>
				</div>
			</div>
			<p><strong>Tweet Text:</strong> "John Resig's Blog http://bit.ly/vqYAg"</p></td>
	</tr>
	<tr>
		<td nowrap><a class="retweet vert" href="http://jquery.com/">jQuery JavaScript Library</a></td>
		<td><div class="syntax_hilite">
				<div id="html-6">
					<div><span style="color: #009900;"><a href="http://december.com/html/4/element/a.html"><span style="color: #000000; font-weight: bold;">&lt;a</span></a> <span style="color: #000066;">class</span>=<span style="color: #ff0000;">"retweet vert"</span> <span style="color: #000066;">href</span>=<span style="color: #ff0000;">"http://jquery.com/"</span><a href="http://december.com/html/4/element/.html"><span style="color: #000000; font-weight: bold;">&gt;</span></a></span>jQuery JavaScript Library<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/a&gt;</span></span></div>
				</div>
			</div>
			<p><strong>Tweet Text:</strong> "jQuery JavaScript Library http://bit.ly/FGybD"</p></td>
	</tr>
	<tr>
		<td nowrap><a class="retweet vert" href="http://google.com/" title="Google Search Engine">Google</a></td>
		<td><div class="syntax_hilite">
				<div id="html-7">
					<div><span style="color: #009900;"><a href="http://december.com/html/4/element/a.html"><span style="color: #000000; font-weight: bold;">&lt;a</span></a> <span style="color: #000066;">class</span>=<span style="color: #ff0000;">"retweet vert"</span> <span style="color: #000066;">href</span>=<span style="color: #ff0000;">"http://google.com/"</span> <span style="color: #000066;">title</span>=<span style="color: #ff0000;">"Google Search Engine"</span><a href="http://december.com/html/4/element/.html"><span style="color: #000000; font-weight: bold;">&gt;</span></a></span>Google<span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/a&gt;</span></span></div>
				</div>
			</div>
			<p><strong>Tweet Text:</strong> "Google Search Engine http://bit.ly/ScCbV"</p></td>
	</tr>
	<tr>
		<td nowrap><a class="retweet vert self" href=""></a></td>
		<td><div class="syntax_hilite">
				<div id="html-8">
					<div><span style="color: #009900;"><a href="http://december.com/html/4/element/a.html"><span style="color: #000000; font-weight: bold;">&lt;a</span></a> <span style="color: #000066;">class</span>=<span style="color: #ff0000;">"retweet vert self"</span> <span style="color: #000066;">href</span>=<span style="color: #ff0000;">""</span><a href="http://december.com/html/4/element/.html"><span style="color: #000000; font-weight: bold;">&gt;</span></a></span><span style="color: #009900;"><span style="color: #000000; font-weight: bold;">&lt;/a&gt;</span></span></div>
				</div>
			</div>
			<p><strong>Tweet Text:</strong> "John Resig - Easy Retweet Button http://bit.ly/1cliT"</p></td>
	</tr>
</table>
