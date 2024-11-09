--2048
-- Сделать 2 таблицы, одна для рендра вторая реальная
-- Сделал, оби одна таблица - это пиздец, некоторые анимки рендрятся правильно, но исполняются не в нужном порядке, что может тупо удалить предмет

-- Сеттингс: цель, размер, свайп, скорость аним
-- Винлос + инфобар: тайм (похуй, вспомнил когда переписывал тему на БХ)) ), счёт + бест

local imgui, encoding = require 'mimgui', require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local WinOpen = imgui.new.bool()
local params = {square_lot = 4,game_step = 1}
local r = 0
local data = {
    MoveFrames = 5,
    MoveAnims = {},
    --MoveAnims[cellid] = {F = frames, X = offsetX, Y = offsetY, FF = finalFund}
    cell_size = 0,
    mainTable = {},
    renderTable = {},
    score = 0,
    ininame = '2048sleash.ini',
    swipe_pos = {},
};
local ini = require 'inicfg'
local set = ini.load({
    tzft = {
        bestscore = 0,
        score = 0,
        final = 12,
        square_lot = 4
    }, lastgame = {}
    }, data.ininame
)
local imgui_square_lot = imgui.new.int(set.tzft.square_lot)
local imgui_final = imgui.new.int(set.tzft.final)
function random(x, y)
    x = x or 0
    y = y or 0
    math.randomseed(os.time() * math.random(1000, 1000000))
    r = r + tonumber(math.random(1000, 1000000))
    if x == 0 and y == 0 then math.randomseed(r) if (math.random(r) % 2) == 1 then return 1 else return 0 end
    elseif x ~= 0 and y == 0 then math.randomseed(r) return math.random(x)
    else math.randomseed(r) return math.random(x, y) end
end
function Start2048()
    set.tzft.final = imgui_final[0]
    set.tzft.square_lot = imgui_square_lot[0]
   params.game_step = 1
   data.MoveAnims = {}
   if #data.mainTable == 0 then
    data.score = 0
    for i = 1, set.tzft.square_lot*set.tzft.square_lot do data.mainTable[i] = 0 end
    data.mainTable[random(set.tzft.square_lot*set.tzft.square_lot)] = 2 end
   for i, v in ipairs(data.mainTable) do data.renderTable[i] = v; set.lastgame[i] = v end
    set.tzft.score = data.score; ini.save(set, data.ininame);
   WinOpen[0] = true
end
function GetAnimInfo(cellid) for k, v in ipairs(data.MoveAnims) do if v.C == cellid then return v end end return false end
function AddMoveAnim(startCell, finishCell)
    if GetAnimInfo(startCell) then return false end
    local r1, c1 = GetRowAndCol(startCell)
    local r2, c2 = GetRowAndCol(finishCell)
    local dist = ((c2-c1) + (r2-r1))
    if dist == 0 then return false end
    table.insert(data.MoveAnims, {C = startCell,
        CF = data.MoveFrames * math.abs(dist),
        F = data.MoveFrames*math.abs(dist),
        X = (c2-c1)* ((data.cell_size*1.2)/(data.MoveFrames*math.abs(dist))),
        Y = (r2-r1)* ((data.cell_size*1.2)/(data.MoveFrames*math.abs(dist)))
    }); 
