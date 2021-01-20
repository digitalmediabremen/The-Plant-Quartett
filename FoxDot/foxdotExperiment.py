Clock.bpm = 60
# All Instruments
#https://www.katarinahoeger.com/2019/04/23/live-code-lab-2019

# Effects
#('degree', 'oct', 'freq', 'dur', 'delay', 'buf', 'blur', 'amplify', 'scale', 'bpm', 'sample', 'env', 'sus', 'fmod', 'pan', 'rate', 'amp', 'midinote', 'channel', 'vib', 'vibdepth', 'slide', 'sus', 'slidedelay', 'slidefrom', 'glide', 'glidedelay', 'bend', 'benddelay', 'coarse', 'striate', 'buf', 'rate', 'pshift', 'hpf', 'hpr', 'lpf', 'lpr', 'swell', 'bpf', 'bpr', 'bpnoise', 'chop', 'tremolo', 'beat_dur', 'echo', 'echotime', 'spin', 'cut', 'room', 'mix', 'formant', 'shape', 'drive')

# Scales
# ['aeolian', 'altered', 'bebopDom', 'bebopDorian', 'bebopMaj', 'bebopMelMin', 'blues', 'chinese', 'chromatic', 'custom', 'default', 'diminished', 'dorian', 'dorian2', 'egyptian', 'freq', 'halfDim', 'halfWhole', 'harmonicMajor', 'harmonicMinor', 'hungarianMinor', 'indian', 'justMajor', 'justMinor', 'locrian', 'locrianMajor', 'lydian', 'lydianAug', 'lydianDom', 'lydianMinor', 'major', 'majorPentatonic', 'melMin5th', 'melodicMajor', 'melodicMinor', 'minMaj', 'minor', 'minorPentatonic', 'mixolydian', 'phrygian', 'prometheus', 'romanianMinor', 'susb9', 'wholeHalf', 'wholeTone', 'yu', 'zhi']

# Samples that I like:w, g, /,c,m; beat:s,h,x,v,n,:,~,-,=
#_ space
#p1 >> play('___-_-')

# Interesting instruments: ripple(long term), soft(shot term),space(hight)
p2 >> ripple((0, fmod=linvar([-200,3000], [4,100]), dur=30, sus=30, amp=0.4, pan=linvar([-1,1],8))
p2.stop()
# headphones VS speakers, duration in between [15,30]

rphrase1 = P[1,10,10,10,1,10,10].shuffle()
# 2
rphrase2 = P[2,1,10,10].shuffle()
# 3
rphrase3 = P[3,2,1,10,10,1,10].shuffle()
# rest
rphrase4 = P[1,30]

p3 >> soft(0, fmod=linvar([40,200], [rphrase1 | rphrase2 | rphrase3 | rphrase4]),
     dur=[rphrase1 | rphrase2 | rphrase3 | rphrase4], sus=5, amp=0.3)

# scd files
# https://github.com/Qirky/FoxDot/blob/master/FoxDot/osc/scsyndef/soft.scd
# ripple
# https://github.com/Qirky/FoxDot/blob/master/FoxDot/osc/scsyndef/ripple.scd
# Define your own synthdefs
# https://foxdot.org/docs/using-your-own-synthdefs/
# command + '.' to stop all sound
