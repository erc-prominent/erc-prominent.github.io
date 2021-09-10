---
layout: article-aligned
title: "MHD spectroscopy of a solar atmosphere"
categories: articles
excerpt: "Novel results from applying Legolas to a self-consistent solar atmosphere model."
modified: 2021-09-07
share: false
image:
  teaser: SA_slow_cont.png
---

**Applying Legolas to a self-consistent solar atmosphere model**
*Author: [Niels Claes]({{ site.url }}/team/nielsclaes)*

Armed with our recently developed [Legolas code](https://legolas.science) we set forth to do a complete eigenspectrum analysis of a fully realistic solar atmosphere model, in line with the PROMINENT project goals. For this we adopted a widely used semi-empirical temperature profile, and the resulting stratified atmosphere was complemented with external gravity, anisotropic thermal conduction and optically thin radiative losses. This work marks the first time a detailed MHD spectroscopic treatment like this has been done on such a self-consistent solar model, and we published the results in Solar Physics. The corresponding ArXiv entry can be found [here](https://arxiv.org/abs/2108.09467).

In general, a few major conclusions can be drawn from the results:
1. The eigenspectrum of the solar corona proved to be quite complex, with slow continua tracing out intricate patterns in the complex eigenvalue plane having both stable and unstable regions. In most cases the thermal continuum was shown to be mostly unstable, meaning that large parts of the corona are quite susceptible to thermal instability. We also encountered coronal regions with unstable thermal, slow, and fast modes.
2. The resulting eigenspectra can in a sense predict where condensations may likely be forming, yet to be confirmed in follow-up nonlinear simulations.
3. The solar chromosphere is even more susceptible to thermal instability than the solar corona, and on top of this shows interesting behaviour for the slow and thermal continua. We show that there exist chromospheric regions where the slow continua collapse to purely imaginary values, which may affect thermal stability depending on magnetic field strength and physical effects like thermal conduction.
4. In all these scenarios we show that these realistic solar models indicate a great variety of linear pathways to form condensations. How this occurs will depend on the intricacies of the eigenspectrum, and one may postulate that the dominating mode at any given point mostly governs the dynamical temporal evolution of the system; a statement that could be verified by follow-up nonlinear simulations.


<figure class="half">
  <img src="{{ site.url }}/images/SA_corona.png" style="padding-top: 1.6rem">
	<img src="{{ site.url }}/images/SA_chromo.png">
  <figurecaption>
    Spectra and eigenfunctions of a fully realistic stratified solar atmosphere.
    <b>Left</b>: solar corona between 2.5 and 25 Mm, showing unstable thermal, slow, and fast modes.
    <b>Right</b>: solar chromosphere up to 2.1 Mm, showing unstable thermal modes; along with slow continua merging
    on with the imaginary axis for sufficiently strong magnetic fields.
  </figurecaption>
</figure>
