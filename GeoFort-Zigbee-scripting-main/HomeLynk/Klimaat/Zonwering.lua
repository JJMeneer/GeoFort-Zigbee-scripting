blindsAzimuth = 158.5
lat, long = 52.0838635, 5.1688253


blindsRange = {(blindsAzimuth - 90), (blindsAzimuth + 90)}


if blindsRange[1] < 0 then
  blindsRange[1] = 360 + blindsRange[1]
end

if blindsRange[2] > 360 then
  blindsRange[2] = (360 - blindsRange[2]) * -1
end

sunAltitude, sunAzimuth = getSunPos(lat, long, os.date('*t', os.time()))

log(sunAltitude)


if sunAzimuth > blindsRange[1] and sunAzimuth < blindsRange[2] then
  grp.write('2/7/1', (sunAltitude - 10))
  --set blinds to sunAltitude - nogiets

else
  grp.write('2/7/1', 0)
end



