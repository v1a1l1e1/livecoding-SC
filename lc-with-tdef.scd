(
SynthDef(\grain, {
	|out=0, freq=100, trigger=2, dur=0.5, amp=1.5|
	var sig = SinGrain.ar(Impulse.ar(trigger),dur,freq!2,EnvGen.kr(Env.perc(0.01, 0.1), doneAction:2));
	Out.ar(out, sig*amp);
},[nil,\ar,\tr,nil],variants: (a:[freq: 100, dur:0.1], b:[trigger:1], c:[freq:200,trigger:0.1])).add;
)

(
Tdef(\grainA,
	{loop {Synth('grain.a'); 1.wait;}}
))
(
Tdef(\grainC,
	{loop {Synth('grain.c'); 0.25.wait;}}
))

(
Tdef(\grainB,
	{loop {	Synth('grain.b',[\freq, rrand(800,2400).round(120)]); 0.5.wait;}}
))

Tdef(\grainA).play;Tdef(\grainC).play;Tdef(\grainB).play;