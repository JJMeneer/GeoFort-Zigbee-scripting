if not dmxhandler then
  require('user.dmx')
  -- Specificeer de port zoals verbonden met de HomeLynk, kanalen en transitietijd
  dmxhandler = DMX.init({
    port = '/dev/RS485', -- RS-485 port name
    channels = 8, -- number of DMX channels to use
    transition = 2, -- soft transition time in seconds
  })
end
 
dmxhandler:run()

