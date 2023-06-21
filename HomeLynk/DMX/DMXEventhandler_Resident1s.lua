if not dmxhandler then
  require('user.dmx')
  dmxhandler = DMX.init({
    port = '/dev/RS485', -- RS-485 port name
    channels = 8, -- number of DMX channels to use
    transition = 2, -- soft transition time in seconds
  })
end
 
dmxhandler:run()

