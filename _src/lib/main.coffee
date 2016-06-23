# # Warni

# ### extends [NPM:MPBasic](https://cdn.rawgit.com/mpneuried/mpbaisc/master/_docs/index.coffee.html)

#
# ### Exports: *Class*
#
# Main Module
#

class Warni extends require('mpbasic')()

	# ## defaults
	defaults: =>
		@extend super,
			# **Warni.warn** *Number* Number of `.issue()` calls needed to send a warning event. A warning event will only fired once between an `ok()` and an `alert` event.
			warn: 2
			# **Warni.alertCount** *Number* Alert of `.issue()` calls to send a alert event
			alert: 5
			# **Warni.alertResend** *Number* Resend a new alert event after x alert events. So only do the next alert event after `alertCount` * `alertResend` calls of `.issue()`
			alertResend: 10
			
	###
	## constructor
	###
	constructor: ( options ) ->
		super
		
		@issueCount = 0
		@alertCount = 0
		@warningSend = false
		return
	
	issue: ( data )=>
		@issueCount++
		if @issueCount >= @config.alert
			@_handleAlert( data )
			return
		if @issueCount >= @config.warn and not @warningSend
			@warningSend = true
			@emit( "warning", data, @issueCount )
		return
		
	ok: ( data )=>
		# only send "OK" if there was at least a warning or anissues before
		if @issueCount > 0 and @issueCount < @config.warn
			@emit( "ok", data, @issueCount )
		@warningSend = false
		@issueCount = 0
		@alertCount = 0
		return
	
	count: =>
		return @issueCount
	
	_handleAlert: ( data )=>
		if @alertCount is 0 or @alertCount % @config.alertResend
			@emit( "alert", data, @issueCount )
		@alertCount++
		return

#export this class
module.exports = Warni



return
warner = new Warni( { alert: _nsqCnf.alertCount, alertResend: _nsqCnf.alertResendCount } )

warner.on "ok", ( data )->
	utils.logc( "green", "OK", "NSQ Depth status returned to normal: #{data.depth}" )
	send2Slack( "✅ *NSQ OK* ✅\nDepth status returned to normal\n_detph:`#{data.depth}`_" )
	return

warner.on "warning", ( data, count )->
	utils.logc( "yellow", "WARNING", "Depth exceeded\n" + data.details )
	send2Slack( "⚠️ *NSQ WARNING* ⚠️\nDepth exceeded by #{data.depth}\n", data.details )
	return

warner.on "alert", ( data, count )->
	utils.logc( "red", "ALERT", "NSQ depth exceeded threshold of `#{_nsqCnf.warnDepth}` with a depth of `#{data.depth}` for #{count} times.\n" + data.details )
	send2Slack( "🚨 *NSQ depth exceeded* 🚨\nthreshold of `#{_nsqCnf.warnDepth}` with a depth of `#{data.depth}` for #{count} times.\n_Servertype:#{serverConfig}_\n\n*Critical-TOPICS:*\n" + data.details )
	return

watcher.on "channel-depth", ( depth, channels, stats, node )->
	details = []
	for _topic, _td of topicDepths when _td > _nsqCnf.warnDepth
		details.push( "  - #{_topic}: #{_td}" )
	
	if depth >= _nsqCnf.warnDepth
		utils.logc( "yellow", "INFO", "NSQ depth exceeded threshold of `#{_nsqCnf.warnDepth}` with a depth of `#{depth}` for #{warner.count()} times.\n" + details.join( "\n" ) )
		warner.issue( { depth:depth, details:details.join( "\n" )  } )
	else
		warner.ok( { depth:depth, details:details.join( "\n" )  } )

	return
