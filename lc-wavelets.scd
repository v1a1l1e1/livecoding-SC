(
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

