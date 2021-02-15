data = [342.99,343.21,340.79,342.055,341.55,343.01,344.035,344.48,344.33,344.725,345.115,345.365,345.38,345.055,345.445,345.895,345.555,345.79,346.29,346.615,346.62,346.81,345.885,346.405,346.27,346.865,347.28,346.89,346.265,346.505,347.04,346.66,347.36,346.345,346.605,347.32,348.27,348.115,347.805,347.94,348.365,348.275,347.765,348.535,348.255,349.065,349.11,348.665,348.485,348.76,348.555,347.35,347.13,349.79,352.815,352.835,351.91,363.23,373.54,377.505,380.485,381.985,379.64,375.47,374.43,382.325,399.225,408.11,406.345,397.92,386.215,378.725,380.365,395.07,409.215,410.82,404.66,395.31,389.11,398.115,411.27,411.695,407.51,404.595,410.425,409.46,401.815,394.32,389.075,383.145,378.155,380.56,387.995,396.005,394.705,390.57,387.35,381.48,375.635,370.83,367.815,363.88,363.09,361.875,360.0,360.1,360.915,359.855,359.99,358.905,359.04,359.115,358.415,359.21,358.86,359.3,358.105,359.06,359.31,359.055,357.815,358.235,357.875,358.29,359.44,358.81,358.77,359.445,359.805,359.39,360.2,360.19,361.18,360.42,359.465,360.405,359.835,360.68,360.05,359.97,360.395,361.375,358.93,360.15]
deltaData = [ ]
hourAvgs = [ ]
lastN = 342.99
mul = 2

def translate(value, leftMin, leftMax, rightMin, rightMax):
    # https://stackoverflow.com/questions/1969240/mapping-a-range-of-values-to-another
    # Figure out how 'wide' each range is
    leftSpan = leftMax - leftMin
    rightSpan = rightMax - rightMin
    # Convert the left range into a 0-1 range (float)
    valueScaled = float(value - leftMin) / float(leftSpan)
    # Convert the 0-1 range into a value in the right range.
    return rightMin + (valueScaled * rightSpan)
for n in data:
    v = round(translate((n - lastN),-12,20,0,1), 4)
    deltaData.append(v)
    lastN = n
for i in range(5, len(data), 6):
    hourAv = (data[i] + data[i-1] + data[i-2] + data[i-3] + data[i-4])/5
    hourAvgs.append(round(hourAv, 0))
print(hourAvgs)
print(deltaData)


p0 >> pluck([250,270],  dur=2, sus=4, amp=[0.3,1]).after(8, "stop")

Scale.default = "freq"
u = 0.5
p1 >> soft(data, dur=u, sus=u*2, amp=deltaData, shape = deltaData).after(len(data)*u, "stop")
p2 >> sinepad(hourAvgs,  dur=u*6, sus=u*8, amp=0.5, mix = 0.9, room=0.1).after(len(data)*u, "stop")
