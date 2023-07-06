-- Zigbee On/Off met gebruik van common functions
zigbeeonoff = grp.getvalue('2/0/211') --boolean

conbeeUrl = '10.0.10.16'
conbeeApiKey = '0F7D702390'
conbeeLightId ='70:ac:08:ff:fe:9c:98:fa-01'
log(zigbeeonoff)

-- stuur aan/uitwaarde
requestObject = {
  	['on'] = zigbeeonoff,
	}

res, code = setConbeeVars(requestObject, conbeeUrl, conbeeApiKey, conbeeLightId)
log(res)

if (code == 200) and (res[1]['error'] == nil) then
  grp.write('2/3/202', zigbeeonoff)
elseif (res[1]['error'] ~= nil) then
  log(res[1]['error'])
end