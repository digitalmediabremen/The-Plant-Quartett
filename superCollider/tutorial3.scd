// a synthdef is a receipe of sound generation
// and a synth is the execution of it
// Function.pl"/Users/cqx931/Desktop/superCollider/tutorial2.scd"ay -> short examples and quick testing
// SynthDef.play -> maximum flexibility & reuse

// name, ugenFunction,
/*(SynthDef.new(\sineTest, {
	arg noiseHz = 8;
	var freq, sig, amp;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise1.kr(12).exprange(0.02, 1);
	sig = SinOsc.ar(freq)*amp;
	// output, audio bus, index 0
	Out.ar(0, sig);
}).add;
)

// provide an array of variables to override
x = Synth.new(\sineTest, [\noiseHz, 32]);

x.set(\noiseHz, 12)
x.free;*/

(SynthDef.new(\pulseTest, {
	arg ampHz = 4, fund = 40, maxPartial = 4, width = 0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2;
    amp1 = LFPulse.kr(4, 0, 0.12)*0.75; // how does this work?
	amp2 = LFPulse.kr(4, 0.5, 0.12)*0.75;
	freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(6, add:1);

	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	// add some reverb
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
	sig2 = FreeVerb.ar(sig2, 0.7, 0.8, 0.25);
	//[0, 1] --add 1--> [1,2]

	Out.ar(0, sig1);
	Out.ar(1, sig2);
	// one for left, one for right speaker

}).add;
)

x = Synth.new(\pulseTest);
x.set(\width, 0.05)
x.free;

