AddCSLuaFile("sent_fg8.lua")
AddCSLuaFile("cl_init.lua")
include("sent_fg8.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetUseType(SIMPLE_USE)
	local physOb = self:GetPhysicsObject()
	if(IsValid(physOb))then physOb:Wake()end
end

function ENT:SpawnFunction(ply,tr,ClassName)
	if ( !tr.Hit ) then return end
	local spawnPos = tr.HitPos+tr.HitNormal
	
	local ent = ents.Create(ClassName)
	ent:SetPos(spawnPos)
	ent:SetModel("models/props/CS_militia/microwave01.mdl")
	ent:Spawn()
	return ent
end

function ENT:Use(activator)
	local worldLine = tostring(math.random())
	self:EmitSound("rs.mp3",100,100,1,0)
	self:EmitSound("mwshort.mp3",100,100,1,0)
	activator:SendLua("flash(" .. self:GetPos().x .. "," .. self:GetPos().y .. "," .. self:GetPos().z .. ")")
	util.ScreenShake(self:GetPos(),5,5,4,5000)
	
	--Starts display sequence
	timer.Simple(1,function()activator:SendLua("HUDMessage(" .. worldLine .. ")")end)
	
	--Health scroll
	timer.Simple(4,function()
		activator:SetHealth(math.random()*99+1)
		local futureArmor = (math.random()-0.5)*200
		print(futureArmor)
		if(futureArmor<0)then
			activator:SetArmor(0)
		else
			activator:SetArmor(futureArmor)
		end
	end)
end

function ENT:SetUseType(typeuse)
end