end
function GetRowAndCol(cellid, lot) lot = lot or set.tzft.square_lot; return math.ceil(cellid/lot), (cellid%lot == 0 and lot or cellid%lot) end
local MovesData = {
    [1] = { -- left
        GetNC = function(i, lot) return i end,
        GetEdge = function(NC, lot) return (NC%lot ~= 0) end,
        GetForVars = function(NC, lot) return NC+1, math.ceil(NC/lot)*lot, 1 end,
    }, [2] = { -- right
        GetNC = function(i, lot) return math.ceil(i/lot)*lot +1 - (i%lot ~= 0 and i%lot or lot) end,
        GetEdge = function(NC, lot) return (NC%lot ~= 1) end,
        GetForVars = function(NC, lot) return NC-1, (1 + lot*(math.ceil(NC/lot)-1)), -1 end,
    }, [3] = { -- up
        GetNC = function(i, lot) return (math.ceil(i/lot)-1) + lot*((i%lot == 0 and lot or i%lot)-1) + 1 end,
        GetEdge = function(NC, lot) return NC <= lot*(lot-1) end,
        GetForVars = function(NC, lot) return NC+lot, NC + lot*(lot-math.ceil(NC/lot)), lot end,
    }, [4] = { -- down
        GetNC = function(i, lot) return lot^2 -(lot-math.ceil(i/lot)) - lot*((i%lot == 0 and lot or i%lot)-1) end,
        GetEdge = function(NC, lot) return NC > lot end,
        GetForVars = function(NC, lot) return NC-lot, (NC%lot == 0 and lot or NC%lot), -lot end,
}   }
function Move(kuda)
   if params.game_step ~= 1 then return false end
   if #data.MoveAnims > 0 then return false end
    local lot = set.tzft.square_lot
    local i = 0
    while i < lot^2 do
        i = i + 1
        local NC = MovesData[kuda].GetNC(i,lot) -- nums for right
        if MovesData[kuda].GetEdge(NC,lot) then
            local ForVar1, ForVar2, ForVar3 = MovesData[kuda].GetForVars(NC,lot)
            for j = ForVar1, ForVar2, ForVar3 do
                if data.mainTable[NC] == 0 and data.mainTable[j] ~= 0 then
                    AddMoveAnim(j, NC);
                    data.mainTable[NC] = data.mainTable[j]; data.mainTable[j] = 0;
                    i = i - 1; break
                elseif data.mainTable[j] ~= 0 then
                    if data.mainTable[j] ~= data.mainTable[NC] then
                        AddMoveAnim(j, NC+ForVar3);
                        data.mainTable[NC+ForVar3] = data.mainTable[j]
                        if NC+ForVar3 ~= j then data.mainTable[j] = 0 end
                        break
                    else
                        AddMoveAnim(j, NC);
                        data.mainTable[NC] = data.mainTable[NC]*2; data.mainTable[j] = 0; data.score = data.score + data.mainTable[NC]; break
end end end end end end
function CAUMaxScore()
    set.tzft.bestscore = math.max(set.tzft.bestscore, data.score);
    set.tzft.score = 0; set.lastgame = {}
    ini.save(set, data.ininame)
end
function afterMove()
    if #data.MoveAnims == 0 then return false end
    data.MoveAnims = {}
    -- check lose
    lot = set.tzft.square_lot
    local function IsCellValid(cellid) if cellid > 0 and cellid < 17 then return true else return false end end;
    local function CheckLose()
        for i = 1, lot^2 do
            if data.mainTable[i] == 0 then return false end
            if IsCellValid(i + 1)   and data.mainTable[i] == data.mainTable[i + 1]   then return false end
            if IsCellValid(i - 1)   and data.mainTable[i] == data.mainTable[i - 1]   then return false end
            if IsCellValid(i + lot) and data.mainTable[i] == data.mainTable[i + lot] then return false end
            if IsCellValid(i - lot) and data.mainTable[i] == data.mainTable[i - lot] then return false end
        end
        return true
    end
    local rnd; 
    repeat rnd = random(1, lot^2) until data.mainTable[rnd] == 0
    data.mainTable[rnd] = (random(1, 4) == 4 and 4 or 2)
    if CheckLose() then params.game_step = 0; CAUMaxScore(); end
    -- check win
    for i = 1, lot^2 do if data.mainTable[i] == 2^set.tzft.final then params.game_step = 2; CAUMaxScore(); end end
    for i, v in ipairs(data.mainTable) do data.renderTable[i] = v; set.lastgame[i] = v end
    set.tzft.score = data.score; ini.save(set, data.ininame);
