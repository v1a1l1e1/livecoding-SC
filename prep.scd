"Setup/Setup.scd".loadRelative;
p.clock.tempo = (130/60);


~sk = Pbind(\instrument, \gplay2, \buf, d["sk"][0], \dur, 4, \amp, 2);
~k = Pbind(\instrument, \gplay2, \buf, d["k"][0], \dur, Pwrand([1,0.5,0.125],[0.6,0.3,0.1],inf));
~k2 = Pbind(\instrument, \gplay2, \buf, d["k"][2], \dur, Pwrand([Pseq([0.5],16), Pbjorklund2(Prand([3,5],1),8,4)/2],[0.7,0.3],inf));
~k.play;~sk.play;~k2.play;

~one_shot = Pbind(\instrument, \gplay1, \buf, d["k"][1], \dur, Pseq([0.25],8), \amp, 5);
~one_shot.play;

~o = Pbind(\instrument,\gplay2,\buf,d["oh"][0],\dur,Pseq([0.25,Pbjorklund2(Prand([3,5],inf),8)],inf),\amp,0.3, \rate, Pwhite(0.1, 3));
~o.play;
~oh = Pbind(\instrument,\gplay2,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,0.3);
~oh.play;
~oh2 = Pbind(\instrument,\gplay2,\buf,d["oh"][2],\dur,Pseq([0.5,Pseq([1,0.5,2],inf)],inf),\amp,0.3, \rate, 0.5);
~oh2.stop(5);

~sn = Pbind(\instrument, \gplay2, \buf, d["s"][0],\dur, Pwrand([Pseq([0.5, 1.5],inf),2],[0.8, 0.2],inf), \amp, 0.3);
~sn2 = Pbind(\instrument, \gplay2, \buf, d["s"][1],\dur, Pwrand([Pseq([0.25, 1.5],inf),2],[0.8, 0.2],inf), \amp, 0.3);
~sn.play;
~sn2.stop(4);

~flt = {RHPF.ar([~o.ar],200, LFNoise1.kr(1).range(0.001,0.1),0.5)};
~flt.stop;

~wo = Pbind(\instrument, \wo, \freq, Prand([100,600,400,200],inf), \dur, Prand([0.25,0.5],inf), \amp, 1.5);
~wo.stop;

~g1 = Pbind(\instrument, \gplay1, \buf, d["g"][0], \dur, 0.5, \amp, 0.2);
~g2 = Pbind(\instrument, \gplay2, \buf, d["g"][1], \dur, Pseq([0.25, 0.5],inf), \amp, 0.2);
~g1.stop(5); ~g2.stop(5);

~g_flt = {RLPF.ar([~g1.ar, ~g2.ar], SinOsc.kr(0.5).exprange(80,500), SinOsc.kr(1).range(0.01,0.1))};
~g_flt.stop(2);

/*out*/
~g1 = Pbind(\instrument, \gplay1, \buf, d["g"][0], \dur, 0.25, \amp, 0.5);
~g2 = Pbind(\instrument, \gplay2, \buf, d["g"][1], \dur, Pseq([0.125, 0.5],inf), \amp, 1);
~g1.play; ~g2.play;

~bass = Pbind(\instrument, \bass, \scale, Scale.major, \octave, Pwrand([2,3],[0.9,0.1],inf), \degree, Pseq([0,2,4,5],inf), \dur, Prand([0.25,0.5],inf),\amp, 1);

~drone = Pbind(\instrument, \82, \scale, Scale.major, \octave, Prand([2,3],inf), \degree, Prand([[2,4,7], [1,3,5],2,6,4,7,9,11],inf), \root, 0, \dur, 0.5, \amp, 2);
~drone.play;