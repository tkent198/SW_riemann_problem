# SW_riemann_problem

![Dam Break x/t](figs/LSRWdambreak.png)

## Exact solutions of the Riemann problem for the shallow water equations: rarefaction waves, shocks, and contact discontinuities

This repository contains the some code and documentation on the Riemann problem for the one-dimensional shallow water equations (SWEs) with flat bottom topography. The SWEs are a nonlinear hyperbolic system of hyperbolic and conservative partial differential equations. Exact solutions of the Riemann problem for this system exist and comprise a combination of shock waves and centred rarefaction waves. The classical problem considered is the so called dam-break problem; this is solved here in detail. The system is then extended to a one-dimensional symmetric system in which spatial variation in the y-direction is ignored at leading order. The inclusion of meridional velocity, which acts like a tracer, is manifest in the solutions as a contact discontinuity which separates the fluid into two regions of different meridional velocity. Solving the Riemann problem is an essential element of the implementation of the (Godunov)finite volume numerical scheme and other modern numerical upwind schemes (see, e.g., [this repository](https://github.com/tkent198/wellbalanced_SW_DGFEM)).

---
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
---

## Introduction
### Motivation
Urban flooding is a major hazard worldwide, brought about by intense rainfall and often exacerbated by the built environment. The tabletop flood-demonstrator Wetropolis illustrates in an idealised modelling environment how extreme hydro-climatic events can cause flooding of a city due to peaks in river levels and groundwater following intense rainfall. It aims to conceptualise the science of flooding in a way that is accessible to and directly engages the public and also provides a scientific testbed for flood modelling, control and mitigation, and data assimilation. As such, it is useful to the scientist, industrial practitioner, and general public.

### A brief description of Wetropolis
Physically, it comprises a winding river channel with parallel canal, a reservoir for water storage, a porous flow cell (analogous to a moor) with observable groundwater flow, and random rainfall, which may or may not lead to flooding in the idealised urban area of Wetropolis. The main river channel has three π-degree bends and one (π/4)-degree bend and is fed by water flowing into the domain at an upstream entry and leaving the domain at the downstream exit. The river bed is sloping down (uniformly with gradient 1 in 100); the river cross-sectional area is rectangular and uniform, and flanked on one side by a sloping flood plain outside of the urban area. Through the urban area, the rectangular channel is flanked on both sides by flat rectangular plains of higher elevation than the regular river channel, i.e., the cross-sectional area is T-shaped. Water enters the main channel in three places: (i) the upstream inflow, generally kept constant; (ii) overflow of a groundwater cell (or "moor") with porous material and fed by random daily rainfall; and (iii) overflow from a reservoir, also fed by random daily rainfall. The two overflows can be placed in three different spots along the river: upstream, midstream or downstream just before the city plain. The set-up is displayed in plan-view (below left) and in action at Confluence 2018, Leeds (below right).

Plan view            |  In action
:-------------------------:|:-------------------------:
![planview](figs/wetro_schematic.png)  |  ![Churchtown](figs/wetro_inaction.png)

Rainfall is supplied randomly in space at four locations (reservoir, moor, reservoir and moor, or nowhere) and randomly in time at four rainfall amounts (1s, 2s, 4s, or 9s) during a 10s Wetropolis day (wd) via two skew-symmetric discrete probability distributions. The joint probabilities (rain amount times rain location) are determined daily as one of 16 possible outcomes from two asymmetric Galton boards, in which steel balls fall down every wd and according to the (imposed) discrete probability distributions. The most extreme daily rainfall event thus involves 9s rainfall on both moor and reservoir. The two asymmetric Galton boards are shown in action below.

![galtons](figs/galtonboardsHESS.png)

Wetropolis' design is based on simulations of a one-dimensional numerical model of the dynamics that uses a kinematic approximation to describe the river flow and a depth-averaged nonlinear diffusion equation for the groundwater cell; in the numerical model, a stochastic rainfall generator mimics the Galton boards to determine the amount and location of rain per wd.  In order to create an extreme flood event in Wetropolis once every 5 to 10 minutes on average instead of, say, once every 100 to 200 years on average (as in reality), this preliminary modelling determined the length of the Wetropolis day to be 10s with a corresponding return period of (256/7) x 10s = 6:06min. Thus, Wetropolis is able to demonstrate random extreme rainfall and flood events in a physical model on reduced spatial and temporal scales (see Bokhove et al. (2020) for more details).

A working document with more background and theory, including the governing equations and numerics of Wetropolis, is found [here](Wetropolis_Au_model.pdf).


### Taster
*Preliminary test:* set up the channel geometry (see [pdf](Wetropolis_Au_model.pdf)), initialised with a constant depth and kinematic velocity. The time-dependent left boundary sends a Gaussian pulse into the domain which travels down the channel and floods the plains and city area. This 'floodwave' passes out of the domain and river levels recede.

![floodwave](MATLAB/mov/vid_Nk_105_tmax_100.gif)

Top-left: water depth h [metres] as a function of the along-channel coordinate s [m]. The red shaded area denotes the city area. Top-right: Discharge Au [m^3 / s] along the channel s [m]. Bottom-left: cross-sectional slice at s = 1.96m (floodplain; see vertical dashed line in top-left panel). Bottom-right: cross-sectional slice at s = 3.56m (city area; see second vertical dashed line in top-left panel). Time [s] is indicated in the bottom panels; recall one 'Wetropolis day' (wd) is 10s. Channel length L = 4.21m. Simulation details: space-FV/DGFEM discretisation (Nk=105 elements) -- more details [here](Wetropolis_Au_model.pdf) -- and explicit forward Euler in time; run script ```AuNCP_wetro0.m```.



### References
* Bokhove, O., Hicks, T., Zweers, W., and Kent, T. (2020): Wetropolis extreme rainfall and flood demonstrator: from mathematical design to outreach, *Hydrol. Earth Syst. Sci.*, 24, 2483–2503, [DOI](https://doi.org/10.5194/hess-24-2483-2020).

* See also presentations on [OB's page](https://github.com/obokhove/wetropolis20162020/):
  * [Oxford seminar 2016](https://github.com/obokhove/wetropolis20162020/blob/master/WetropolisO2016.pdf)
  * [EGU 2018 talk](https://github.com/obokhove/wetropolis20162020/blob/master/wetropolisegu2018.pdf)
  * [EGU 2019 poster](https://github.com/obokhove/wetropolis20162020/blob/master/WetropolisposterEGU2019p.pdf)

----

## Getting started
### Add Language, versions, etc.
* MATLAB '9.4.0.813654 (R2018a)'

### Files overview

File name                   |  Summary
:--------------------------:|:--------------------------:
```AuNCP_wetro0.m```       |  Main run script for initial test case
```initial_cond_wetro.m```    | Func: Set up initial data (detailed within)
```NCPflux_Au.m```            | Func: numerical flux calculation for space discretisation
```xsec_Ahs.m```              | Func: cross-sections A as a function of h and s
```xsec_hAs.m```              | Func: cross-sections h as a function of A and s
```plots_xsecs.m```           | Plots cross-section functions
```plot_xsec_hAs.m```         | Func: for plotting model output
```run_wetro_2016.m```	| New ver of OB's original ```tabletop2v2016.m```
```run_wetro_2020.m```	| Run Wetropolis with updated St. Venant river system: first implementation working
```run_wetro_2020v2.m``` | Run Wetropolis with updated St. Venant river system: improvements
```run_wetro_2020v3.m``` | Run Wetropolis with updated St. Venant river system: save rain data with load option
```live_plotting_routine.m``` | Separate plotting routine, called by ```run_wetro_2020v2.m```
