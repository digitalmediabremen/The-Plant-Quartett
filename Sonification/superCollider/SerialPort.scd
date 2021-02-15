SerialPort.devices;
~port = SerialPort.new("/dev/cu.SLAB_USBtoUART", 9600);
~port.read;

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

~val;

~port.close;

//[$4, $6, $1].collect(_.digit).reverse.collect({arg n, i; n*(10.pow(i))});