end
function main()
   while not isSampAvailable() do wait(100) end
    for i, v in pairs(set.lastgame) do data.mainTable[i] = v end
    data.score = set.tzft.score
   --sampRegisterChatCommand('2048', function() if WinOpen[0] == false then Start2048() else WinOpen[0] = false end end)
   wait(-1)
end
function GetPow(c) return (math.floor(math.log(c,2)+0.5)) end
imgui.OnInitialize(function()
--    imgui.GetIO().Fonts:Clear()
    FontForCells =  imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 100, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
end)
local Win = imgui.OnFrame(function() return WinOpen[0] end,
function(player)
    if imgui.GetFrameCount() == 1 then sampAddChatMessage("[2048] {ffffff}Для открытия/закрытия меню настроек нажмите ПКМ в любом месте окна", 0xFFdae4ee) end
    imgui.GetIO().ConfigWindowsMoveFromTitleBarOnly = true
   imgui.Begin('2048', WinOpen, imgui.WindowFlags.NoScrollbar)
   local dl = imgui.GetWindowDrawList()
   local WP = imgui.GetWindowPos()
   local WS = imgui.GetWindowSize()
   if not data.settings then
    if imgui.IsMouseDragging() and #data.swipe_pos == 0 and imgui.GetMousePos().y > WP.y+20 and imgui.GetMouseCursor() == 0 then data.swipe_pos[1] = imgui.GetMousePos()
    elseif not imgui.IsMouseDragging() and #data.swipe_pos == 1 then data.swipe_pos[2] = imgui.GetMousePos(); Swipe(data.swipe_pos); data.swipe_pos = {} end
   local Vec2 = imgui.ImVec2
    dl:AddRectFilled(WP, Vec2(WP.x+WS.x+15, WP.y+WS.y), 0xFF727b89)
        local OffsetYforInfo = data.cell_size
      data.cell_size = (math.min(WS.x-5, WS.y-30-OffsetYforInfo))/(set.tzft.square_lot*1.2)

        dl:AddRectFilled({
                x = WP.x + set.tzft.square_lot*0.6*data.cell_size - data.cell_size*2,
                y = WP.y + OffsetYforInfo*0.6+30-data.cell_size/4
            }, {
                x = WP.x + set.tzft.square_lot*0.6*data.cell_size - data.cell_size*0.5,
                y = WP.y + OffsetYforInfo*0.6+30+data.cell_size/4
            }, 0xFFb4c1d2, 15
        )
        local ScoreText = "Score: "..data.score
        imgui.SetWindowFontScale(data.cell_size/70)
        imgui.SetCursorPos({
            x = set.tzft.square_lot*0.6*data.cell_size - data.cell_size*1.25 - imgui.CalcTextSize(ScoreText).x/2,
            y = OffsetYforInfo*0.6+30 - imgui.CalcTextSize(ScoreText).y/2,
        }); imgui.TextColored(imgui.ColorConvertU32ToFloat4(0xFF656e77), ScoreText);

            dl:AddRectFilled({
                x = WP.x + set.tzft.square_lot*0.6*data.cell_size + data.cell_size*0.5,
                y = WP.y + OffsetYforInfo*0.6+30-data.cell_size/4
            }, {
                x = WP.x + set.tzft.square_lot*0.6*data.cell_size + data.cell_size*2,
                y = WP.y + OffsetYforInfo*0.6+30+data.cell_size/4
            }, 0xFFb4c1d2, 15
        )
        ScoreText = "Max: "..set.tzft.bestscore
        imgui.SetWindowFontScale(data.cell_size/70)
        imgui.SetCursorPos({
            x = set.tzft.square_lot*0.6*data.cell_size + data.cell_size*1.25 - imgui.CalcTextSize(ScoreText).x/2,
            y = OffsetYforInfo*0.6+30 - imgui.CalcTextSize(ScoreText).y/2,
        }); imgui.TextColored(imgui.ColorConvertU32ToFloat4(0xFF656e77), ScoreText);


        imgui.SetWindowFontScale(1)
      local cpos = {x = 10, y = 30+OffsetYforInfo}
      for i = 1, set.tzft.square_lot*set.tzft.square_lot do
        dl:AddRectFilled(
           {x = WP.x + cpos.x, y = WP.y + cpos.y},
           {x = WP.x + cpos.x + data.cell_size, y = WP.y + cpos.y + data.cell_size},
           0xFFb4c1d2, data.cell_size^0.5
        )
        cpos.x = cpos.x + data.cell_size + data.cell_size/5
        if (i % set.tzft.square_lot) == 0 then cpos.x = 10; cpos.y = cpos.y + data.cell_size + data.cell_size/5 end
    end; cpos = {x = 10, y = 30+OffsetYforInfo}
      for i = 1, set.tzft.square_lot*set.tzft.square_lot do
         imgui.SetCursorPos(cpos)
         if data.renderTable[i] > 0 then
            local TextColor, BGColor, CText = GetCellInfo(GetPow(data.renderTable[i]))
            TextColor = imgui.ColorConvertU32ToFloat4(TextColor)

   imgui.PushFont(FontForCells)
            imgui.SetWindowFontScale(data.cell_size/(100*(math.ceil(CText:len()/2))))
            local texts = imgui.CalcTextSize(CText)
            local offsetX, offsetY = 0, 0
            if GetAnimInfo(i) then
                v = GetAnimInfo(i)
                offsetX = v.X * (v.CF-v.F)
                offsetY = v.Y * (v.CF-v.F)
            end
            dl:AddRectFilled(
               {x = offsetX + WP.x + cpos.x, y = offsetY + WP.y + cpos.y},
               {x = offsetX + WP.x + cpos.x + data.cell_size, y = offsetY + WP.y + cpos.y + data.cell_size},
               BGColor, data.cell_size^0.5
            )

            imgui.SetCursorPos({x = offsetX + cpos.x + data.cell_size/2 - texts.x/2, y = offsetY + cpos.y + data.cell_size/2 - texts.y/2})
            imgui.TextColored(TextColor, CText);

            imgui.SetWindowFontScale(1.0)
      imgui.PopFont()
         end

         cpos.x = cpos.x + data.cell_size + data.cell_size/5
         if (i % set.tzft.square_lot) == 0 then cpos.x = 10; cpos.y = cpos.y + data.cell_size + data.cell_size/5 end
      end
   if params.game_step == 0 then
        dl:AddRectFilled({
            x= WP.x + 10, y = WP.y + 30+OffsetYforInfo}, {
            x= WP.x + 10 + (set.tzft.square_lot-1)*data.cell_size*1.2 + data.cell_size+1,
            y= WP.y + 30+OffsetYforInfo + (set.tzft.square_lot-1)*data.cell_size*1.2 + data.cell_size+1},
            0xBB000000, 7
        )
        local LoseTexts = {
            u8"К сожалению Вы проиграли.",
            u8"Но Вы можете попробовать снова!",
        }

        for i, v in pairs(LoseTexts) do
            local CalcNowText = imgui.CalcTextSize(v)
            imgui.SetCursorPos({x=10+((set.tzft.square_lot)/2-1)*data.cell_size*1.2+data.cell_size-CalcNowText.x/2, y = 30+OffsetYforInfo + CalcNowText.y*(i-1)})
            imgui.Text(v)
        end
   elseif params.game_step == 2 then
        dl:AddRectFilled({
            x= WP.x + 10, y = WP.y + 30+OffsetYforInfo}, {
            x= WP.x + 10 + (set.tzft.square_lot-1)*data.cell_size*1.2 + data.cell_size+1,
            y= WP.y + 30+OffsetYforInfo + (set.tzft.square_lot-1)*data.cell_size*1.2 + data.cell_size+1},
            0xBB000000, 7
        )
        local WinTexts = {
            u8"Поздравляю, Вы победили!",
            u8"Можете попробовать более высокую цель!",
        }

        for i, v in pairs(WinTexts) do
            local CalcNowText = imgui.CalcTextSize(v)
            imgui.SetCursorPos({x=10+((set.tzft.square_lot)/2-1)*data.cell_size*1.2+data.cell_size-CalcNowText.x/2, y = 30+OffsetYforInfo + CalcNowText.y*(i-1)})
            imgui.Text(v)
        end
   end
   --[[imgui.Separator()
   imgui.SetCursorPosX(53)
   if imgui.Button('Up', imgui.ImVec2(45,45)) then MaMtoup() end
   imgui.SetCursorPosX(0)
   if imgui.Button('Left', imgui.ImVec2(45,45)) then MaMtoleft() end imgui.SameLine()
   if imgui.Button('Down', imgui.ImVec2(45,45)) then MaMtodown() end imgui.SameLine()
   if imgui.Button('Right', imgui.ImVec2(45,45)) then MaMtoright() end
   imgui.Text(u8'Количество клеток на одной стороне:') imgui.SameLine() imgui.SetNextItemWidth(75)
   if imgui.InputInt('  ', imgui_square_lot) then
   if imgui_square_lot[0] < 4 then sampAddChatMessage('{00FF00}[2048]{FFFFFF} Количество клеток на одной стороне не может быть меньше четырёх!') imgui_square_lot[0] = 4
   elseif imgui_square_lot[0] ~= nil then set.tzft.square_lot = imgui_square_lot[0] Start2048() end end
   if imgui.Button(u8'Начать сначала') then Start2048() end]]
   if #data.MoveAnims > 0 then for i, v in ipairs(data.MoveAnims) do
        data.MoveAnims[i].F = data.MoveAnims[i].F - 1
        if data.MoveAnims[i].F <= 0 then
            data.MoveAnims[i].F = 0
            local allf = 0; for i, v in ipairs(data.MoveAnims) do allf = allf + v.F end
            --data.MoveAnims[i].FF()
            --table.remove(data.MoveAnims, i)
           --print(v.C, v.CF)
            if allf == 0 then afterMove(); break
    end end end end
    else
        imgui.PushTextWrapPos(WS.x)
        imgui.Text(u8[[
Управление:
    Вверх/Влево/Вправо/Вниз: W/A/S/D соответственно
    Рестарт игры: R
    Закрыть окно с игрый: Backspace

Информация:
    Так же предусмотрено управление свайпами мышки
    Для перемещения окна - перемещайте за титлбар (синяя полоска сверху)
    Помимо сохранения лучшего счёта сохраняется и игра, то есть после перезапуска игры/скриптов вы сможете продолжить партию

Настройки:
]])
        imgui.Text(u8"Выберите ниже конечную цель игры:")
        imgui.PushStyleColorU32(imgui.Col.Text, 0)
        imgui.SetNextItemWidth(-1)
        imgui.SliderInt("##final",imgui_final,6,20)
        imgui.PopStyleColor(1)
        local Val = tostring(2^imgui_final[0])
        local ValC = imgui.CalcTextSize(Val)
        imgui.SetCursorPos({x = WS.x/2-ValC.x/2,y=imgui.GetCursorPosY()-ValC.y*1.5}); imgui.Text(Val)

        imgui.Text(u8"Выберите ниже конечную цель игры:")
        imgui.PushStyleColorU32(imgui.Col.Text, 0)
        imgui.SetNextItemWidth(-1)
        imgui.SliderInt("#squareLot", imgui_square_lot, 4, 10)
        imgui.PopStyleColor(1)
        local Val = tostring(imgui_square_lot[0]..'x'..imgui_square_lot[0])
        local ValC = imgui.CalcTextSize(Val)
        imgui.SetCursorPos({x = WS.x/2-ValC.x/2,y=imgui.GetCursorPosY()-ValC.y*1.5}); imgui.Text(Val)

        imgui.SetWindowFontScale(0.85)
        imgui.Text(u8"Все изменения будут применены и сохранены только при старте новой игре")
        imgui.Text(u8"Для того что бы принудильно запустить новую игру: Выйдите из настроек и нажмите R")
        imgui.PopTextWrapPos()
        imgui.SetWindowFontScale(1)
    end
    if imgui.IsMouseReleased(1) and params.game_step == 1 then data.settings = not data.settings end
   imgui.End()
end)
function GetCellInfo(power)
   --                             number,   bg
   if     power == 1 then return 0xFF656e77, 0xFFdae4ee, "2";
   elseif power == 2 then return 0xFF656e77, 0xFFc8e0ed, "4";
   elseif power == 3 then return 0xFFf2f6f9, 0xFF79b1f2, "8";
   elseif power == 4 then return 0xFFf2f6f9, 0xFF6395f5, "16";
   elseif power == 5 then return 0xFFf2f6f9, 0xFF5f7cf6, "32";
   elseif power == 6 then return 0xFFf2f6f9, 0xFF3b5ef6, "64";
   elseif power == 7 then return 0xFFf2f6f9, 0xFF72cfed, "128";
   elseif power == 8 then return 0xFFf2f6f9, 0xFF61cced, "256";
   elseif power == 9 then return 0xFFf2f6f9, 0xFF50c8ed, "512";
   elseif power ==10 then return 0xFFf2f6f9, 0xFF3fc5ed, "1024";
   elseif power ==11 then return 0xFFf2f6f9, 0xFF2ec2ed, "2048";
   elseif power ==12 then return 0xFFf2f6f9, 0xFF333a3d, "4096";
   elseif power ==13 then return 0xFFf2f6f9, 0xFF333a3d, "8192";
   elseif power ==14 then return 0xFFf2f6f9, 0xFF333a3d, "16K";
   elseif power ==15 then return 0xFFf2f6f9, 0xFF333a3d, "32K";
   elseif power ==16 then return 0xFFf2f6f9, 0xFF333a3d, "65K";
   elseif power ==17 then return 0xFFf2f6f9, 0xFF333a3d, "131K";
   elseif power ==18 then return 0xFFf2f6f9, 0xFFc46b69, "262K";
   elseif power ==19 then return 0xFFf2f6f9, 0xFFc46b69, "524K";
   elseif power ==20 then return 0xFFf2f6f9, 0xFFc46b69, "1048K";
