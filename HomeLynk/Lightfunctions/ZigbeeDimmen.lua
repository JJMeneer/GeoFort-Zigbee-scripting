knxLightAdress = '2/0/210'
knxLightStatus = '2/3/201'
knxBrightnessAdress = '2/1/200'
knxBrightnessFeedbackAdress = '2/3/204'

knxvalue = grp.getvalue(knxBrightnessAdress)

conbeeUrl = '10.0.10.16'

conbeeAPIKey = '0F7D702390'

conbeeLightId = '70:ac:08:ff:fe:97:09:58-01'

lightPercentageStep = 5

if (knxvalue == 1 or knxvalue == 9) then
  while (true)
    do
      knxvalue = grp.getvalue(knxBrightnessAdress)  
      
    	percentageBrightness = math.floor((getConbeeInfo(conbeeUrl, conbeeAPIKey, conbeeLightId).state.bri / 254) * 100)
    	if (knxvalue == 1) then
      	newBrightness = percentageBrightness - lightPercentageStep
      	if(newBrightness < 0) then
        	newBrightness = 0
      	end
      
      elseif knxvalue == 9 then
      	newBrightness = percentageBrightness + lightPercentageStep
      	if(newBrightness > 100) then
        	newBrightness = 100
        end
      end
    	requestObject = {
      		["on"] = true,
          ["bri"] = math.floor((newBrightness/100)*254),
          ["transitiontime"] = 5
      }
    	res, code = setConbeeVars(requestObject, conbeeUrl, conbeeAPIKey, conbeeLightId)
    	if (code == 200) and (res[1]['error'] == nil) then
      	grp.write(knxLightAdress, 1)
 				grp.write(knxLightStatus, 1)
      	grp.write(knxBrightnessFeedbackAdress, newBrightness)
      end
			os.sleep(0.2)
    
      if (knxvalue == 0 or knxvalue == 8) then break end
    	
  end
end
