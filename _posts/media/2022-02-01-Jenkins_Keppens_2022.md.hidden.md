---
layout: media-aligned
title: "3D Prominence formation"
categories: media
excerpt: "The successful simulation of a fully 3D solar filament/prominence, down to scales of ~20 km, using MPI-AMRVAC."
share: true
image:
  teaser: Jenkins&Keppens_2020_10G_400x250.png
---

[//]: # feature: Jenkins&Keppens_2020_synthesis.png


[//]: # <!-- <h3 style="display: inline-block;"></h3> -->

**3D prominence formation**
*Author: [Jack Jenkins]({{ site.url }}/team/jackjenkins)*

In well-received previous work that we detailed [here]({{ site.url }}/media/Jenkins_Keppens/), we used the open-source [MPI-AMRVAC](www.amrvac.org) code to study the formation and evolution of coronal condensations (cool plasma) within a 2.5D flux rope. By constructing distance-time representations of these simulations, and converting the primitive variables (pressure, temperature) into information relating to the emission/absorption of the associated plasma, we were able to approximate the small-scale evolution of solar filaments and prominences. Since then, we have been working hard on bringing these simluations to life, that is, bringing them into the real 3D world. In this post, we're going to highlight the tools used, and associated results, to decode the simulation from a bunch of numbers in a matrix to finally resemble the images of the solar atmosphere that are captured on a daily basis. If you're interested, however, then the more technical details involved in the process of creating the simulation itself are available [here]({{ site.url }}/team/jackjenkins).

If you imagine a three-dimensional volume, a region of space, that you can split up into little cubes then you have a pretty good representation of the raw output of our simulation. The more cubes we split this volume into, the higher the resolution that we are dealing with i.e., we can see smaller and smaller details. Naturally, anyone working with simulations wants to make it so that they can see all of the intricate details within whatever physical process they're approximating with computer code. Indeed, a great deal of focus within the simulation community centers on improving computational efficiency, and this is because if you increase the resolution (think of it as increasing the number of little squares) then it takes longer to complete a simulation as it has to compute more 'things', as it were. The 3D simulation we have completed completed is one of the highest resolution simulations of solar filaments/prominences that has ever been completed. Now this highlights the computational efficiency of MPI-AMRVAC, for one, but there's another consideration here. 

All of that information has to be stored, right? And once it's stored, it has to be opened by a program so you can check the results, analyse them, and create plots and movies. For the 2.5D simulations (imagine a slice comprised of a single 2-dimensional row + column of information) that we spoke about earlier, this wasn't so complicated as each individual file, corresponding to a single timestep, contained not much more than ~ 2 GB of information. If you're even remotely familiar with modern computer architecture then you'll know that this is relatively trivial to load into RAM and access with whichever program is your favourite. Of course, this becomes slightly more complex when you have, say, 700 files that you want to process - but it can still be done. If we now fastforward to our new 3D simulations, each file is approximately 10 times larger (32 -- 45 GB) and whilst some big computers might be able to load that all into RAM it will be extremely slow to process, and this is just for a single file out of the potential 700... So how did we overcome this? [yt-project](www.yt-project.org) is the python library at the heart of our post-processing tools and the incredible developers that maintain this framework are to thank for making simulations like ours feasible. In short, instead of reading the entire simulation into the RAM in one go, the structure of a single file is mapped such that only the reference information is stored in the RAM. Assuming I want to take a slice of the simulation and take a look at the density, the stored framework tells the ram exactly where in the file (i) the density information is stored and (ii) where the information about the density in the slice I want, is stored. This might seem like a small distinction but it is fundamentally different from reading *all* the data in and showing only what I ask for. The important result is that I can view a slice within my simulation in a fraction of a minute, rather than after some hours.

Once the data can be readily accessed, manipulating it is easy. This is further facilitated by the yt-project framework and integrated derived fields. And so without further ado, a 3D solar prominence.


[//]: # <iframe width="560" height="315" src="https://youtu.be/AchpAjNmMJI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[//]: # <iframe width="560" height="315" src="https://www.youtube.com/embed/a5YiodjdtDs" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>