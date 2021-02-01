SerialPort.devices;
~port = SerialPort.new("/dev/cu.SLAB_USBtoUART", 9600);
~port.read

(
x = [ ];
30.do{x = x.add(~port.read)};
x = x.collect(_.asAscii);
)

(
~charArray = [ ];
~getValues = Routine.new({
	var ascii;
	{
		ascii = ~port.read.asAscii;
		// read: blocking read, carry the delay from arduino
		// next: non-blocking read
		if(ascii.isDecDigit, {
			~charArray = ~charArray.add(ascii)
		});
		if(ascii == $a, {
			// convert ~charArray to usable integer
			~val = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ]; // empty ~charArray
		})
	}.loop;
}).play;
)


l;

s.plotTree;
(
SynthDef.new(\sine,
{|amp=1, sus=1, pan=0, freq=0, vib=0, fmod=0, rate=0, bus=0, blur=1, beat_dur=1, atk=0.01, decay=0.01, rel=0.01, peak=1, level=0.8, delay = 0.1, max = 1|

var osc, env, carrier, modulator, carrfreq, modfreq;
sus = sus * blur;

// Amplitude Modulation
carrfreq= freq;
modfreq= exprand(0.02, max);// the reading number will be maped to modfreq

carrier= SinOsc.ar(carrfreq,0,0.5); // bipolar
modulator= SinOsc.ar(modfreq,0,0.1, 0.1); // unipolar

osc=(carrier*modulator);
//

osc = Mix(osc) * 0.5;
osc = Pan2.ar(osc, pan);

//Effect1: delay
osc = DelayN.ar(osc, 5, delay);
//Effect2: reverb: mix, room, damp
osc = FreeVerb.ar(osc, 0.4, 0.7,0.4);
//Effect3:lpf/hpf?

Out.ar(bus, osc)}
).add;
)

~synth = Synth(\sine, [\freq,~val,\amp,1]);
~synth2 = Synth.new(\sine, [\freq,~val+33, \amp,1, \delay, 3]);
~val

(
~control = Routine.new({
	{
		~synth.set(\max, ~val/1000);
		~synth2.set(\max, ~val/1000);
		/*~synth.set(\cutoff, ~val.linexp(200,300, 2000, 4000));
		~synth2.set(\cutoff, ~val.linexp(200,300, 2000, 4000));*/
		0.03.wait;
	}.loop;
}).play;
)
(
~control = Routine.new({
	{
		~synth.set(\freq, ~val);
		~synth2.set(\freq, ~val+33);
		10.wait;
	}.loop;
}).play;
)

{ SinOsc.ar(exprand(0.02, 0.2),0.1,0.1) }.plot;
