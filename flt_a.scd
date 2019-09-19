"Setup/Setup.scd".loadRelative;
~scale = Scale.chromatic(\et24);
p.clock.tempo=(130/60);

~base = {SinOsc.ar([60,61],0,0.5)};
~base_m = {LFPulse.ar([20,21],mul:0.5)};
~mod = {Saw.ar(LFNoise0.ar(0.1).range(1,10).round(1))};

~b = {~base.ar * ~base_m.ar};
~b_m = {~b.ar * ~mod.ar};
~b.play;
~b_m.play;~b.stop(3);

~base_flt = {RLPF.ar([~b.ar, ~k.ar, ~hh.ar, ~fm.ar], LFNoise1.ar(0.1!2).range(10,160), LFNoise2.ar(1!2).range(0.0001,0.1))};
~base_flt.play;

~k = Pbind(\instrument, \gplay1, \buf, d["k"][1], \amp,10, \dur, Pbjorklund2(Prand([3,5],inf),8)/2);
~k2 = Pbind(\instrument, \gplay2, \buf, d["k"][0], \amp,10, \dur, Pbjorklund2(Prand([3,5],inf),8,inf)/4);
~hh = Pbind(\instrument, \gplay2, \buf, d["ch"][0], \amp, 0.05, \dur, Pbjorklund(Prand([3,5],inf),8,inf)/4);
~k.play; ~k2.play; ~hh.play;

~fm = Pbind(\instrument, \fm, \freq, Prand([60, 90,120,40],inf),\amp,0.1, \dur, Pwrand([0.125,0.25],[0.6,0.4],inf));
~fm.play;

~sk = Pbind(\instrument, \gplay2, \buf, d["sk"][0],\amp, 4, \dur, Pwrand([4,2],[0.6,0.4],inf));
~sk.play;

~hh.stop(10); ~k2.stop(12);