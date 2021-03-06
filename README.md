# SW_riemann_problem

<p align="center">

Fluid depth h(x,t)           |  Fluid velocity u(x,t)
:-------------------------:|:-------------------------:
![Dam break: depth](figs/hfig.png)  |  ![Dam break: velocity](figs/ufig.png)

</p>

## Exact solutions of the Riemann problem for the shallow water equations: rarefaction waves, shocks, and contact discontinuities


### Introduction
This repository contains some MATLAB code and documentation on the Riemann problem for the one-dimensional shallow water equations (SWEs) with flat bottom topography. The SWEs are a nonlinear system of conservative hyperbolic partial differential equations (PDEs).
Exact solutions of the Riemann problem for this system exist and comprise different combinations of shock waves and centred rarefaction waves. The classical problem considered is the so called dam-break problem, in which flow is initially at rest (zero velocity) with a step discontinuity in water depth h and evolves with a left rarefaction wave and right shock wave (see above figures; fig. 2 in Kent, 2013).
The system is then extended to a one-dimensional symmetric system in which spatial variation in the y-direction is ignored at leading order. The inclusion of meridional velocity, which acts like a tracer, is manifest in the solutions as a contact discontinuity which separates the fluid into two regions of different meridional velocity.

Solving the Riemann problem is an essential element of the implementation of the (Godunov)finite volume numerical scheme and other modern numerical upwind schemes (see, e.g., [this repository](https://github.com/tkent198/wellbalanced_SW_DGFEM)).

### Solving the SW Riemann problem: in a nutshell
A general strategy for solving the Riemann problem is as follows (after LeVeque, 2002, and detailed in Kent, 2013):
 * determine whether the left-wave and right-wave are shock or rarefaction waves;
 * determine the intermediate star state (h*, u*) between the two waves;
 * determine the location of shocks via shock speed and the head and tail of the rarefaction waves via the characteristic speeds;
 * determine the structure of the solution through any rarefaction wave.

First consider an isolated wave separating two constant states and how these two states are connected. For shock waves, this connection is simply a step discontinuity, the location of which must be determined. For rarefaction waves, this connection is more complicated: the location of start and end of wave must be determined along with the curve connecting them.

### Output
The source code deposited here has been used to generate the figures in the attached [report](SWRiem.pdf) (Kent, 2013). The solutions have been derived in detail in Kent (2013), supported by a number of sources -- see LeVeque (2002), particularly chapter 13, for a thorough introduction to and discussion of the problem.

<!-- ---
## Contents

* [Introduction](#introduction)
  * [Motivation](#motivation)
  * [Description](#A-brief-description-of-Wetropolis)
  * [Taster](#taster)
  * [References](#references)
* [Getting started](#getting-started)
* [Code overview](#files-overview)
  * [MATLAB](#matlab)
  * [Python](#python)
* [Preliminary simulations](#preliminary-simulations)
--- -->


### References
* Kent, T. (2013): *Exact solution of the Riemann problem for the shallow water equations*. Tech. report. [PDF.](SWRiem.pdf)
* LeVeque, R. J. (2002). *Finite volume methods for hyperbolic problems*. Cambridge university press.
----

## Code: getting started
### Add Language, versions, etc.
* MATLAB '9.4.0.813654 (R2018a)'

**NOTE:** code written for personal use in 2013, revisited in 2020 for publishing here. Caveat: it's not how I would code today but it still works!

### Files overview

File name                   |  Summary
:--------------------------:|:--------------------------:
```... .m```       |  ...
```... .m```    | ...


## Generating the figures in Kent (2013)
#### Figure 1
Similarity solutions for depth h and velocity u as a function of x/t for the dam-break Riemann problem with initial data: hl = 2; hr = 1; ul = ur = 0. Between the left and right initial states emerges a constant star state (h*, u*); in this case hl > h* > hr corresponding to a `left rarefaction wave - right shock' (LW-RS) Riemann solution.

<!-- ![Dam break similarity](figs/LWRSdambreak.png) -->
<p align="center">
  <img src="figs/LWRSdambreak.png" alt="Dam break similarity"/>
</p>

Run ```swrpplots.m```: default setting with this initial data.

```
% choose syms h
hl=2; hr=1; ul=0; ur=0;
```

This is an example of a mixed Riemann solution comprising a rarefaction wave and a shock wave. The structure inside the rarefaction wave (i.e., in this case the curve connecting hl and h*) is given by equation (39) in Kent (2013).

*Exercise: Change hl, hr, ul, ur for different solutions. Find initial data that result in a LS-RW solution.*

#### Figure 2

Figure 2 illustrates the evolution of the depth h and fluid velocity u for the dam-break problem at certain times t with initial data hl = 2, hr = 1, and ul = ur = 0. The fluid  flows from left to right (i.e. from the region of higher depth to the region of lower depth) in a body that expands from the dam location at x = 0. On the left hand side of this body, the fluid moves away from the deeper stationary fluid through a rarefaction wave. On the right, fluid with intermediate depth h* and velocity u* collides with the stationary fluid at a lower depth, instantaneously accelerating it through a shock wave.

<p align="center">
  <img src="figs/hfig.png" alt="Dam break h"/>
  <img src="figs/ufig.png" alt="Dam break u"/>
</p>

Run ```husubplots.m```: default setting with this initial data.

```
% choose time-snaps
tn = 0:0.5:1;
% choose syms h
hl = 2;
hr = 1;
ul = 0;
ur = 0;
```

*Exercise: Change hl, hr, ul, ur for different solutions; plot at different times t.*

#### Figure 3

Schematic of the four admissible solutions of the Riemann problem: (a) left and right shock (LS-RS), (b) left rarefaction wave and right shock (LW-RS), (c) left shock and right rarefaction wave (LS-RW), and (d) left and right rarefaction wave (LW-RW). As long as the left wave lies to the left of the right wave, the characteristics may lie anywhere on the (x,t)-plane with t > 0.

<p align="center">
  <img src="figs/schemfoursols.png" alt="Schematic"/>
</p>

Run ```fouradmissiblesols.m```: default setting with given (arbitrary) wave speeds.

#### Figure 4
The all-shock Riemann solution (LS-RS): evolution of depth h and velocity u at certain times t with initial data hl = 1, hr = 1, ul = 2, and ur = 0. This set-up corresponds to a moving fluid crashing into a static fluid of constant depth. A shock wave moves in both directions at different speeds (slower to the left, faster to the right), resulting in a wedge of fluid of increased depth expanding asymmetrically about x = 0 with constant intermediate velocity u*.

<p align="center">
  <img src="figs/hLSRS.png" alt="LSRS h"/>
  <img src="figs/uLSRS.png" alt="LSRS u"/>
</p>

Run ```husubplots.m``` with the specified initial data.

#### Figure 5

The all-rarefaction Riemann solution (LW-RW): evolution of depth h and velocity u at certain times t with initial data hl = 1, hr = 1, ul = 0, and ur = 2. The solutions consist of two rarefaction waves moving away from each other at different speeds. As the fluid in x > 0 moves to the right, a depression in the fluid depth forms about x = 0 and expands horizontally. This depression is fronted by two rarefaction waves and travels at constant intermediate velocity u* = 1. The structure of the expansion fans is given by Eqs. (39) and (40) in Kent (2013) for the given times t > 0.

<p align="center">
  <img src="figs/hLWRW.png" alt="LWRW h"/>
  <img src="figs/uLWRW.png" alt="LWRW u"/>
</p>

Run ```husubplots.m``` with the specified initial data.

#### Figure 6

Schematic solution in the (x,t)-plane of the dam-break problem for the 1D *symmetric* SWEs -- Eqs. (46)-(48) in Kent (2013). The complete Riemann solution consists of a left rarefaction wave, contact discontinuity, and right shock wave. Note that: h and u are continuous over the contact discontinuity, but v is discontinuous here and continuous over the rarefaction and shock waves.

<p align="center">
  <img src="figs/schemcontact.png" alt="Schematic: contact discontinuity dam break"/>
</p>

Run ```contactdisc.m```: default setting with given (arbitrary) wave speeds.

#### Figure 7

Similarity solutions for depth h and velocities u and v as a function of x/t for the dam-break Riemann problem with initial data: hl = 2; hr = 1; ul = ur = 0; vl = 1; vr = 2. The contact discontinuity in v is located at u*.

<p align="center">
  <img src="figs/LWRSdambreakcontact.png" alt="Similarity: contact discontinuity dam break"/>
</p>

Run the function ```symSWRPplot.m``` with the specified initial data:

```
symSWRPplot(2,1,0,0,1,2)
```
