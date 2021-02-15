### Musical Reference:
- [Dennis Smalley](https://www.youtube.com/watch?v=CgXpT8gpfP4): electroacoustic
- [Laurie Spiegel](https://www.youtube.com/watch?v=z_XKPkcM1Vs): composition
- [Distinguishing Random, Algorithmic, and Intelligent Music ](http://lauriespiegel.net/ls/writings/alg_comp_ltr_to_cem.html): Laurie Spiegel's writing in algorithmic music
- [Ryoji Ikeda](https://www.youtube.com/watch?v=F5hhFMSAuf4&list=PLUSiSz_KpxrF-cKFkA9OTNEU-oMsDrHd6): noise and development

Plant & Music
- [Acoustic Botany](https://davidbenque.com/projects/acoustic-botany/)
- [Ryuichi Sakamoto: Forest Symphony](https://vimeo.com/332586819)

### Research

#### Scott, Bruce I. H., "Electricity in Plants", Scientific American, Oct. 1962, S. 107-115
[p107]
- "Electrical disturbances similar to the nerve impulse are associated with a number of plant life processes. It seems likely that these currents and fields somehow influence plant growth and development"

[p110]
- "The root of a bean shoot growing a weakly conductive medium, for example, is found to act as an electric generator sending tiny current into the medium and back through the root"…
- "The instrumentation must be highly sensitive, because only about a hunderdth of a microampere flows across a square millimeter of root surface" …
- "Without any stimulation the potential near the root starts to oscillate in a rhythmic fashion, the oscillations continuing for perhaps several hours […] The periods of oscillation for the roots we have studied are about five minutes. "
-  solutions of potassium chloride or sodium chloride

p[113]
- "the feedback loop that is the genius of the automatic-control revolution in contemporary technology is really an adaptation of a universal principle that makes living systems self-regulating."
- plant hormone: "indoleacetic acid may provide the feedback linkage that in turn controls the distribution of the hormone"

- "The demonstration in a lower organism of a feedback system with characteristic periods of oscillation is of interest in still another connection. This is the time sense, or 'biological clock' of such organism."
p[114]


### Experiments References
- [Biologic sensing/systems research](https://www.1010.co.uk/org/biologic.html)
- [Plant sensing](https://libarynth.org/plant_sensing)
- [behance](https://www.behance.net/gallery/44846645/Soni-Plantarum)

#### Bio Electrocity
Very subtle? But I would like to try measure bio-electricity from roots in water(solutions). But this is definitely something very fragile and not easy to take. Any way to do this in a more compact way?
micro-voltages (is action potential?) (and question of response to electromagnetic waves/fields eg. Lawrence, Experiments in Electroculture)

#### Bioelectrical Impedance [Current Method]
Project Examples
- [midiSprout](https://www.midisprout.com/):  Galvanic Conductance + ATmega328(8 bits) [details](https://www.instructables.com/Biodata-Sonification/)
- [SCÍON](https://www.instruomodular.com/product/scion/): a biofeedback sensor(biofeedback data, sourced from contact with organic surfaces) built into a quad random voltage generator. Based on the MidiSprout by Datagarden

- [Arduino Project by mwlyon](http://www.mwlyon.com/design_services_pages/arduino_projects.html): AD5933

- [resistance (wheatstone/transistor)](https://www.behance.net/gallery/44846645/Soni-Plantarum)

#### On Annika's master thesis
After contacting Annika to consult with her about the circuit, she pointed me to her detailed [project diary](), which I found super interesting and helpful to read.
Below are a list of posts that I found particularly interesting to check:
- [Quotes](https://annikaen.wordpress.com/2015/05/01/background-and-motivation-quotes/#more-15)
- [Atmosphere and sound 1](https://annikaen.wordpress.com/2015/05/11/atmosphere-and-sound-groups/#more-268), [2](https://annikaen.wordpress.com/2015/11/23/sound-hierarchies-and-interaction-scenarios/#more-513)
- [On Guto Nobrega's breathing and wheatstone bridge](https://annikaen.wordpress.com/2015/10/29/back-to-reality/)

#### Prof Dr.Fromm's lab
In Annika's post on her visit to [Prof Dr.Fromm's lab](https://annikaen.wordpress.com/2015/11/23/prof-dr-fromms-lab/#more-358), what I found interesting is this difference between variation potential and action potential that are caused by external stimuli. But since I'm less interested in the human interactions with plants such as touching, light is more important in this case as it's a major impact on the electronic state of a plant.

![Forest Symphony](https://github.com/digitalmediabremen/plantSonification/raw/main/Imgs/forestSymphony.png)
#### Forest Symphony
This project [Forest Symphony](https://forestsymphony.ycam.jp) is led by YCAM InterLab in Japan with Ryuichi Sakamoto being the music director for the composition.
The lab has designed an amplifier shield for this project and all the information is released under this [link](https://special.ycam.jp/interlab/en/projects/forestsymphony.html).
This project is also interesting because it open sourced the bioelectric potential data from various locations for a time period of one year. It's the only plant sonification project reference I found which made an attempt to measure plant data for a long time scale.

Some one else has also used their data to create sound works, one example can be found [here](https://vimeo.com/93060880).

For the installation, it also measures temperature, humidity and sunlight data, but this is not part of the open sourced data.

The installation includes multiple speakers(one corresponding to one location) as well as data visualization on four screens. From left to right, one screen is showing fast moving graph of one single tree(name, location, date, time, current voltage, temperature, humidity and sunlight, a 24 hour graph at the bottom), one screen is displaying voltage point visualization with lines in the color of white and red(not sure what the visuals indicate), one screen is displaying just the numbers itself, one screen is showing live bio signal graphs of various locations(6 on one screen). On the wall, more information on each tree and location is presented to provide the audience with more context.

Although the technical aspect is very well documented until the data collection point. There is not much information provided regarding to how the sound is generated.

#### Other Perspectives
- [botsot](http://www.ciaranframe.com/#/botsot/) | [github](https://github.com/ciaranframe/botsot)
  - DNA Sequencer: sections of plant's DNA sequence -> rhythmic values
  - Keyword Synthesizer
  - Contact Microphone Recording
  - Field Recording
  - Shape Sequencer
  - Sensor Drone
  - Image Envelope Generator
---
### Useful Links
- [are.na board](https://www.are.na/qianxun-chen/plant-sonification)
- [Anika's master thesis diary](https://annikaen.wordpress.com/)
- Dennis Smalley's lecture on [Spatiality in acousmatic music](https://www.youtube.com/watch?v=_G68Q4gkOMc)
- [All about plant sensing](https://libarynth.org/plant_sensing)
