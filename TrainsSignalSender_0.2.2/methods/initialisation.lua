require "methods.trainFunctions"
require "methods.trainStationFunctions"
require "methods.guisBuilder"
require "methods.globalEvents"
require "methods.remoteBuilder"

function InitGlobalData()
	listTrains=setLocalList(global.listTrains,TrainPrototype)
	global.listTrains=listTrains
	listTrainsStop=setLocalList(global.listTrainsStop,TrainStopPrototype)
	global.listTrainsStop=listTrainsStop
end