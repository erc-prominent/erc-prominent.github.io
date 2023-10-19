---
layout: article-aligned
excerpt: "Malcolm Druett"
share: false

---

Hi! 

<img src="{{ site.url }}/images/bio-photo-MD.jpg" width="200" alt="Malcolm" style="float: right; padding-left: 2.5rem; width: 20rem">
<p>On this page I will outline my research during my time working on the ERC PROMINENT project.</p>
<p>For a more complete history of my research, please visit my <a href="https://mdruett.github.io/mdruett_website/">personal webpage</a>.</p>



Summary of activities:
1. The first multi-dimensional flare simulations with chromospheric evaporation driven by energetic beam electrons, published in the Solar Physics Journal.
2. Exploring the lower atmosphere and variations of background field strength for the 2.5D flare models using [MPI-AMRVAC](http://amrvac.org).
3. Developing a schematic model of solar flare ribbons informed by simulations and observations. 
4. Using our flare models to interpret subsecond observations of flare ribbon formation using the IRIS satellite.
5. External PhD supervision of Vishal Singth at Northumbria University.
6. Successful multi-instrument co-observing proposal to SOLARNET.
8. Chairing an RAS Specialist discussion meeting on the future of solar flares, with an associated publication in the Astronomy and Geophysics Magazine.

<ins>Prominent conference presentations and conference chairing:</ins>
<li>        2022.08.07-10 Chairing meeting: Solar MHD 2022 conference </li>
<li>        2023.01.13 Chairing meeting: RAS Specialist Discussion Meeting: New generation modelling of solar flares </li>
<li>        2023.05.10 Presentation: Chromospheric evaporation by particle beams in multi-dimensional flare models, (SOLARNET conference, Potsdam, Germany) </li>
<li>	    2023.11.10 Presentation: Evaporation, condensation, and flare ribbons, (The Coronal Condensations RAS Specialist Discussion Meeting, London, UK) </li>


<ins>Progress so far:</ins> 

# 1. - Solar flare simulations in ARMVAC

### 1.1 - The first multi-dimensional simulations with chromospheric evaporation by energetic beam electrons
<img src="{{ site.url }}/images/flare_B50_e600_g_up1100.png" width="200" alt="Malcolm" style="float: cente; width: 100rem">
Chromospheric evaporation is a fundamental process in solar flares. It concerns the heating and upflow of dense and previously (relatively) cool plasma from the lower atmosphere into coronal flare loops. These dense, hot coronal loops then emit powerful radiation in the UV and X-ray bands. In detailed 1D simulations since the 1970s  the primary agents causing this evaporation have been beams of energetic particles travelling from energy release sites in the high atmosphere, down to strike the lower atmosphere. However, until now this effect has never been achieved in multi-dimensional models. Using as a basis the 2.5D flare simulations of <a href="https://ui.adsabs.harvard.edu/abs/2020ApJ...896...97R/abstract">Ruan et al. 2020</a> programmed in <a href="https://ui.adsabs.harvard.edu/abs/2023A%26A...673A..66K/abstract">MPI-AMRVAC</a> we report the first successful simulation of this phenomenon. 
The abstract for this work follows:

Evaporation of chromospheric plasma by particle beams has been a standard feature of models of solar flares for many decades, supported both by observations of strong hard X-ray bremsstrahlung signals, and detailed 1D hydrodynamic radiative transfer models with near-relativistic electron beams included. However in multi-dimensional models, evaporation, if included, has only been driven by heat conduction and by the impact and reflection of fast plasma outflows on the lower atmosphere. Here we present the first multi-dimensional flare simulation featuring evaporation driven by energetic electrons. We use a recent magnetohydrodynamic model that includes beam physics, but decrease the initial anomalous resistivity to create a gentler precursor phase, and improve on the dynamic resistivity treatment that determines where beams are injected. Beam-driven evaporation is achieved. The relevant factors are thermal conduction and electron beams, with the beam electrons more than doubling the kinetic energy flux, and adding 50% to the upward mass from the chromosphere. These findings finally pave the way for integrating detailed 1D flare modelling within a self-consistent 2D and 3D context. The beam fluxes from these self-consistent models can be used to directly compare multi-dimensional results with those from the externally injected beam fluxes of 1D models, as well as understand further evaporation-driven phenomena relating to beams of particles.
The associated paper can be found online: <a href="https://ui.adsabs.harvard.edu/abs/2023arXiv231011226D/abstract">Accepted to Solar Physics Journal</a> and with open access at: <a href="https://arxiv.org/abs/2310.11226">https://arxiv.org/abs/2310.11226</a>.

### 1.2 - Exploring the lower atmospheric response and magnetic field strength variations

<img src="{{ site.url }}/images/flare_Cont_chromo_excavation_late.png" width="200" alt="Malcolm" style="float: left; padding-right: 2.5rem; width: 40rem">

Multi-dimensional studies of solar flares have reproduced many new phenomena in the corona. In this paper we investigate the impact of the flare energy release on the lower solar atmosphere. Metrics and graphics are produced with an eye to aiding in the comparison between multi-dimensional simulations and results from decades of detailed 1D simulations. The abstract for this work is:

Context. The advent of multi-dimensional solar flare simulations has led to numerous investigations of coronal flows and new physical insights. These studies have not yet included detailed analysis of the lower atmospheric responses such as down-flowing chromospheric compressions and chromospheric evaporation processes.
Aims. In this work, we present an analysis of multi-dimensional flare simulations, including analysis of chromospheric up-flows and down-flows that help to elucidate multi-dimensional effects. We also provide important groundwork for comparing 1D and multi-dimensional models, with the aim that future multi-dimensional simulations can include detailed field-aligned physical processes.
Methods. A localized anomalous resistivity initiates magnetic reconnection, which drives the evolution of a standard solar flare model. We vary the background magnetic field strength, to produce four flare simulations that cover a large span of observationally reported solar flare strengths. Chromospheric energy fluxes, and energy density maps are used to analyse the transport of energy from the corona to the lower atmosphere, and the resultant evolution of the flare. Quantities traced along 1D field-lines allow for detailed comparison with 1D evaporation models. We highlight the similarities, stressing deficiencies from simplified physics along these 1D flux tubes, and crucial effects that enter by multi-dimensional effects. 
Results. The flares produced by varying the background coronal field strength between 20 G and 65 G have GOES classifications between B1.5 and M2.3. All produce a lobster-claw reconnection out-flow and a fast shock in the tail of this flow with similar maximum Alfvén Mach number of ∼ 10. The impact of the reconnection out-flow on the lower atmosphere and heat conduction are the key agents driving the chromospheric evaporation and "down-flowing chromospheric compressions". The peak beam electron heating flux in the lower atmospheres varies between 1.4 × 10^9 and 4.7 × 10^10 erg cm^−2 s^−1 across the simulations. The "down-flowing chromospheric compressions" have kinetic energy signatures that reach the photosphere, but at subsonic speeds, so would not generate sunquakes. Surprisingly, the weakest flare generates relative dense flare loop system, despite having a negative net mass flux through the top of the chromosphere, i.e. more mass is supplied downward than is evaporated upward during the flare. The stronger flares all produce positive mass fluxes. Plasmoids form in the current sheets of the stronger flares due to tearing, and in all experiments the loop-tops contain turbulent eddies that ring via a magnetic tuning fork process. Periodic compression by neighbouring flux tubes creates pockets of high density in the coronal loops. These pockets of density reduce the fluxes of the electron beams reaching the lower atmosphere. This is another potential mechanism for the generation of periodic pulsation phenomena.

The associated paper can be found online: <a href="https://ui.adsabs.harvard.edu/abs/2023arXiv231009939D/abstract">Submitted to Astronomy and Astrophysics</a> and with open access at: <a href="https://arxiv.org/abs/2310.09939">https://arxiv.org/abs/2310.09939</a>.



# 2. - An observation and simulation informed picture of solar flare ribbon formation



### 2.1 - Using the Swedish Solar Telescope

<img src="{{ site.url }}/images/Druett_Coco.png" width="200" alt="Malcolm" style="float: right; padding-left: 2.5rem; width: 35rem">
Using the COCOPLOT algorithm I designed in <a href="https://ui.adsabs.harvard.edu/abs/2022RASTI...1...29D/abstract">Druett et al. 2022</a> which collapses the spectral dimension of a datacube into a colour (see figure right), my co-authors and I have identified and characterised high-resolution spectro-polarimetric observations of solar flare ribbons in a number of papers including to derive the first observational estimate of the mass in a fan jet (<a href="https://ui.adsabs.harvard.edu/abs/2022A%26A...659A..58P/abstract">Pietrow et al. 2022</a>) and a paper investigating the Sun-as-a-star in flares (<a href="https://ui.adsabs.harvard.edu/abs/2023arXiv230903373P/abstract">Pietrow et al. 2024</a>), as well as forthcoming works by Pietrow and Druett 2024, and Singh et al. 2024.

### 2.2 - Using the IRIS satellite

My collaborators and I were successful in gaining observational time through the SOLARNET scheme. As part of this we proposed co-observations of solar flares from ground and space-based telescopes using subsecond cadence imaging. The Sun obligingly provided a flare on 2023-09-13 which was captured by <a href="https://ui.adsabs.harvard.edu/abs/2014SoPh..289.2733D/abstract">the Interface Region Imaging Spectrograph (IRIS)</a>. We are using data from transition-region lines of the Sun to investigate the downflows created in solar flares that are predicted by our simulations listed above. This work will be published in a forthcoming paper by Druett et al.


