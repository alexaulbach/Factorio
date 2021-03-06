TrainStopPrototype={}

function TrainStopPrototype:new(entity,data)
	if entity.valid==false then
		return
	end
	local pos1=entity.position
	local pos2=entity.position
	if entity.direction==0 then
		pos1.x=pos1.x+2
		pos2.x=pos1.x-5
	elseif entity.direction==2 then
		pos1.y=pos1.y+2
		pos2.y=pos1.y-5
	end
	local o = data or
	{
		entity=entity,
		positions={pos1,pos2}
	}   
    setmetatable(o, self)
    self.__index = self
	return o
end

function TrainStopPrototype:findTrain(attemptId)
	local direction=self.entity.direction-(4*(attemptId-1))
	if direction<0 then
		direction=self.entity.direction+(4*(attemptId-1))
	end
	local trainStation=game.surfaces[1].create_entity
	{
		name=trainStopGhost,
		force=player.force,
		position=self.positions[attemptId],
		direction=direction
	}
	if not trainStation then return false end
	for _,trainData in pairs(listTrains) do
		if trainData:isFree()==true and trainData:addStation(trainStation,self.entity.unit_number) then
			self.station=trainStation
			player.print({"train_ok",math.floor(distance(trainData.entity.locomotives.front_movers[1],trainStation))})
			return true
		end
	end
	trainStation.destroy()
	return false
end

function TrainStopPrototype:remove()
	listTrainStops[self.entity.unit_number]=nil
	self.station.destroy()
end