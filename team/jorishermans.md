---
layout: article
title: "Joris Hermans"
share: false
---

During my PhD as part of the ERC PROMINENT project, I have been working on:

-A case study of the effect of optically thin radiative cooling curves on condensation formation by thermal instability

The first animation shows the nonlinear evolution of thermal instability for solar coronal conditions. A small density fix is used to ensure a feasible time step due to the restriction by the CFL condition. It shows the fragmentation and redistribution of the filamentary condensation. The second animation shows the evolution of a hydrodynamic version of the simulation. Two sound waves are being damped. Thermal instability creates a condensation that shatters.
For details see Hermans J. & Keppens R., 2021, Submitted to A&A. More will be explained once accepted.

<iframe width="893" height="734" src="https://www.youtube.com/embed/kI6smKngjmM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


<iframe width="893" height="734" src="https://www.youtube.com/embed/obarJg1HV2A" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



-In the proceedings paper accompanying the poster presentation at the EPS 2021 conference, we investigate the influence of the numerical implementation of a cooling curve, i.e. piece-wise power law vs interpolated table, on the condensation formation process. For this end we created to piece-wise power law fits to the SPEX_DM curve (Schure et. al 2009). The fits are shown in the next figure. We have one rough fit with seven segments and one fine fit with 14 segments.

<img src="{{ site.url }}/images/SPEX_DM_cc_fits.png" width="420" alt="SPEX_DM_fits">


The analytic formulae for the rough and fine fits to the SPEX_DM curve, respectively, are given below.

![]({{ site.url }}/images/SPEX_DM_roughfit.png)

![]({{ site.url }}/images/SPEX_DM_finefit.png)




-Setting up simulations of thermal instability in rotating magnetic structures, which relate to solar tornadoes
