 /\l C:/Users/rhome/github/qScripts/maths/fouriertransform.q

 /rounding function
 /examples:
 /	34.46~.math.rnd[.01]34.456
.math.rnd:{x*"j"$y%x};

 /implementation of discrete fourier transform
 /inputs:
 /	series:list of float values (all real, no imaginary part)
 /	nbcoeffs: number of Fourier coefficients to compute. If 0, all coefficients will be computed
 /outputs:
 /	the function return a table with 2 columns: real and imaginary parts.
 /	row 0 corresponds to coefficient X[0], row 1 to X[1]... etc.
 /examples:
 /	Compute full fourier transform:
 /		((`Xr`Xi)!(2 1 0 1f;0 -3 0 3f))~.math.dft[1 2 0 -1f;0]
 /	Compute partial fourier transform (first 2 coefficients only):
 /		((`Xr`Xi)!(2 1f;0 -3f))~.math.dft[1 2 0 -1f;2]
.math.dft:{[x;nbcoeffs]
 N:count x;if[nbcoeffs=0;nbcoeffs:N];`pi set acos -1;
 Xr:{[x;N;n].math.rnd[1e-6;] sum x*cos (2*pi%N)*(til N)*n}[x;N;]each til nbcoeffs;
 Xi:{[x;N;n].math.rnd[1e-6;] sum x*sin neg (2*pi%N)*(til N)*n}[x;N;]each til nbcoeffs;
 if[nbcoeffs<N;nullcoeffs:(N-nbcoeffs)#0f;Xr,:nullcoeffs;Xi,:nullcoeffs];
 (`Xr`Xi)!(Xr;Xi)};
 
 /inverse discrete fourier transform
 /example:
 /	Compute inverse fourier transform
 /		.math.idft .math.dft[1 2 0 -1f;0]
 /	Verify that composition of dft and its inverse idft gives the original input
 /		{x~.math.idft .math.dft[x;0]}[1 2 0 -1 3 5f]
.math.idft:{[X]
 Xr:X[`Xr];Xi:X[`Xi];N:count Xr;`pi set acos -1;
 r:{[Xr;Xi;N;n]freq:(2*pi%N)*n*til N;(1%N)*sum (Xr*cos[freq])-Xi*sin[freq]}[Xr;Xi;N;]each til N;
 .math.rnd[1e-6;]r};
