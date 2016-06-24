should = require( "should" )

Warni = require( "../." )
randoms = require( "randoms" )

rnd = ->
	return randoms.obj.string(5)

_warni = null

describe "----- warni TESTS -----", ->

	before ( done )->
		_warni = new Warni( { warn: 2, alert: 5, resend: 2 } )
		# TODO add initialisation Code
		done()
		return

	after ( done )->
		#  TODO teardown
		done()
		return

	describe "Main Tests", ->

		# Implement tests cases here
		it "wait for a warning", ( done )->
			_data = null
			for idx in [1..2]
				if idx is 2
					_warni.once "warning", ( data, count )->
						data.should.eql( _data )
						_warni.count().should.equal(2)
						count.should.equal(2)
						done()
						return
				_data = rnd()
				_warni.issue( _data )
			return
		
		it "wait for a alert", ( done )->
			_data = null
			for idx in [3..5]
				if idx is 5
					_warni.once "alert", ( data, count )->
						data.should.eql( _data )
						_warni.count().should.equal(5)
						count.should.equal(5)
						done()
						return
				_data = rnd()
				_warni.issue( _data )
			return
		
		it "wait for 10 resend alerts after 100 issues", ( done )->
			_data = null
			_resendIdx = 1
			
			onAlert = ( data, count )->
				data.should.eql( _data )
				_warni.count().should.equal(10*_resendIdx)
				count.should.equal(10*_resendIdx)
				if _resendIdx is 10
					done()
					_warni.removeListener( "alert", onAlert )
				_resendIdx++
				return
				
			_warni.on( "alert", onAlert )
			
			for idx in [6..100]
				_data = rnd()
				_warni.issue( _data )
			return
			
			
		it "set to ok", ( done )->
			_data = rnd()
			_warni.once "ok", ( data, countBefore )->
				data.should.eql( _data )
				_warni.count().should.equal(0)
				countBefore.should.equal(100)
				done()
				return
			
			_warni.ok( _data )
			return
		
		it "check for no warning and ok", ( done )->
			_data = rnd()
			
			fnErrorWarning =->
				throw new Error( "invalid warning event" )
				return
			fnErrorOk =->
				throw new Error( "invalid ok event" )
				return
			
			_warni.on( "warning", fnErrorWarning )
			_warni.on( "ok", fnErrorOk )

			_data = rnd()
			_warni.issue( _data )
			_warni.count().should.equal(1)
			_data = rnd()
			_warni.ok( _data )
			
			setTimeout( ->
				_warni.removeListener( "warning", fnErrorWarning )
				_warni.removeListener( "ok", fnErrorOk )
				_warni.count().should.equal(0)
				done()
				return
			, 1000 )
			return
		
		it "set check for warning and ok", ( done )->
			_warningFired = false
			fnWarning = ( data, count )->
				data.should.eql( _dataW2 )
				_warni.count().should.equal(2)
				count.should.equal(2)
				_warningFired = true
				return
			fnOk = ( data, countBefore )->
				data.should.eql( _dataOk )
				_warni.count().should.equal(0)
				countBefore.should.equal(2)
				_warningFired.should.ok()
				_warni.removeListener( "warning", fnWarning )
				_warni.removeListener( "ok", fnOk )
				_warni.count().should.equal(0)
				done()
				return
			
			_warni.on( "warning", fnWarning )
			_warni.on( "ok", fnOk )
			
			# send 2 issues 
			_dataW1 = rnd()
			_warni.issue( _dataW1 )
			_warni.count().should.equal(1)
			_dataW2 = rnd()
			_warni.issue( _dataW2 )
			_warni.count().should.equal(2)
			_dataOk = rnd()
			_warni.ok( _dataOk )
			_warni.count().should.equal(0)
			return
		return
	return
