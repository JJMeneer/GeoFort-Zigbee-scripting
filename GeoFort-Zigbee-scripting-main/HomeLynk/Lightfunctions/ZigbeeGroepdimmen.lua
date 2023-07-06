knxLightAdress = '2/0/212'
knxLightStatus = '2/3/203'
knxBrightnessAdress = '2/1/202'
knxBrightnessFeedbackAdress = '2/3/206'

knxGroupLightsAdresses = {'2/0/210', '2/0/211'}
knxGroupLightsFeedbackAdresses = {'2/3/201', '2/3/202'}
knxGroupLightsBrightnessFeedbackAdresses = {'2/3/204', '2/3/205'}
knxvalue = grp.getvalue(knxBrightnessAdress)

conbeeUrl = '10.0.10.16'

conbeeAPIKey = '0F7D702390'

conbeeGroupId = 1

lightPercentageStep = 5

if (knxvalue == 1 or knxvalue == 9) then
  while (true)
    do
      knxvalue = grp.getvalue(knxBrightnessAdress)  
    	percentageBrightness = math.floor((getConbeeInfo(conbeeUrl, conbeeAPIKey, nil, conbeeGroupId).action.bri / 254) * 100)
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
    	res, code = setConbeeVars(requestObject, conbeeUrl, conbeeAPIKey, nil, conbeeGroupId)
    	if (code == 200) and (res[1]['error'] == nil) then
      	grp.write(knxLightAdress, 1)
 				grp.write(knxLightStatus, 1)
      	grp.write(knxBrightnessFeedbackAdress, newBrightness)
      	for i, adress in ipairs(knxGroupLightsFeedbackAdresses) do
        	grp.write(adress, 1)
      	end
      for i, adress in ipairs(knxGroupLightsBrightnessFeedbackAdresses) do
        	grp.write(adress, newBrightness)
      	end
      end
			os.sleep(0.2)
    
      if (knxvalue == 0 or knxvalue == 8) then break end
    	
  end
end
