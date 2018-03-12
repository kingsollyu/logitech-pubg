local pubg = {}

-------------------------------------------------------------------------------
-- 快捷键定义区域
-------------------------------------------------------------------------------
pubg.keyWeaponUmp9   = 8
pubg.keyWeaponAkm    = 7
pubg.keyWeaponM16a4  = 9
pubg.keyWeaponUzi    = 7
pubg.keyWeaponM416   = 5
pubg.keyAlwayRun     = 4

-------------------------------------------------------------------------------
-- 数据定义区域
-------------------------------------------------------------------------------
pubg.data = {
	UMP9  = {RELATIVE=1, SLEEP=20},
	UZI   = {RELATIVE=1, SLEEP=20},
	M416  = {RELATIVE=1, SLEEP=20},
	AKM   = {RELATIVE=1, SLEEP=20},
}

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
-- pubg逻辑处理
-------------------------------------------------------------------------------
pubg.onEvent = function (event, arg)
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
	end

	-- 鼠标按键逻辑区域
	if event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyWeaponUmp9 and pubg.isGKeyPressed == true then
		pubg.currentWeapon = "UMP9"
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyWeaponUzi and pubg.isGKeyPressed == false then
		pubg.currentWeapon = "UZI"
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyWeaponAkm and pubg.isGKeyPressed == true then
		pubg.currentWeapon = "AKM"
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyWeaponM416 and pubg.isGKeyPressed == false then
		pubg.currentWeapon = "M416"
	elseif event == "MOUSE_BUTTON_PRESSED" and arg == pubg.keyAlwayRun and pubg.isGKeyPressed == false then
		PressKey(0x0d)
		Sleep(400)
		ReleaseKey(0x0d)
	end

	-- 鼠标左键被按下
	if event == "MOUSE_BUTTON_PRESSED" and arg == 1 and pubg.currentWeapon ~= "NIL" then
		repeat
			MoveMouseRelative(0, pubg.data[pubg.currentWeapon]["RELATIVE"])
			Sleep(pubg.data[pubg.currentWeapon]["SLEEP"])
		until not IsMouseButtonPressed(1)
	end
end

-------------------------------------------------------------------------------
-- 驱动入口函数
-------------------------------------------------------------------------------
function OnEvent(event, arg)
	pubg.onEvent(event, arg)
end
