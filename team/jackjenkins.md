---
layout: article
excerpt: "Jack Jenkins"
share: false
---

Hello there!

On this page I will detail some of the things that I have been doing as a part of the ERC PROMINENT project.

A brief breakdown of my responsibilities thusfar:
1. Development of idealised 2.5 and 3D flux rope formation and prominence condensation models within [MPI-AMRVAC](www.amrvac.org).
2. Addition of synthetic views (e.g., SDO/AIA) to the yt-project frontend
3. Integration of data-driven intitial conditions, following the implementation of [Fischer et al. (2020)](https://ui.adsabs.harvard.edu/abs/2020ApJS..248....2F/abstract), into MPI-AMRVAC.

<ins>Progress so far:</ins> 

# 1.
We have fully realised a 2.5D simulation of the formation and condensation of a solar prominence following the pioneering work of Kaneko & Yokoyama (2015). Herein, a linear force-free magnetic field is deformed (in line with general evolution of the solar photosphere i.e., footpoint driven prescribed in the bottom boundary) so as to initiate magnetic reconnection and the formation of a 2.5D flux rope with isolated material suspended within the solar corona. This material then condensed following radiative losses and so-called 'runaway radiative cooling' that leads to the in-situ formation of condensations via the thermal instability. The abstract for this work is as follows:

**Context**: Prominences in the solar atmosphere represent an intriguing and delicate balance of forces and thermodynamics in an evolving magnetic topology. How this relatively cool material comes to reside at coronal heights, and what drives its evolution prior to, during, and after its appearance, remains an area full of open questions.  
**Aims**: We here set forth to identify the physical processes driving the formation and evolution of prominence condensations within 2.5D magnetic flux ropes. We deliberately focus on the levitation-condensation scenario, where a coronal flux rope forms and eventually demonstrates in situ condensations, revisiting it at extreme resolutions down to order 6 km in scale.  
**Methods**: We perform grid-adaptive numerical simulations in a 2.5D translationally invariant setup, where we can study the distribution of all metrics involved in advanced magnetohydrodynamic stability theory for nested flux rope equilibria. We quantify in particular convective continuum instability (CCI), thermal instability (TI), baroclinicity, and mass-slipping metrics within a series of numerical simulations of prominences formed via levitation-condensation.  
**Results**: Overall, we find that the formation and evolution of prominence condensations happens in a clearly defined sequence regardless of resolution, with background field strength between 3 and 10 Gauss. The CCI governs the slow evolution of plasma prior to the formation of distinct condensations found to be driven by the TI. Evolution of the condensations towards the topological dips of the magnetic flux rope is a consequence of these condensations initially forming out of pressure balance with their surroundings. From the baroclinicity distributions, smaller-scale rotational motions are inferred within forming and evolving condensations. Upon the complete condensation of a prominence 'monolith', the slow descent of this plasma towards lower heights appears consistent with the mass-slippage mechanism driven by episodes of both local current diffusion and magnetic reconnection.

The associated paper can be found online at: [https://www.aanda.org/articles/aa/pdf/2021/02/aa39630-20.pdf](https://www.aanda.org/articles/aa/pdf/2021/02/aa39630-20.pdf) and with open access at: [https://arxiv.org/abs/2011.13428](https://arxiv.org/abs/2011.13428).


# 2.
[https://yt-project.org](yt-project) is an open-source python package perfectly suited for handling the output of the large simmulations that we are undertaking as a part of ERC PROMINENT. One of the bottlenecks encountered when dealing with particularly large simulations are that their file sizes can grow somewhat *extreme*. This renders any attempt for post-processing on a local machine futile in the absence of significant RAM. Instead, yt-project indexes the location of the information within a file for recall *only* when requested. As detailed on the MPI-AMRVAC [www.amrvac.org](website), simulation computation and storage are carried out on a block-by-block basis as a consequence of the adaptive mesh (indexed along a moreton curve). Hence, this lends itself ideally to the yt-project framework wherein not only are post-processing and visualisation applied to the data requested, but also on a block by block basis. This speeds up the read/process/write times up dramatically as the entire simulation, for all saved variables, is not stored within the RAM. It is for this reason and many more (of which I will offload any questions to the yt master himself: [Niels Claes](mailto:niels.claes@kuleuven.be)) that we choose to use yt-project.

![](/images/field_aligned_test.png)

Along these lines, yt-project has a number of tools that have already been built in a general way. Of particular interest to me is the use of ray tracing to synthesise the appearance of our simulations in ways that can be directly compared to observations. Afterall, theory remains theory until proven otherwise. As such, I have implemented a series of synthetic approaches into the yt framework that are currently limited to: h-alpha and the SDO/AIA passbands.

![](/images/filament_appearance_disk.gif)


# 3.
Finally, a major part of my time at KU Leuven is being spent implementing the data-driven utility developed by [Fischer et al. (2020)](https://ui.adsabs.harvard.edu/abs/2020ApJS..248....2F/abstract). This will ideally allow anyone to download, import, and run a MHD simulation based on one of the CGEM SHARP active regions available through JSOC.


![](/images/data_driven_test.gif)

