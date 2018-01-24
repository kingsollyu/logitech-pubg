local pubg = {}
-------------------------------------------------------------------------------
-- 快捷键定义区域
-------------------------------------------------------------------------------
pubg.keyPickupWeapon = 8
pubg.keyAlwayRun     = 4 -- 直接按键
pubg.keyLookAround   = 1 -- alt + G + 定义
pubg.keyWeaponUmp9   = 8 -- G + 定义
pubg.keyWeaponAkm    = 7 -- G + 定义
pubg.keyWeaponM16a4  = 7 -- 定义
pubg.keyWeaponM416   = 5 -- 定义
pubg.keyDrop         = 1 -- G + 定义

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
-- 随机函数，支出负数
-------------------------------------------------------------------------------
pubg.random = function (min, max)
	local nMin = 1
	local nMax = max - min
	local randomNumber = math.random(nMin, nMax)
	return randomNumber + min - 1
end

-------------------------------------------------------------------------------
-- 一件拾取装备 = 游戏中：从左边拉物品到武器栏中
-------------------------------------------------------------------------------
pubg.onPickupWeapon = function ()
	local currentMouseX, currentMouseY = GetMousePosition()
	PressMouseButton(1)
	for i = 1, 5 do
		MoveMouseRelative(pubg.random(100, 120), pubg.random(-10, 10))
		Sleep(20)
	end
	ReleaseMouseButton(1)
	Sleep(100)
	MoveMouseTo(currentMouseX, currentMouseY)
end

-------------------------------------------------------------------------------
-- 一键丢东西 = 游戏中：ctrl+拖放
-------------------------------------------------------------------------------
pubg.onDrop = function ()
	local currentMouseX, currentMouseY = GetMousePosition()
	PressMouseButton(1);Sleep(20)
	for i = 1, 3 do
		MoveMouseRelative(pubg.random(-126, -100), pubg.random(-10, 10))
		Sleep(20)
	end
	ReleaseMouseButton(1)
	Sleep(100)
	MoveMouseTo(currentMouseX, currentMouseY)
end

-------------------------------------------------------------------------------
-- 一键奔跑 = 游戏中：按=好
-------------------------------------------------------------------------------
pubg.onAlwayRun = function ()
	PressKey(0x0d)
	Sleep(400)
	ReleaseKey(0x0d)
end

-------------------------------------------------------------------------------
-- 自动环视周围
-------------------------------------------------------------------------------
pubg.onLookAround = function ()
	PressMouseButton(1)
	repeat
		MoveMouseRelative(pubg.random(30, 70), pubg.random(-1, 2))
		Sleep(20)
	until not IsMouseButtonPressed(1)
	ReleaseMouseButton(1)
end

-------------------------------------------------------------------------------
-- 当单独的G键被按下
-------------------------------------------------------------------------------
pubg.onGKeyPressed = function ()
	pubg.currentWeapon = "NIL"
end

-------------------------------------------------------------------------------
-- 选择UMP9枪
-------------------------------------------------------------------------------
pubg.onWeaponUmp9 = function ()
	local weaponRocilData  = {5, 5, 5, 3, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 2, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5}
	local weaponDuration   = 20
	local currentRecoilPos = 1
	repeat
		MoveMouseRelative(pubg.random(-1,2), weaponRocilData[currentRecoilPos])
		currentRecoilPos = currentRecoilPos + 1
		Sleep(weaponDuration)
		OutputLogMessage(tostring(currentRecoilPos) .. " ")
		if currentRecoilPos == #weaponRocilData then
			currentRecoilPos = 1
		end
	until not IsMouseButtonPressed(1)
end

-------------------------------------------------------------------------------
-- 选择AKM枪
-------------------------------------------------------------------------------
pubg.onWeaponAkm = function ()
	local weaponRocilData  = {5, 5, 5, 3, 2, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 2, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5}
	local weaponDuration   = 20
	local currentRecoilPos = 1
	repeat
		MoveMouseRelative(0, weaponRocilData[currentRecoilPos])
		currentRecoilPos = currentRecoilPos + 1
		Sleep(weaponDuration)
		OutputLogMessage(tostring(currentRecoilPos) .. " ")
		if currentRecoilPos == #weaponRocilData then
			currentRecoilPos = 1
		end
	until not IsMouseButtonPressed(1)
end

