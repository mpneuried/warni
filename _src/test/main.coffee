should = require( "should" )

Warni = require( "../." )
randoms = require( "randoms" )

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
			_data = randoms.obj.string(5)
			_warni.issue( _data )
			return

		return
	return
