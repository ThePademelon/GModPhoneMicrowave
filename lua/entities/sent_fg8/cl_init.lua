include("sent_fg8.lua")

local displayColor = Color(255,100,50,255)
surface.CreateFont("Nixie",{
	font="Roboto",
	size=256,
	weight=500,
	blursize=3,
	scanlines=0,
	antialias=true,
	underline=false,
	italic=false,
	strikeout=false,
	symbol=false,
	rotary=false,
	shadow=false,
	additive=false,
	outline=false
})
function HUDMessage(message)
	--Scrolls the numbers once every ten seconds
	hook.Add("HUDPaintBackground","WorldLineBG",function()draw.RoundedBox(0,0,0,ScrW(),ScrH(),Color(0,0,0,255))end)
	scrollNumbers()
	
	--Displays the final number
	timer.Simple(3,function()
	hook.Add("HUDPaint","WorldLineDisplay",function()
		draw.DrawText(string.sub(message,0,8),"Nixie",ScrW()*0.5,ScrH()*0.4,displayColor,TEXT_ALIGN_CENTER)
	end)end)
	
	--Removes the worldline display
	timer.Simple(9,function()hook.Remove("HUDPaint","WorldLineDisplay")end)
	timer.Simple(9,function()hook.Remove("HUDPaintBackground","WorldLineBG")end)
end

--Number scroll function
function scrollNumbers()
	hook.Add("HUDPaint","WorldLineDisplay",function()
		draw.DrawText(string.sub(tostring(math.random()),0,8),"Nixie",ScrW()*0.5,ScrH()*0.4,displayColor,TEXT_ALIGN_CENTER)
	end)
end

function flash(x,y,z)
	local dlight = DynamicLight(LocalPlayer():EntIndex())
	if (dlight) then
		dlight.pos = Vector(x,y,z)
		dlight.r = 100
		dlight.g = 100
		dlight.b = 255
		dlight.brightness = 1
		dlight.Decay = 0
		dlight.Size = 2048
		dlight.DieTime = CurTime() + 3
	end
end