-------------------------------------------------------------------------------
-- 选择M16A4枪
-------------------------------------------------------------------------------
pubg.onWeaponM16a4 = function ()
	local weaponRocilData  = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 2, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5}
	local weaponDuration   = 20
	local currentRecoilPos = 1
	repeat
		MoveMouseRelative(pubg.random(-1,2), weaponRocilData[currentRecoilPos])
		currentRecoilPos = currentRecoilPos + 1
		Sleep(weaponDuration)
		OutputLogMessage(tostring(currentRecoilPos) .. " ")
		if currentRecoilPos == #weaponRocilData then
			currentRecoilPos = 1
		elseif currentRecoilPos % 5 == 0 then
			ReleaseMouseButton(1)
			Sleep(10)
			PressMouseButton(1)
			Sleep(100)
		end
	until not IsMouseButtonPressed(1)
	OutputLogMessage("IsMouseButtonPressed == false\n")
end

-------------------------------------------------------------------------------
-- 选择M416枪
-------------------------------------------------------------------------------
pubg.onWeaponM416 = function ()
	ClearLog()
	local weaponRocilData  = {5, 5, 5, 3, 2, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 3, 2, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5}
	local weaponDuration   = 20
	local currentRecoilPos = 1
	repeat
		MoveMouseRelative(pubg.random(-1,2), weaponRocilData[currentRecoilPos])
		currentRecoilPos = currentRecoilPos + 1
		Sleep(weaponDuration)
		OutputLogMessage(tostring(currentRecoilPos) .. " ")
		if currentRecoilPos == #weaponRocilData then
			currentRecoilPos = 1
		elseif currentRecoilPos % 5 == 0 then
			ReleaseMouseButton(1)
			Sleep(20)
			PressMouseButton(1)
		end
	until not IsMouseButtonPressed(1)
end


-------------------------------------------------------------------------------
-- pubg逻辑处理
-------------------------------------------------------------------------------
pubg.onEvent = function (event, arg)
	OutputLogMessage("event = %s, arg = %d\n", event, arg)
	
	if event == "PROFILE_ACTIVATED" then
		EnablePrimaryMouseButtonEvents(true)
	elseif event == "PROFILE_DEACTIVATED" then
		EnablePrimaryMouseButtonEvents(false)
		pubg.currentWeapon = "NIL"
		ReleaseKey(0x1d)
		ReleaseMouseButton(1)
		ReleaseMouseButton(2)
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
	
	-- 单独G键被按下
	if event == "MOUSE_BUTTON_RELEASED" and arg == 6 and pubg.isOKeyPressed == false then
		pubg.onGKeyPressed()
		-- 一键拾取物品
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyPickupWeapon and pubg.isGKeyPressed == false then
		pubg.onPickupWeapon()
		-- 一键丢弃物品
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyDrop and pubg.isGKeyPressed == true then
		pubg.onDrop()
		-- 一键奔跑
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyAlwayRun and pubg.isGKeyPressed == false then
		pubg.onAlwayRun()
		-- 自动环视周围
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyLookAround and IsModifierPressed("alt") then
		pubg.onLookAround()
		-- 选择UMP9
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyWeaponUmp9 and pubg.isGKeyPressed == true then
		pubg.currentWeapon = "UMP9"
		-- 选择AKM
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyWeaponAkm and pubg.isGKeyPressed == true then
		pubg.currentWeapon = "AKM"
		-- 选择M16A4
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyWeaponM16a4 and pubg.isGKeyPressed == false then
		pubg.currentWeapon = "M16A4"
		-- 选择M416
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyWeaponM416 and pubg.isGKeyPressed == false then
		pubg.currentWeapon = "M416"
		
		-- 鼠标左键被按下
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == 1 then
		if pubg.currentWeapon ~= "NIL" then
			if pubg.currentWeapon == "UMP9" then
				pubg.onWeaponUmp9()
			elseif pubg.currentWeapon == "AKM" then
				pubg.onWeaponAkm()
			elseif pubg.currentWeapon == "M16A4" then
				pubg.onWeaponM16a4()
			elseif pubg.currentWeapon == "M416" then
				pubg.onWeaponM416()
			end
		end
	end
end


-------------------------------------------------------------------------------
-- 驱动入口函数
-------------------------------------------------------------------------------
function OnEvent(event, arg)
	pubg.onEvent(event, arg)
end
