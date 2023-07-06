randomNumber1 = math.random(0, 100)
randomNumber2 = math.random(0, 100)
randomNumber3 = math.random(0, 100)
randomNumber4 = math.random(0, 100)

-- Moet aangepast worden naar iets anders dan os.sleep. De script verbruikt teveel CPU kracht.

grp.write('5/3/5', randomNumber1)
os.sleep(1)
grp.write('5/3/6', randomNumber2)
os.sleep(1)
grp.write('5/3/7', randomNumber3)
os.sleep(1)
grp.write('5/3/8', randomNumber4)
os.sleep(1)
