### Sine Wave
- hard to tell where the sound comes from

### AM (Amplitude Modulation)
- AM is like ring modulation but with a subtle difference: the modulator is unipolar, that is, always positive. Think of tremolo, where the amplitude goes up and down (but is never negative!).  

### Granular Synthesis[After Tuesday]
- In Granular Synthesis sounds are modeled out of microscopic particles of sound, short grains in the region of 10-100
 milliseconds long.
- great for ambience sounds
- adding clouds?
- [General Info](https://www.soundonsound.com/techniques/granular-synthesis)
- [Book:Microsound](https://mitpress.mit.edu/books/microsound)
- TODO: [Super Collider: Granular Synthesis TutorialL:Part 1](https://www.youtube.com/watch?v=WBqAM_94TW4)
- TODO: [Super Collider: Granular Synthesis TutorialL:Part 2](https://www.youtube.com/watch?v=MnD8stNB5tE)
- check out this one:[granular AM synthesis](https://sccode.org/1-56u)

### Noises in Super collider
- whiteNoise
- [BrownNoise](https://doc.sccode.org/Classes/BrownNoise.html); as a frequency modulator; filtered

### Others
- [Reference](https://composerprogrammer.com/teaching/supercollider/sctutorial/2.4%20Modulation%20Synthesis.html)
---
### Frequency Modulation
https://www.youtube.com/watch?v=vvBl3YUBUyY
- FM comes into play when you use one wave to modulate another wave
- Modulator(operator) - Carrier
- 'Ratio' refer to the frequencies between the waves that are involved.
- Good Ratio: 1:2, 2:1,

FM is a family of methods that share the common property of wavetable lookup according to a nonlinear oscillating function.

#### Background
- Applications of FM in communications systems date back to 19th century while the theory behind FM of radio band frequencies was established in the early 20th century.
- John Chowning: the first to explore systematically the musical potential of digital FM synthesis. Prior to this, most digital sound had been produced by fixed-waveform, fixed-spectrum techniques, because time-varying synthesis were rare and costly.
-> generate synthetic sounds that had the animated spectra characteristic of natural sounds. (extreme vibrato techniques)

#### C:M ratio
- C-5M, C-4M, C-3M, C-2M, C-M, C, C+M, C+2M, C+3M, C+4M, C+5M
- when C:M is a simple integer ratio, such as 4:1, FM generates harmonic spectra
- when C:M is not a simple integer ratio, such as 8:2.1, FM generates inharmonic spectra

#### Modulation Index and Bandwidth
- The bandwidth of the FM spectrum (the number of sidebands) is controlled by the modulation index or index of modulation I. I is defined mathematically by:
I = D/M
