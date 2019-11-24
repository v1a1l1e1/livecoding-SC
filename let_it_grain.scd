(
SynthDef(\grain, {
	|out=0, freq=100, trigger=2, dur=0.5, amp=1.5|
	var sig = SinGrain.ar(Impulse.ar(trigger),dur,freq!2,EnvGen.kr(Env.perc(0.01, 0.1), doneAction:2));
	Out.ar(out, sig*amp);
},[nil,\ar,\tr,nil],variants: (a:[freq: 100, dur:0.1], b:[trigger:1], c:[freq:200,trigger:0.1])).add;

SynthDef(\wavelet, {
	|n=1024,f_min=50,f_max=10000,out=0|
	var sig, env;
	sig = WaveletDaub.ar(Saw.ar(Rand(f_min, f_max),0.5),n,Rand(0,n));
	env = EnvGen.kr(Env.linen, doneAction:2);
	Out.ar(out, Pan2.ar(sig*env, Rand(-1,1)));
}).add;
)

p = ProxySpace.push(s);
p.makeTempoClock(130/60);

~bass2 = Pbind(\instrument, \wavelet, \f_min, 50, \f_max, Prand((200..5000).round(40),inf), \dur, Prand([0.5,0.25],inf));
~bass2.play;

~bass = Pbind(\instrument, \wavelet, \n,1024, \f_min, 50, \f_max, Prand((60..400).round(80),inf), \dur, Prand([0.5,1],inf));
~bass.play;

(
Tdef(\grainA,
	{loop {Synth('grain.a',[\amp,2]); 0.5.wait;}}
))
(
Tdef(\grainC,
	{loop {Synth('grain.c'); 0.25.wait;}}
))

(
Tdef(\grainB,
	{loop {	Synth('grain.b',[\freq, rrand(800,2400).round(120), \amp, 2.5]); 0.5.wait;}}
))

Tdef(\grainA).play;Tdef(\grainC).play;Tdef(\grainB).stop;