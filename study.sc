(SynthDef.new(\soft,
{|amp=1, sus=1, pan=0, freq=0, vib=0, fmod=0, rate=0, bus=0, blur=1, beat_dur=1, atk=0.01, decay=0.01, rel=0.01, peak=1, level=0.8|

var osc, env;
sus = sus * blur;
// freq = In.kr(bus, 1); // foxdot
freq = [freq, freq+fmod];
freq=(freq / 2);
amp=(amp / (200 * (1 + rate)));
//fixed frequency resonators
osc=Klank.ar(`[[7, 5, 3, 1], [8, 4, 2, 1], [2, 4, 8]], LFNoise0.ar((rate / sus)), freq);
// Klank: fixed frequency resonators
env=EnvGen.ar(Env(times: sus,levels: [0, amp, 0],curve: 'lin'), doneAction: 0);
//Env(times: 400,levels: [0, 1000, 0],curve: 'lin').plot;
osc=(osc * env);
osc = Mix(osc) * 0.5;
osc = Pan2.ar(osc, pan);
// FoxDot uses 'ReplaceOut', but it only plays the audio once
Out.ar(bus, osc);
}
).add;
)

(SynthDef.new(\newSoft,
{|amp=1, sus=1, pan=0, freq=0, vib=0, fmod=0, rate=0, bus=0, blur=1, beat_dur=1, atk=0.01, decay=0.01, rel=0.01, peak=1, level=0.8|

var osc, env;
sus = sus * blur;
// freq = In.kr(bus, 1); // foxdot
freq = [freq, freq+fmod];
freq=(freq / 2);
amp=(amp / (200 * (1 + rate)));
//fixed frequency resonators
osc=Klank.ar(`[[9, 7, 5, 3, 1], [8, 4, 2, 1], [2, 4, 8, 16]], LFNoise0.ar((rate / sus)), freq);
// Klank: fixed frequency resonators
env=EnvGen.ar(Env(times: sus,levels: [0.01, amp, 0.01], curve: 'squared'), doneAction: 0);
//
osc=(osc * env);
osc = Mix(osc) * 0.5;
osc = Pan2.ar(osc, pan);
// FoxDot uses 'ReplaceOut', but it only plays the audio once
Out.ar(bus, osc);
}
).add;
)
//Env(times: 400,levels: [0, 1000, 0],curve: 'squared').plot;

(
SynthDef.new(\ripple,
{|amp=1, sus=1, pan=0, freq=0, vib=0, fmod=0, rate=0, bus=0, blur=1, beat_dur=1, atk=0.01, decay=0.01, rel=0.01, peak=1, level=0.8|
var osc, env;
sus = sus * blur;
// freq = In.kr(bus, 1); // foxdot

// base frequency and a freq modified by fmod
freq = [freq, freq+fmod];
amp=(amp / 6);

//  + w=0.5 square wave, *0.5
osc=(Pulse.ar((freq / 4), 0.2, 0.25) + Pulse.ar((freq + 1), 0.5, 0.5));
osc=(osc * SinOsc.ar((rate / sus), 0, 0.5, 1));

env=EnvGen.ar(Env(times: [(0.55 * sus), (0.55 * sus)],levels: [0, amp, 0],curve: 'lin'), doneAction: 0);

osc=(osc * env);
osc = Mix(osc) * 0.5;
osc = Pan2.ar(osc, pan);
Out.ar(bus, osc)}
).add;
)

(
SynthDef.new(\newRipple,
{|amp=1, sus=1, pan=0, freq=0, vib=0, fmod=0, rate=0, bus=0, blur=1, beat_dur=1, atk=0.01, decay=0.01, rel=0.01, peak=1, level=0.8|
var osc, env;
sus = sus * blur;
// freq = In.kr(bus, 1); // foxdot
freq = [freq+fmod]; // remove base freq?
amp=(amp / 6);
osc=(Pulse.ar((freq), 0.3, 0.25) + Pulse.ar((freq + 1), 0.5, 0.5));
osc=(osc * SinOsc.ar((rate / sus), 0, 0.1, 1));

env=EnvGen.ar(Env(times: [(0.55 * sus), (0.55 * sus)],levels: [0.01, amp, 0.01],curve: 'lin'), doneAction: 0);

osc=(osc * env);
osc = Mix(osc) * 0.5;
osc = Pan2.ar(osc, pan);
Out.ar(bus, osc)}
).add;
)
newRipple = FileSynthDef("newRipple")
newRipple.add()
// 0 c -> 261, c# 277
x = Synth.new(\newRipple, [\freq,277, \fmod, 33, \amp,0.4, \sus, 10]);
x = Synth.new(\newSoft, [\freq, 277, \fmod, 30, \amp,0.3, \sus, 5]);

// fmod: how to do the linvar and expvar?
x.free;
