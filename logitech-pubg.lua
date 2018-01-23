--======================================================================--
--============================    OnDefine   ===========================--
--======================================================================--

-- 一键拾取物品
local keyUmp9 = 8
local keyM16a4 = 7
local keyQuadruple = "capslock"

-- G键是否被按下
local isGPressed = false

-- G键被按下的时候，其他键位被按下
local isOPressed = false

-- 当前使用的武器
local currentWeapon = "none"

--======================================================================--
--=============================    OnData   ============================--
--======================================================================--
-- data from https://github.com/liantian-cn/logitech-pubg/blob/master/adv_mode.lua
local recoil_table = {}

recoil_table["ump9"] = {
    basic = { 18, 19, 18, 19, 18, 19, 19, 21, 23, 24, 23, 24, 23, 24, 23, 24, 23, 24, 23, 24, 23, 24, 24, 25, 24, 25, 24, 25, 24, 25, 24, 25, 25, 26, 25, 26, 25, 26, 25, 26, 25, 26, 25, 26, 25, 26 },
    quadruple = { 83.3, 83.3, 83.3, 83.3, 83.3, 83.3, 83.3, 116.7, 116.7, 116.7, 116.7, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3 },
    speed = 92
}

recoil_table["akm"] = {
    basic = { 23.7, 23.7, 23.7, 23.7, 23.7, 23.7, 23.7, 23.7, 23.7, 23.7, 23.7, 28, 28, 28, 28, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7, 29.7 },
    quadruple = { 66.7, 66.7, 66.7, 66.7, 66.7, 66.7, 66.7, 66.7, 66.7, 66.7, 66.7, 123.3, 123.3, 123.3, 123.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3, 93.3 },
    speed = 100
}

recoil_table["m16a4"] = {
    basic = { 25, 25, 25, 29, 33, 33, 32, 33, 32, 32, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30 },
    quadruple = { 86.7, 86.7, 86.7, 86.7, 86.7, 86.7, 86.7, 150, 150, 150, 150, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120 },
    speed = 75
}

recoil_table["m416"] = {
    basic = { 21, 21, 21, 21, 21, 21, 21, 21, 21, 23, 23, 24, 23, 24, 25, 25, 26, 27, 27, 32, 31, 31, 31, 31, 31, 31, 31, 32, 32, 32, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35 },
    quadruple = { 86.7, 86.7, 86.7, 86.7, 86.7, 86.7, 86.7, 150, 150, 150, 150, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7 },
    speed = 86
}

recoil_table["scarl"] = {
    basic = { 20, 21, 22, 21, 22, 22, 23, 22, 23, 23, 24, 24, 25, 25, 25, 25, 26, 27, 28, 29, 30, 32, 34, 34, 35, 34, 35, 34, 35, 34, 35, 34, 34, 34, 34, 34, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35 },
    quadruple = { 86.7, 86.7, 86.7, 86.7, 86.7, 86.7, 86.7, 150, 150, 150, 150, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7, 96.7 },
    speed = 96
}

recoil_table["uzi"] = {
    basic = { 16, 17, 18, 20, 21, 22, 23, 24, 25, 26, 28, 30, 32, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34 },
    quadruple = { 13.3, 13.3, 13.3, 13.3, 13.3, 21.7, 21.7, 21.7, 21.7, 21.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7, 46.7 },
    speed = 48
}

recoil_table["none"] = {
    basic = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    quadruple = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    speed = 60
}


--------------------------------------------------------------------------
----------------          Function          ------------------------------
--------------------------------------------------------------------------

local target_sensitivity = 50
local scope_sensitivity = 50
local scope4x_sensitivity = 50

function convertSens(unconvertedSens)
    return 0.002 * math.pow(10, unconvertedSens / 50)
end

function calcSensScale(sensitivity)
    return convertSens(sensitivity) / convertSens(50)
end

local targetScale = calcSensScale(target_sensitivity)
local scopeScale = calcSensScale(scope_sensitivity)
local scope4xScale = calcSensScale(scope4x_sensitivity)
---- Obfs setting
---- Two firing time intervals = weapon_speed * intervalRatio * ( 1 + randomSeed * ( 0 ~ 1))
local weaponSpeedMode = false
local obfsMode = true
local intervalRatio = 0.75
local randomSeed = 1

function recoilMode()
    if IsKeyLockOn(keyQuadruple) then
        return "quadruple";
    else
        return "basic";
    end
end

function recoil_value(_weapon, _duration)
    local _mode = recoilMode()
    local step = (math.floor(_duration / 100)) + 1
    if step > 40 then
        step = 40
    end
    local weaponRecoil = recoil_table[_weapon][_mode][step]
    -- OutputLogMessage("weaponRecoil = %s\n", weaponRecoil)

    local weapon_speed = 30
    if weaponSpeedMode then
        weapon_speed = recoil_table[_weapon]["speed"]
    end
    -- OutputLogMessage("weapon_speed = %s\n", weapon_speed)

    local weaponIntervals = weapon_speed
    if obfsMode then
        local coefficient = intervalRatio * ( 1 + randomSeed * math.random())
        weaponIntervals = math.floor(coefficient * weapon_speed)
    end
    -- OutputLogMessage("weaponIntervals = %s\n", weaponIntervals)

    recoilRecovery = weaponRecoil * weaponIntervals / 100

    -- issues/3
    if IsMouseButtonPressed(2) then
        recoilRecovery = recoilRecovery / targetScale
    elseif recoilMode() == "basic" then
        recoilRecovery = recoilRecovery / scopeScale
    elseif recoilMode() == "quadruple" then
        recoilRecovery = recoilRecovery / scope4xScale
    end

    return weaponIntervals, recoilRecovery
end

--======================================================================--
--============================    OnEvent    ===========================--
--======================================================================--
function OnEvent(event, arg)
    OutputLogMessage("event = %s, arg = %d\n", event, arg)
    if event == "PROFILE_ACTIVATED" then
        EnablePrimaryMouseButtonEvents(true)
    elseif event == "PROFILE_DEACTIVATED" then
        currentWeapon = "none"
    end

    if (event == "MOUSE_BUTTON_PRESSED" and arg == 6) then
        isGPressed = true
        isOPressed = false
    elseif (event == "MOUSE_BUTTON_RELEASED" and arg == 6) then
        isGPressed = false
        if isOPressed == false then
            currentWeapon = "none"
        end
    end


    if (event == "MOUSE_BUTTON_PRESSED" and arg == keyUmp9) then
        currentWeapon = "ump9"
        isOPressed = true
    elseif (event == "MOUSE_BUTTON_PRESSED" and arg == keyM16a4) then
        currentWeapon = "m416"
        isOPressed = true
    elseif (event == "MOUSE_BUTTON_PRESSED" and arg == 1) then
        if isGPressed then
            isOPressed = true
            for i = 1, 5 do
                MoveMouseRelative(100, math.random(-1, 1))
            end
        elseif currentWeapon ~= "none" then
            local shoot_duration = 0.0
            repeat
                local intervals, recovery = recoil_value(currentWeapon, shoot_duration)
                MoveMouseRelative(math.random(-1, 1), recovery )
                Sleep(intervals)
                shoot_duration = shoot_duration + intervals
            until not IsMouseButtonPressed(1)
        end
    end
end