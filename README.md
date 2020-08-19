# SW_riemann_problem
Fluid depth            |  Fluid velocity
:-------------------------:|:-------------------------:
![Dam break: depth](figs/hfig.png)  |  ![Dam break: velocity](figs/ufig.png)


## Exact solutions of the Riemann problem for the shallow water equations: rarefaction waves, shocks, and contact discontinuities

This repository contains some MATLAB code and documentation on the Riemann problem for the one-dimensional shallow water equations (SWEs) with flat bottom topography. The SWEs are a nonlinear system of conservative hyperbolic partial differential equations (PDEs). Exact solutions of the Riemann problem for this system exist and comprise different combinations of shock waves and centred rarefaction waves. The classical problem considered is the so called dam-break problem, in which flow is initially at rest (zero velocity) with a step discontinuity in water depth h; this is presented here in detail. The system is then extended to a one-dimensional symmetric system in which spatial variation in the y-direction is ignored at leading order. The inclusion of meridional velocity, which acts like a tracer, is manifest in the solutions as a contact discontinuity which separates the fluid into two regions of different meridional velocity. Solving the Riemann problem is an essential element of the implementation of the (Godunov)finite volume numerical scheme and other modern numerical upwind schemes (see, e.g., [this repository](https://github.com/tkent198/wellbalanced_SW_DGFEM)).

The source code has been used to generate the figures in the attached [report](SWRiem.pdf).

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
* Add Leveque.


----

## Getting started
### Add Language, versions, etc.
* MATLAB '9.4.0.813654 (R2018a)'

### Files overview

File name                   |  Summary
:--------------------------:|:--------------------------:
```... .m```       |  ...
```... .m```    | ...
