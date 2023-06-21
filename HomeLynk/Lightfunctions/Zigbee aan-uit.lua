-- Zigbee On/Off met gebruik van common functions
zigbeeonoff = grp.getvalue('2/0/210') --boolean

conbeeUrl = '10.0.10.16'
conbeeApiKey = '0F7D702390'
conbeeLightId ='70:ac:08:ff:fe:97:09:58-01'

-- stuur aan/uitwaarde
requestObject = {
  	['on'] = zigbeeonoff,
	}

res, code = setConbeeVars(requestObject, conbeeUrl, conbeeApiKey, conbeeLightId)

if (code == 200) and (res[1]['error'] == nil) then
  grp.write('2/3/201', zigbeeonoff)
elseif (res[1]['error'] ~= nil) then
  log(res[1]['error'])
end