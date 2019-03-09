local P = {}

P.base = "e_base"
P.eid = 0
P.pos = v(200,200)
P.health = 100
P.thirst = 0
P.hunger = 0
P.facing = 0

function P:init()
    e.timer:new("testPlayerStatTick"..self.eid, 0.1, true, false, function()
        self.thirst = self.thirst + math.random(0,1)
        self.hunger = self.hunger + math.random(0,1)
        self.health = self.health - math.max(0, ((self.thirst+self.hunger-100)/100))
    end)
end

function P:think()
    
    local dt = e.dt
    local mousePosWorld = love.mouse.getPosition()
    self.facing = (self.pos+e.vp):bearing2D(mousePosWorld)
    
    local strafeLeft, strafeRight = (self.pos+e.vp):tangent2D(mousePosWorld, 200)
    self.strafPos = {strafeLeft, strafeRight}
    if self.health <= 0 then return false end
    if love.keyboard.isDown("up") then
        self.pos = v( self.pos.x+((math.sin(self.facing)*100)*dt), self.pos.y+((math.cos(self.facing)*100)*dt) )
    end
    if love.keyboard.isDown("down") then
        self.pos = v( self.pos.x-((math.sin(self.facing)*100)*dt), self.pos.y-((math.cos(self.facing)*100)*dt) )
    end
    if love.keyboard.isDown("left") then
        self.pos = self.pos + ((strafeLeft-(self.pos+e.vp))*dt)
    end
    if love.keyboard.isDown("right") then
        self.pos = self.pos + ((strafeRight-(self.pos+e.vp))*dt)
    end
    
end


function P:draw()
    e.setColorNormalised(1,1,1,1)
    love.graphics.circle("fill", self.pos+e.vp, 10)
    local a = math.pi/8
    local b = (math.pi*2) - a
    local percentage = math.max(math.min((self.health)/100, 1), 0.125/2)
    
    e.setColorNormalised(1-percentage,percentage,0,1)
    e.graphics.arch("fill", true, self.pos+e.vp, 50, 45, a, b*percentage, 16, false)
    
    local percentage = math.min((self.thirst+12.5)/100, 1)
    e.setColorNormalised(percentage,0,1-percentage,1)
    
    local pMod = 0
    if b*percentage < a then pMod = a end
    e.graphics.arch("fill", true, self.pos+e.vp, 42, 36, a, (b*percentage)+pMod, 16, false)
    
    local percentage = math.min((self.hunger+12.5)/100, 1)
    local pMod = 0
    if b*percentage < a then pMod = a end
    e.setColorNormalised(1,1-percentage,0,1)
    e.graphics.arch("fill", true, self.pos+e.vp, 33, 28, a, (b*percentage)+pMod, 16, false)
    
    e.setColorNormalised(1,0,1,1)
    e.olLine(self.strafPos[1].x,self.strafPos[1].y,self.strafPos[2].x,self.strafPos[2].y)
    e.olLine(0+e.vp.x, 0+e.vp.y, self.pos.x+e.vp.x, self.pos.y+e.vp.y)
end
return P