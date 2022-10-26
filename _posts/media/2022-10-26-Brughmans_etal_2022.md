---
layout: media-aligned
title: "Prominence heating models"
categories: media
excerpt: "Testing a multitude of scaled heating laws for the solar corona on the prevalence of prominence condensations within flux rope topologies"
share: true
image:
  # feature: Jenkins&Keppens_2022_isofields.png
  teaser: reduced_gy_rho0690.png
---


[//]: # <!-- <h3 style="display: inline-block;"></h3> -->

**Flux rope heating**
*Author: [Nicolas Brughmans]*

In [this](https://www.aanda.org/articles/aa/pdf/forth/aa44071-22.pdf) upcoming paper in Astronomy & Astrophysics, we investigate the influence of different coronal heating models on 2.5D solar prominence formation. In simulations of prominence formation, two classes of background heating models are commonly adopted. Often, a heating background is used that remains constant in time and exactly balances the initial radiative losses, which gives it an exponential variation with height. However, such a heating term applies an artificial residual heating throughout the flux rope and prominence structure. On the other hand, heating based on observed or theoretical scaling laws is also often considered, where the local heating rate depends on variable quantities like the magnetic field strength and density. However, as shown by Kaneko & Yokoyama (2015), prominence formation is inhibited when a flux rope is formed from a magnetic arcade through motions that increase the initial shear between its footprints, as opposed to decreasing it. In reality, these anti-shearing motions are vastly outnumbered by observations of shearing motions.

To overcome these inconsistencies, we proposed a new 2.5D heating model that takes into account the 3D structure such a flux rope would have and incorporates field line length as a local parameter in the heating rate, providing a qualitative reasoning for why the heating rate should be reduced inside a flux rope compared to its surroundings. In essence, thermal conduction is less effective in transporting energy deposits from the base of the corona to the centre of the flux rope along its structure of long, twisted field lines. We devised a method based on the 2.5D magnetic field curvature to track the flux rope during runtime and apply the reduced heating mask to the flux rope, effectively mimicking its 3D structure. The use of this 'reduced heating model' is then shown to lead to the formation of larger prominences. Furthermore, the inconsistencies described above are overcome, where the artificial residual heating of the exponential profile inside the flux rope is decreased, and prominence formation with a heating background depending on magnetic field strength inside a flux rope formed through shearing motions is now possible, raising the question of whether this will then also be the case in 3D simulations.

In the accompanying animation, we show the density - temperature - background heating evolution for a simulation where a steady exponential heating background is modified to apply the reduction in heating inside the flux rope. After the flux rope forms through multiple reconnection events between 1300s and 2800s, most of the flux rope becomes thermally unstable, with condensations forming throughout. These blobs of plasma then fall down along the field lines under the effect of gravity, leaving behind a cavity of tenuous material and eventually collecting in one large, monolithic prominence body. In an accompanying EPS conference proceedings [paper](https://indico.fusenet.eu/event/28/contributions/345/attachments/359/1056/EPS_2022_contributed_paper.pdf), we analyse the oscillation periods of the prominence body, which distinctly vary between field lines. Towards the end of the simulation, significant mass slippage occurs at the top of the prominence, where the frozen-in condition is violated and material is able to travel transversely over the field lines due to the high value of resistivity taken in our simulations. A benchmark simulation performed with disabling resistivity after the flux rope has been formed, showed that this phenomenon all but disappears with zero resistivity.


<iframe width="560" height="315" src="https://www.youtube.com/embed/quZaso1jCC4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>