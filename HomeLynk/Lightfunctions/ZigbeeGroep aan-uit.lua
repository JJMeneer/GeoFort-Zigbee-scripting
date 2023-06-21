-- Zigbee On/Off met gebruik van common functions
zigbeeonoff = grp.getvalue('2/0/212') --boolean

knxGroupLightsAdresses = {'2/0/210', '2/0/211'}
knxGroupLightsFeedbackAdresses = {'2/3/201', '2/3/202'}

conbeeUrl = '10.0.10.16'
conbeeApiKey = '0F7D702390'
conbeeGroupId = 1

-- stuur aan/uitwaarde
requestObject = {
  	['on'] = zigbeeonoff,
	}

res, code = setConbeeVars(requestObject, conbeeUrl, conbeeApiKey, nil, conbeeGroupId)

if (code == 200) and (res[1]['error'] == nil) then
  grp.write('2/3/203', zigbeeonoff)
  for i, adress in ipairs(knxGroupLightsFeedbackAdresses) do
    grp.write(adress, zigbeeonoff)
  end
elseif (res[1]['error'] ~= nil) then
  log(res[1]['error'])
end