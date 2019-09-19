("Setup/Setup.scd").loadRelative;

p.clock.tempo = (130/60);

~base = {Saw.ar([80,81],0.5) * LFPulse.ar([60,62],mul:0.5) * SinOsc.ar([110,109],mul:0.5)};
~base.stop(5);

~k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pseq([0.5, 1,0.25],inf), \amp, 3);
~k.play;

~sk = Pbind(\instrument, \gplay2, \buf, d["sk"][0], \dur,Pwrand([4,2],[0.8,0.2],inf), \amp, 5);
~sk.play;

~k2 = Pbind(\instrument, \gplay1, \buf, d["k"][1], \dur, Prand([1,Pseq([0.5,1,1,0.25],16)],inf), \amp, 3);
~k2.stop(3);

~hh = Pbind(\instrument, \hh, \out,0, \rel, 0.1, \amp, 1, \f_c, Prand([5600,4800,6400],inf), \dur, Pbjorklund2(Pseq([3,5],inf),8)/2);
~hh.stop;

~pad = Pbind(\instrument, \pad, \freq, Prand([240,480,480,640, 160,80],inf), \amp, 1);
~pad.stop();

~delay = {CombC.ar([~base.ar, ~pad.ar],0.3,SinOsc.kr(0.2).range(0.2,0.5),6,0.5)};
~delay.stop;

~delay2 = {CombC.ar([~delay.ar,~base.ar],0.3,0.4,7,0.75)};
~delay2.stop;

~flt = {RLPF.ar([~pad.ar, ~base.ar], LFNoise1.kr(2).range(40,250), LFNoise2.kr(0.5).range(0.00001,0.9),4)};
~flt.stop(1);

~synth = Pbind(\instrument, \synth, \out, 0, \freq, Pwhite(160,480).round(40), \harms, 20, \edur, 0.5, \amp, 1, \dur, Prand([4,2],inf));
~synth.stop(3);

~bass = Pbind(\instrument, \bass, \dur, 0.5, \out, 0, \freq, 80, \amp, 2);
~bass.stop;

~bass_flt = {RLPF.ar([~bass.ar],LFNoise1.ar(0.5).range(40,240), 0.001)};
~bass_flt.stop(10);

~dist = {Decimator.ar([~synth.ar],22000,8)};
~dist.stop;

~disint = {Disintegrator.ar([~dist.ar],0.5,-1)};
~disint.stop;

~noiz = Pbind(\instrument, \wo, \out,0, \freq, 160, \timescale, 1, \dur, 1);
~noiz.play;

~k.stop(5);
~sk.stop(2);
~noiz.stop
