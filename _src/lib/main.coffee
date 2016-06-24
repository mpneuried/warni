# # Warni

# ### extends [NPM:MPBasic](https://cdn.rawgit.com/mpneuried/mpbaisc/master/_docs/index.coffee.html)

#
# ### Exports: *Class*
#
# A helper to count alerts and send warnings or alerts not on every event.
#

class Warni extends require('mpbasic')()

	# ## defaults
	defaults: =>
		@extend super,
			# **Warni.warn** *Number* Number of `.issue()` calls needed to send a warning event. A warning event will only fired once between an `ok()` and an `alert` event.
			warn: 2
			# **Warni.alertCount** *Number* Alert of `.issue()` calls to send a alert event
			alert: 5
			# **Warni.alertResend** *Number* Resend a new alert event after x alert events. So only do the next alert event after `alert` * `resend` calls of `.issue()`
			resend: 10
			
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
		return @
		
	ok: ( data )=>
		_count = @issueCount
		@warningSend = false
		@issueCount = 0
		@alertCount = 0
		# only send "OK" if there was at least a warning before
		if _count > 0 and _count >= @config.warn
			@emit( "ok", data, _count )
		return @
	
	count: =>
		return @issueCount
	
	_handleAlert: ( data )=>
		if @alertCount is 0 or @issueCount % ( @config.alert * @config.resend ) is 0
			@emit( "alert", data, @issueCount )
		@alertCount++
		return

#export this class
module.exports = Warni
