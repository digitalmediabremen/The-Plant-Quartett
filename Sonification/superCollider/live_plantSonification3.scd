s.options.memSize = 12000;
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
		});
		if(ascii == $b, {
			// convert ~charArray to usable integer
			~val2 = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ]; // empty ~charArray
		});
		if(ascii == $c, {
			// convert ~charArray to usable integer
			~val3 = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ]; // empty ~charArray
		});
		if(ascii == $d, {
			// convert ~charArray to usable integer
			~val4 = ~charArray.collect(_.digit).convertDigits;
			~charArray = [ ]; // empty ~charArray
		});
	}.loop;
}).play;
)

s.plotTree;
(
SynthDef.new(\sine,
{|amp=1, sus=1, pan=0, freq=0, vib=0, fmod=0, rate=0, bus=0, blur=1, beat_dur=1, atk=0.01, decay=0.01, rel=0.01, peak=1, level=0.8, delay = 0.1, max = 0.1, mul = 0.1|

var osc, env, carrier, modulator, carrfreq, modfreq;
sus = sus * blur;

// Amplitude Modulation
carrfreq= freq;
modfreq= max;// the reading number will be maped to modfreq

carrier= SinOsc.ar(carrfreq,0,0.5); // bipolar
modulator= SinOsc.ar(modfreq,0,mul); // unipolar

osc=(carrier*modulator);

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
~synth2 = Synth.new(\sine, [\freq,~val2, \amp,1, \delay, 3]);
~synth3 = Synth.new(\sine, [\freq,~val3, \amp,1, \delay, 6]);
~synth4 = Synth.new(\sine, [\freq,~val4, \amp,1, \delay, 9]);

~val
~val2
~val3
~val4


(
~control = Routine.new({
	{
		~maxControl = 8000;
		~mulControl = 10000;

		~synth.set(\max, ~val/~maxControl);
		~synth2.set(\max, ~val2/~maxControl);
		~synth3.set(\max, ~val3/~maxControl);
		//~synth4.set(\max, ~val4/1024);

		~synth.set(\mul, ~val/~mulControl);
		~synth2.set(\mul, ~val2/~mulControl);
		~synth3.set(\mul, ~val3/~mulControl);
		//~synth4.set(\mul, ~val4/10000);
		0.03.wait;
	}.loop;
}).play;
)
(
~control = Routine.new({
	{
		~synth.set(\freq, ~val);
		~synth2.set(\freq, ~val2);
		~synth3.set(\freq, ~val3);
		//~synth4.set(\freq, ~val4);
		60.wait;
	}.loop;
}).play;
)

{ SinOsc.ar(exprand(0.02, 0.2),0.1,0.1) }.plot;