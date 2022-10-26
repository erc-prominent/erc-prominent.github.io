---
layout: article-aligned
excerpt: "Jack Jenkins"
share: false

---

Hello there! 

<img src="{{ site.url }}/images/jack_bio_photo_erc.jpg" width="200" alt="My ugly mug" style="float: right; padding-left: 2.5rem; width: 20rem">
On this page I will detail some of the things that I have been doing as a part of the ERC PROMINENT project. 



A brief breakdown of my responsibilities thusfar:
1. Development of idealised 2.5 and 3D flux rope formation and prominence/filament condensation models within [MPI-AMRVAC](http://amrvac.org).
2. Addition of synthetic views (e.g., SDO/AIA) to the yt-project frontend
3. Integration of data-driven intitial conditions, following the implementation of [Fischer et al. (2020)](https://ui.adsabs.harvard.edu/abs/2020ApJS..248....2F/abstract), into MPI-AMRVAC.

<ins>Progress so far:</ins> 

# 1. - Idealised 2.5 & 3D models of solar prominences/filaments

### 1.1 - 2.5D
<img src="{{ site.url }}/images/Jenkins&Keppens_2020_synthesis.png" width="200" alt="My ugly mug" style="float: right; padding-left: 2.5rem; width: 40rem">
We have fully realised a 2.5D simulation of the formation and condensation of a solar prominence following the pioneering work of Kaneko & Yokoyama (2015). Herein, a linear force-free magnetic field is deformed (in line with general evolution of the solar photosphere i.e., footpoint driven prescribed in the bottom boundary) so as to initiate magnetic reconnection and the formation of a 2.5D flux rope with isolated material suspended within the solar corona. This material then condensed following radiative losses and so-called 'runaway radiative cooling' that leads to the in-situ formation of condensations via the thermal instability. The abstract for this work is as follows:

**Context**: Prominences in the solar atmosphere represent an intriguing and delicate balance of forces and thermodynamics in an evolving magnetic topology. How this relatively cool material comes to reside at coronal heights, and what drives its evolution prior to, during, and after its appearance, remains an area full of open questions.  
**Aims**: We here set forth to identify the physical processes driving the formation and evolution of prominence condensations within 2.5D magnetic flux ropes. We deliberately focus on the levitation-condensation scenario, where a coronal flux rope forms and eventually demonstrates in situ condensations, revisiting it at extreme resolutions down to order 6 km in scale.  
**Methods**: We perform grid-adaptive numerical simulations in a 2.5D translationally invariant setup, where we can study the distribution of all metrics involved in advanced magnetohydrodynamic stability theory for nested flux rope equilibria. We quantify in particular convective continuum instability (CCI), thermal instability (TI), baroclinicity, and mass-slipping metrics within a series of numerical simulations of prominences formed via levitation-condensation.  
**Results**: Overall, we find that the formation and evolution of prominence condensations happens in a clearly defined sequence regardless of resolution, with background field strength between 3 and 10 Gauss. The CCI governs the slow evolution of plasma prior to the formation of distinct condensations found to be driven by the TI. Evolution of the condensations towards the topological dips of the magnetic flux rope is a consequence of these condensations initially forming out of pressure balance with their surroundings. From the baroclinicity distributions, smaller-scale rotational motions are inferred within forming and evolving condensations. Upon the complete condensation of a prominence 'monolith', the slow descent of this plasma towards lower heights appears consistent with the mass-slippage mechanism driven by episodes of both local current diffusion and magnetic reconnection.

The associated paper can be found online at: [https://www.aanda.org/](https://www.aanda.org/articles/aa/pdf/2021/02/aa39630-20.pdf) and with open access at: [https://arxiv.org/](https://arxiv.org/abs/2011.13428).

### 1.2 - 3D
<img src="{{ site.url }}/images/Jenkins&Keppens_2022_synthesis.png" width="200" alt="My ugly mug" style="float: right; padding-left: 2.5rem; width: 40rem">
Following on from the work that is outlined in 1.1, here, we have recently extended the model to a fully 3D domain that assumes periodicity in place of invariance for the third dimension. The focus of this work was to explore the additional evolutionary pathways made possible by considering this third dimension, the ommission of which imposed strong limitations on those evolutions remarked upon within the previous 2.5D study. Namely, the deposition of baroclinicity was previously restricted to the flux surface geometry, and was unable to generate additional fine structuring that may be possible in 3D. Hence, the only vertical motions that were recorded were those from the 'mass-slippage' mechanism that is artificially enhanced by the large resistivity value that we adopted. Since vertical motions are observed ubiquitously throughout quiescent prominences projected above the limb, this is a feature that is neccesary in any model that aims to claim accuracy against observations. The abstract for this work is as follows:

Prominences and filaments are manifestations of magnetized, levitated plasma within the solar coronal atmosphere. Their structure is assumed to be driven by the ambient magnetic field, but various open questions pertaining to their formation and evolution persist. In particular, the discrepancy between their appearance if projected against the solar disk or at the limb remain unexplained. State-of-the-art magnetohydrodynamic simulations yield a fully three-dimensional model that successfully unites the extreme ultraviolet and hydrogen Hα views of quiescent prominences that contain radial striations with the equivalent on-disk filaments comprised of finite width threads. We analyse all hydromagnetic sources of the vorticity evolution and find it consistent with the nonlinear development of the magnetic Rayleigh–Taylor instability. We show that this universal gravitational interchange process can explain the apparent dichotomy of the quiescent prominence/filament appearances. Our simulation could also be used to predict what the instruments associated with the Solar Orbiter and the Inouye Solar Telescope (DKIST) will observe.

The associated paper can be found online at [https://www.nature.com/](https://www.nature.com/articles/s41550-022-01705-z) and with open access, but no saveability, at: [https://rdcu.be/](https://rdcu.be/cRprE)

The source files for this study that can be used, plug and play, within the open source [MPI-AMRVAC](http://amrvac.org) toolkit are available <a href="{{ site.url }}/public_files/jackjenkins/prom_form_JK_2022.zip"> here </a>.

Press releases associated with this study:<br>
Nature Portfolio Astronomy Community: [https://astronomycommunity.nature.com](https://astronomycommunity.nature.com/posts/the-solar-prominence-filament-paradox-the-mrti-or-perhaps-something-else) <br>
Centre for mathematical Plasma Astrophysics News: [https://wis.kuleuven.be/CmPA/news/](https://wis.kuleuven.be/CmPA/news/2022/Nature_astronomy)<br>
Vlaams Supercomputer Centrum: [https://www.vscentrum.be/post/](https://www.vscentrum.be/post/resolving-the-solar-prominence-filament-paradox-using-the-magnetic-rayleigh-taylor-instability)<br>
ERC Prominent News: [https://erc-prominent.github.io//articles/](https://erc-prominent.github.io//articles/paradox_pr/)<br>


# 2. - Synthesis of simulations as observations

### 2.1 - Line core and passband observations
<img src="{{ site.url }}/images/field_aligned_test_thick.png" width="200" alt="My ugly mug" style="float: right; padding-left: 2.5rem; width: 40rem">
[https://yt-project.org](yt-project) is an open-source python package perfectly suited for handling the output of the large simulations that we are undertaking as a part of ERC PROMINENT. One of the bottlenecks encountered when dealing with particularly large simulations are that their file sizes can grow somewhat *extreme*. This renders any attempt for post-processing on a local machine futile in the absence of significant RAM. Instead, yt-project indexes the location of the information within a file for recall *only* when requested. As detailed on the MPI-AMRVAC [website](www.amrvac.org), simulation computation and storage are carried out on a block-by-block basis as a consequence of the adaptive mesh (indexed along a moreton curve). Hence, this lends itself ideally to the yt-project framework wherein not only are post-processing and visualisation applied to the data requested, but also on a block by block basis. This speeds up the read/process/write times up dramatically as the entire simulation, for all saved variables, is not stored within the RAM. It is for this reason and many more (of which I will offload any questions to the yt master himself: [Niels Claes](mailto:niels.claes@kuleuven.be)) that we choose to use yt-project.

<!-- ![]({{ site.url }}/images/field_aligned_test_thick.png) -->

<img src="{{ site.url }}/images/filament_appearance_disk.gif" width="200" alt="My ugly mug" style="float: right; padding-left: 2.5rem; width: 40rem">
Along these lines, yt-project has a number of tools that have already been built in a general way. Of particular interest to me is the use of arbitrarily-oriented ray tracing to synthesise the appearance of our simulations in ways that can be directly compared to observations. Afterall, theory remains theory until proven otherwise. As such, I have implemented a series of synthetic approaches into the yt framework that are currently limited to: h-alpha and the SDO/AIA passbands. An example of this representation is available on the right hand side here, demonstrating how the appearance of a filament differs as it transits the solar disk. The final version of this synthesis contains a minor modification to the method so as to take small LOS velocity shifts into account. This particular simulation is a lower resolution of work that we anticipate to be available in early 2022. The approach adopted here builds on the work previously completed by [Heinzel et al. (2015)](https://ui.adsabs.harvard.edu/abs/2015A%26A...579A..16H/abstract), [Zhao et al. (2018)](https://ui.adsabs.harvard.edu/abs/2019ApJ...872..190Z/abstract), and [Claes et al. (2020)](https://ui.adsabs.harvard.edu/abs/2020A%26A...636A.112C/abstract).

<!-- ![]({{ site.url }}/images/filament_appearance_disk.gif) -->

### 2.2 - Full spectral synthesis
The methods outlined above deal particularly well with synthesising the appearance of solar structures observed using line-core and passband-based filters, such as those emplyed at the GONG and SDO/AIA. For the linecore observations of Hydrogen-alpha, this provides us with an understanding of the structure for the associated material that is either static or moving across the plane-of-sky. Material that moves relative to the line-of-sight (LOS), however, induces a Doppler shift in the associated emission/absorption spectra. For the passband observations that have a non-narrow width by definition e.g., SDO/AIA observations, the LOS velocity information is anyway blurred out and encompassed in a single intensity measurement, and so the methods outlined above are largely okay. For spectrally sensitive observations, be that with a spectrograph or filtergraph, the methods outlined above are insufficient as they do not take into account this LOS velocity (other than to reduce the line-core intensity in the case of Hydrogen-alpha).

The Lightweaver tool recently developed by [Osborne et al. (2021)](https://ui.adsabs.harvard.edu/abs/2021ApJ...917...14O/abstract) takes an atmospheric stratification (assumed plane-parallel in our case and therefore 1D) and solves the full non-local thermodynamic equilibrium (NLTE) radiative transfer problem so as to produce extremely accurate representations of full spectral profiles (continuum -- line core) based on the aforementioned atmospheric stratification. A key component of the involved synthesis is the continuum properties, provided by the photospheric layers of the solar atmosphere and something that we do not currently include within the simulations of solar prominence/filament formation. Fortunately, a number of low-altitude solar models to exist that we can use to augment out coronal-volume simulations. A Hydrogen-alpha example of this is given below where we have used the 2.5D amrvac simulation from above, set the vertical velocity to zero, and applied an ad-hoc temperature multiplier so that the low-temperature variation between nHTot and ne will yield an absorption signature. A lot more work is needed here, but at least the proof of concept is in place.

![]({{ site.url }}/images/full_synthesis_example_v0.png)

# 3. - Integration of data-driven capabilities
Finally, a minor part of my time at KU Leuven is being spent implementing the data-driven utility developed by [Fischer et al. (2020)](https://ui.adsabs.harvard.edu/abs/2020ApJS..248....2F/abstract). This will ideally allow anyone to download, import, and run a MHD simulation based on one of the CGEM SHARP active regions available through JSOC. Current status is that we can read the CGEM data product from the JSOC servers and use this to initialise amrvac using a manual interface that passes data from python to fortran using f2py. It would be nice to automate this as much as possible.


![]({{ site.url }}/images/data_driven_test.gif)

