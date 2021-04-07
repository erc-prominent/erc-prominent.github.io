---
layout: article-aligned
title: "Launching Legolas"
categories: articles
excerpt: "Read up on the launch of the new Legolas code, a novel tool for MHD spectroscopy."
modified: 2021-04-07
share: false
image:
  teaser: legolas_logo_400x250.png
---

Magnetohydrodynamic spectroscopy is central to many astrophysical disciplines, ranging from helio- to asteroseismology, 
over solar coronal (loop) seismology, to the study of waves and instabilities in jets, accretion disks, or solar/stellar atmospheres. 
MHD spectroscopy quantifies all linear wave modes, including growing or damped modes, for a given equilibrium state that achieves force and thermodynamic balance.

<img src="{{ site.url }}/images/legolas_logo_400x250.png" alt="Legolas logo" align="right">

Over the last two decades the main focus of astrophysical research has gradually shifted away towards solving the full MHD equations,
and development of linear MHD codes stalled. However, detailed spectrum calculations with associated eigenfunctions can yield incredible insight
in the stability of any given system, and may even be used to predict the nonlinear evolution of a specific equilibrium.

This prompted us to develop a brand new, modern linear MHD code which we called **Legolas**, short for Large Eigensystem Generator
for One-dimensional pLASmas. Legolas is written in object-oriented Fortran, and as such combines modern coding standards with the unparallelled speed
of Fortran programs, allowing for convenient linking with the most recent developments in linear algebra through BLAS, LAPACK and ARPACK.

The code is open source and is available on [GitHub](https://github.com/n-claes/legolas), with a dedicated website at [legolas.science](https://legolas.science).
Our method paper can be found [here](https://iopscience.iop.org/article/10.3847/1538-4365/abc5c4) and on [ArXiv](https://arxiv.org/abs/2010.14148).
Legolas is currently in active development, with plans to extend the framework even further with additional physical effects.

In the near future we are planning to apply Legolas to investigate thermal instability in unprecedented detail and look at the hitherto unknown role
of the anisotropy of thermal conduction, focusing on how they may affect prominence formation and evolution.



