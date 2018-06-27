local pubg = {}

-------------------------------------------------------------------------------
-- 变量定义区域
-------------------------------------------------------------------------------
-- 鼠标G键是否被按下
pubg.isGKeyPressed = false
-- 当鼠标G键被按下去之后，其他按钮是否被按下
pubg.isOKeyPressed = false
-- 当前选择的武器
pubg.currentWeapon = "NIL"

-------------------------------------------------------------------------------
-- 压枪逻辑
-------------------------------------------------------------------------------
-- UMP9 
pubg.onWeaponUMP9_X1 = function()
end

pubg.onWeaponUMP9_X2 = function()
end

pubg.onWeaponUMP9 = function()
	ClearLog()
	-- 一倍压枪
	local weaponX1 = function() 
		local shotTimes = 0
		repeat
			MoveMouseRelative(0, 1)
			if shotTimes < 25 then
				Sleep(30)
			elseif shotTimes < 70 then
				Sleep(25)
			else
				Sleep(23)
			end
				
			shotTimes = shotTimes + 1
		until not IsMouseButtonPressed(1)
		
		if shotTimes > 60 then
			pubg.reloadWeapon()
		end
	end
	
	local weaponX2 = function()
		local shotTimes = 0
		repeat
			MoveMouseRelative(0, 1)
			shotTimes = shotTimes + 1
			Sleep(19)
		until not IsMouseButtonPressed(1)
		
		if shotTimes > 140 then
			pubg.reloadWeapon()
		end
	end
	
	if IsModifierPressed("shift") then
		weaponX2()
	else
		weaponX1()
	end
end

pubg.onWeaponScarL = function()
	
	-------------------------------------------
	-- X1
	-------------------------------------------
	local weaponX1 = function()
		local shotTimes = 0
		repeat
			MoveMouseRelative(0, 1)
			shotTimes = shotTimes + 1
			if shotTimes < 40 then
				Sleep(25)
			else
				Sleep(20)
			end
		until not IsMouseButtonPressed(1)
	end

	-------------------------------------------
	-- X2
	-------------------------------------------
	local weaponX2 = function()
		local shotTimes = 0
		repeat
			MoveMouseRelative(0, 1)
			shotTimes = shotTimes + 1
			if shotTimes < 20 then
				Sleep(25)
			else
				Sleep(15)
			end
		until not IsMouseButtonPressed(1)
		if shotTimes > 120 then
			pubg.reloadWeapon()
		end
	end
	
	-------------------------------------------
	-- X4
	-------------------------------------------
	local weaponX4 = function()
		local shotTimes = 0
		repeat
			Sleep(50)
			MoveMouseRelative(0, 5)
			shotTimes = shotTimes + 1			
			if shotTimes > 3 then
				ReleaseMouseButton(1)
			end
		until not IsMouseButtonPressed(1)
	end


	if IsKeyLockOn("capslock") then
		weaponX4()
	elseif IsModifierPressed("shift") then
		weaponX2()
	else
		weaponX1()
	end	

end

pubg.reloadWeapon = function()
	PressKey(0x13)
	Sleep(200)
	ReleaseKey(0x13)
end

-------------------------------------------------------------------------------
-- pubg逻辑处理
-------------------------------------------------------------------------------
pubg.onEvent = function (event, arg)
	--OutputLogMessage("event:" .. tostring(event) .. " arg:" .. tostring(arg) .. " \n")
	
	if event == "PROFILE_ACTIVATED" then
		EnablePrimaryMouseButtonEvents(true)
	elseif event == "PROFILE_DEACTIVATED" then
		EnablePrimaryMouseButtonEvents(false)
		return
	end

	-- G键按下逻辑
	if event == "MOUSE_BUTTON_PRESSED" and arg == 6 then
		pubg.isGKeyPressed = true
		pubg.isOKeyPressed = false
	elseif event == "MOUSE_BUTTON_RELEASED" and arg == 6 then
		pubg.isGKeyPressed = false
	end

	-- 在G键按下的时候，其他键是否被按下
	if event == "MOUSE_BUTTON_PRESSED" and arg ~= 6 and pubg.isGKeyPressed then
		pubg.isOKeyPressed = true
	end

	-- 当鼠标有G键被松开时，如果其他没有其他按键按下，则说明为单点G键，关闭压抢
	if event == "MOUSE_BUTTON_RELEASED" and arg == 6 and pubg.isOKeyPressed == false then
		pubg.currentWeapon = "NIL"
		OutputLogMessage("shutdown anti recoil\n")
		return
	end

	-- 武器选择判定
	if event == "MOUSE_BUTTON_RELEASED" and arg == 8 and pubg.isOKeyPressed == false then
		pubg.currentWeapon = "UMP9"
		OutputLogMessage("weapon: ump9\n")
	elseif event == "MOUSE_BUTTON_RELEASED" and arg == 5 and pubg.isOKeyPressed == false then
		pubg.currentWeapon = "SCAR-L"
		OutputLogMessage("weapon: scar-l\n")
	end
	
	-- 鼠标左键被按下
	if event == "MOUSE_BUTTON_PRESSED" and arg == 1 and pubg.currentWeapon ~= "NIL" then
		if pubg.currentWeapon == "UMP9" then
			pubg.onWeaponUMP9()
		elseif pubg.currentWeapon == "SCAR-L" then
			pubg.onWeaponScarL()
		end
	end
end


-------------------------------------------------------------------------------
-- 驱动入口函数
-------------------------------------------------------------------------------
function OnEvent(event, arg)
	pubg.onEvent(event, arg)
end
ClearLog()