end end
addEventHandler('onWindowMessage', function(msg, key)
    if WinOpen[0] and msg == 0x0100 then
        if     key == 0x57 and not data.settings then Move(3) -- up
        elseif key == 0x53 and not data.settings then Move(4) -- down
        elseif key == 0x41 and not data.settings then Move(1) -- left
        elseif key == 0x44 and not data.settings then Move(2) -- right
        elseif key == 0x52 and not data.settings then data.mainTable = {}; Start2048()
        elseif key == 0x08 and not data.settings then WinOpen[0] = false
        else return; end
        consumeWindowMessage(true, true)
    end
end)
function Swipe(pos)
    local deltaX = math.max(pos[1].x, pos[2].x) - math.min(pos[1].x, pos[2].x)
    local deltaY = math.max(pos[1].y, pos[2].y) - math.min(pos[1].y, pos[2].y)
    if deltaY == deltaX then if math.random(0, 1) == 0 then deltaY = 0 else deltaX = 0 end end
    if deltaX > deltaY and deltaX > data.cell_size*0.6 then
        if pos[1].x > pos[2].x then Move(1) --left
        else Move(2) end -- right
    elseif deltaY > data.cell_size*0.6 then
        if pos[1].y > pos[2].y then Move(3) -- up
        else Move(4) end -- down
    end
end
-- sleash games (SampGameStore) project
local sleashGames = {}
sleashGames.v = 1
sleashGames.start = function() if WinOpen[0] == false then Start2048() else WinOpen[0] = false end end
sleashGames.name = u8"2048"
sleashGames.gitname = "2048.lua"
sleashGames.author = "Sleash"
sleashGames.description = u8[[2048 - переписанная под mimgui популярная головоломка, принцип которой в перемещении плиток]]
sleashGames.min_ver_sgs = 1
sleashGames.GetState = function() return WinOpen[0] end
sleashGames.SetState = function(st) WinOpen[0] = st end
return sleashGames
