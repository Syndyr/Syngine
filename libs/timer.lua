print("Setting S table.")
s = {}
print("Setting s.timersrt, s.details, s.details.rt, s.averages, s.averages.rt1, s.timersfs values.")
s.timersrt = {}
s.details = {}
s.details.rt = {}
s.averages = {}
s.averages.rt1 = {}
s.timersfs = {}
local l = love
print("Defining s.timerClk function.")
function s.timerClk(N, T)
	if(s.timersrt[N] == nil or s.timersrt == nil)then
		return false
	end
	if(s.timersrt[N] <= T)then
		s.timersrt[N] = nil
		return true
	end
	return false
end
print("Defining s.timerRT function.")
function s.timerRT()
    T = love.timer.getTime()
	for k, v in pairs(s.timersfs) do
		if(v.delay <= T)then
			v.func()
			s.timersfs[k] = nil
		end
	end
end
print("Defining s.timerd function.")
function s.timerd(N, Delay)
	s.timersrt[N] = l.timer.getTime()+(Delay/1000)
end
print("Defining s.timerf function.")
function s.timerf(N, F, Delay)
	s.timersfs[N] = {func = F, delay = l.timer.getTime()+(Delay/1000)}
end
print("Defining s.stopTimer function.")
function s.stopTimer(N, T)
	if(T == 1)then
		s.timersrt[N] = nil
		return true
	end
	s.timersfs[N] = nil
end
print("libs.timer done.")