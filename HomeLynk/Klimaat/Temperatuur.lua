--Start Parameters----------------------------------------------------

AddressInverted = '2/6/6'
AddressCurrent = '2/6/2'
AddressSetpoint = '2/6/1' 
AddressOutput = '2/6/7'
ManualMode = false
MinimumOutputValue = 0
MaximumOutputValue = 100
KPValue = 1
KIValue = 1
KDValue = 1

AlertText1 = 'Melding van script: ' .. _SCRIPTNAME .. ' "Kan objectwaarde ' .. AddressInverted .. ' zomer/winterbedrijf niet ophalen"' 
AlertText2 = 'Melding van script: ' .. _SCRIPTNAME .. ' "Kan objectwaarde ' .. AddressCurrent .. ' huidige temperatuur niet ophalen"'
AlertText3 = 'Melding van script: ' .. _SCRIPTNAME .. ' "Kan objectwaarde ' .. AddressSetpoint .. ' ingestelde setpoint niet ophalen"'

--End Parameters-------------------------------------------------------

-- init pid algorithm
require('user.pid')

ValueInverted = grp.getvalue(AddressInverted)
ValueCurrent = grp.getvalue(AddressCurrent)
ValueSetpoint = grp.getvalue(AddressSetpoint)

if ValueInverted == nil or ValueCurrent == nil or ValueSetpoint == nil then
  if ValueInverted == nil then
  	alert(AlertText1)
  end
  if ValueCurrent == nil then
  	alert(AlertText2)
  end
  if ValueSetpoint == nil then
  	alert(AlertText3)
  end
return -- Exit Script
end

if ManualMode == true then
	ManualValue = 1
else
	ManualValue = 0
end  

if ValueInverted then
  ValueInverted = false
end

if not p then
  p = PID:init({
    current = AddressCurrent,
    setpoint = AddressSetpoint,
    output = AddressOutput,
    inverted = ValueInverted,
    manual = ManualValue,
    min = MinimumOutputValue,
    max = MaximumOutputValue,
    kp = KPValue,
    ki = KIValue,      
    kd = KDValue     
    --use for multiple output
    --output = { AddressOutput, AddressOutput1, AddressOutput2 }
  })
else
  -- Check if ValueInverted is changed, if yes update param table
  if p.params.inverted ~= ValueInverted then
  	 p.params.inverted = ValueInverted
  	 if p.params.inverted then
      -- reverse gains in inverted mode
      if p.params.kp == KPValue then 
    	   p.params.kp = -p.params.kp
      end
      if p.params.ki == KIValue then 
    	   p.params.ki = -p.params.ki
      end
      if p.params.kd == KDValue then 
    	   p.params.kd = -p.params.kd
      end
     else
     -- reverse gains in normal mode
      if p.params.kp ~= KPValue then 
    	   p.params.kp = KPValue
      end
      if p.params.ki ~= KIValue then 
    	   p.params.ki = KIValue
      end
      if p.params.kd ~= KDValue then 
    	   p.params.kd = KDValue
      end 
  	 end
  end
  -- Check if ManualMode is changed, if yes update param table
  if p.params.manual ~= ManualValue then
  	 p.params.manual = ManualValue
  end
end

-- run algorithm
p:run()