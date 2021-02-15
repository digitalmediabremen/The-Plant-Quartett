from supercollider import Server, Synth

server = Server()

synth = Synth(server, "sine", { "freq" : 440.0, "gain" : -12.0 })
synth.set("freq", 880.0)
