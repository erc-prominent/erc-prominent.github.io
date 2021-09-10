---
layout: article-aligned
title: "Niels Claes"
share: false
---

Hi there!

<img src="{{ site.url }}/images/bio-photo-NC.png" alt="Legolas logo" style="float: right; padding-left: 2.5rem; width: 15rem">
I'm currently a PhD student on the project, having joined in the beginning of 2020. <br>
My main responsibilities:
1. Development and maintenance of the [Legolas](https://legolas.science) code.
2. Applying Legolas to spectroscopic studies of the solar atmosphere, with focus on thermal instabilities.
3. Simulations of thermal instability and fine structure using MPI-AMRVAC.
4. Maintenance/development of the MPI-AMRVAC frontent in yt for data analysis and visualisation.

Feel free to contact me: [niels.claes@kuleuven.be](mailto:niels.claes@kuleuven.be).

### 1. Work on thermal instability
At first, my time was largely spent on the study of thermal instabilities in rather simple setups, that is,
homogeneous Cartesian backgrounds with solar atmospheric conditions. The main advantage of this approach is that I
could focus entirely on the process of thermal instability itself, and investigate how it gives rise to more complex
phenomena such as high-density condensations and smaller structures within the formed instabilities. This was done through
a combination of analytical work, simulations using [MPI-AMRVAC](http://amrvac.org) and visualisations with [yt](https://yt-project.org).
The main takeaway of these simulations is that in those configurations the eventual fine structure that forms through the process
of thermal instability may not always perfectly align with the magnetic field, which is usually assumed to be the case.
More details can be found in [here](https://www.aanda.org/articles/aa/abs/2020/04/aa37616-20/aa37616-20.html).

<figure class="half">
    <img src="{{ site.url }}/images/density_plots.png">
	<img src="{{ site.url }}/images/TI_3d_rendering.png" style="width: 40%">
	<figcaption>
        Fine structure formed during the thermal instability process, in 2D (left) and 3D (right) for a
        homogeneous setup. The right figure was made with a volume rendering in yt.
    </figcaption>
</figure>


### 2. Developing Legolas
Of course, when moving on to more realistic configurations inhomogeneities introduce themselves. This complicates the analysis considerably, and
makes a detailed analytical treatment quite difficult (impossible) for most, if not all, equilibrium configurations. To tackle this particular problem
I have spent most of my time developing [Legolas](https://legolas.science), a new state-of-the art finite element code tailored to MHD spectroscopy.
A detailed overview of what the code can do and how we applied it can be found in our method paper, published in ApJS:
[Claes, De Jonghe & Keppens (2020)](https://doi.org/10.3847/1538-4365/abc5c4).
<img src="{{ site.url }}/images/legolas_logo_400x250.png" alt="Legolas logo" align="right">
Legolas includes a plethora of physical effects (thermal conduction, radiative cooling, resistivity, flow, etc.), and is also the first code for MHD spectroscopy
that combines all of these into one consistent framework.

For the moment I am largely focused on the MHD spectrum of fully realistic solar atmosphere models, and try to make
hitherto uninvestigated connections between thermal instabilities and the role that anisotropic thermal conduction plays in the eventual formation of fine structure.

I am also currently maintaining and developing the code even further, in close collaboration with [Jordi De Jonghe](../jordidejonghe),
such that the workload is balanced between the both of us. I am mainly working on the internal code structure, testing framework and thermal conduction extensions,
with Jordi running point on the viscosity and Hall additions to the Legolas physics framework.


### 3. Applying Legolas to realistic models
In recent work we applied Legolas to a fully realistic solar atmosphere model, yielding a self-consistent stratified atmosphere on which we performed a detailed eigenspectrum analysis. Here we showed that our solar models indicate a great variety of linear pathways to form condensations. Knowing that the solar atmosphere itself can have many interacting (linear) waves and instabilities at play, modern nonlinear simulations may benefit greatly from the full knowledge of all linear instabilities of a given equilibrium state. More information about this
work can be found [here]({{ site.url }}/articles/solaratmo_spec/).
