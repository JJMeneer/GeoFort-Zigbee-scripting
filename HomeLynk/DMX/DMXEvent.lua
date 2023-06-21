-- Create objects with DMX tag, where last part of group address is DMX address (starting from 1). Create event script mapped to DMX tag. 

require('user.dmx')
-- get ID as group address last part (x/y/ID)
id = tonumber(event.dst:split('/')[3])
-- get event value (1 byte scaling)
value = event.getvalue()
-- convert from [0..100] to [0..255]
value = math.floor(value * 2.55)
-- set channel ID value
DMX.set(id, value)

