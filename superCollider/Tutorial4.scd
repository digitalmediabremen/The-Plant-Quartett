// https://www.youtube.com/watch?v=-wDAPo9hpCg
// Topic: Envelopes - adsr, a custom signal shape
// Mostly for amplitude, also other parameters

// Line, start, end, dur, mul, add, doneAction

s.plotTree;
// bring up the localhost Node Tree Window: visualization of audio server

(
x = {
	var sig, env, freq;

	// doneAction 2: the server will free the synth automatically after the line is complete;
	// if there are more than one lines, whichever finishes first will free the synth

/*
	- Line: Generates a line from the start value to the end value in x second
	- XLine: exponential version of Line, not going to work with 0, has to be a very small number such as 0.01 -> sound nicer to human ears
	- EnvGen:
	levels: ex: [0, 1, 0] start from 0, rise to 1, return to 0
	times: ex: [1, 1] the size of this array is always one size smaller than the levels array, because they are connecting segments between levels
	curve:
	- adsr

*/


	env = XLine.kr(1, 0.01, 5, doneAction:2);
	// We also perceive frequency exponentially
	freq = XLine.kr(880, 100, 1, doneAction:0);
	sig = Pulse.ar(freq)*env;

	// if you want to work with db, use line instead of XLline
	// env.dbamp will translate the result to db
	/*
	env = Line.kr(0, -40, 1, doneAction:2);
	sig = Pulse.ar(ExpRand(30,500)) * env.dbamp;
	*/
}.play;
)
x.free; // only free the most recently created sync
s.freeAll; // free all sync on the server

// plot the env
Env.new.plot;

(
x = {
	arg t_gate = 1;
	// arg gate = 0;
	// the trigger occurs when the gate changes from non positive to positive
	// -> need to reset gate to re trigger or use a t_ argument [automatically return to 0 after done]
	var sig, env;
	env = EnvGen.kr(Env.new([0,1,0.2,0],[0.5,1,2],[-3,3,0]),
		t_gate, doneAction:2);
	sig = Pulse.ar(LFPulse.kr(8).range(600,900))* env;

}.play;
)
x.set(\gate, 1);


(
z = {
	arg gate = 0;

	var sig, env;
	env = EnvGen.kr(Env.adsr, gate);
	sig = VarSaw.ar(SinOsc.kr(16).range(500,1000))* env;

}.play;
)
z.set(\gate, 1); // better use gate instead of t_gate for a sustainable envelope
z.free;

Env.new([0.01,1,0.2,0.01], [0.5,1,2], \exp).plot;

// another way to do it:
// use a third array to specify segment curvatures
// positive values: slowly first, then quickly
// negative values: quickly first, then slowly

Env.new([0,1,0.2,0], [0.5,1,2], [-3,3,0]).plot;