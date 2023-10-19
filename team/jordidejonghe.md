---
layout: article-aligned
title: "Jordi De Jonghe"
share: false
---

<!-- Note to self: don't forget to update the date at the bottom! -->

Welcome! And thank you for taking an interest in my personal page.

<img src="{{ site.url }}/images/bio-photo-JDJ.jpg" alt="My face in the prime of my life" style="float: right; padding-left: 2.5rem; width: 15rem">

Since joining the project as a PhD student in September 2019, I have focused on the description of waves and instabilities in three models: magnetohydrodynamics (MHD), Hall-magnetohydrodynamics (HMHD), and the ion-electron, two-fluid model. My projects include:
1. an analytic analysis of waves in the two-fluid formalism with a focus on phase and group speed diagrams, as well as whistling behaviour.
2. co-development of the [Legolas](https://legolas.science) code with a focus on implementing additional physics, particularly viscosity and the Hall current.
3. a parametric study of the influence of background flow on the resistive tearing instability with [Legolas](https://legolas.science).

Want to have a look at my work, or get in touch? Check out my [ORCID record](https://orcid.org/0000-0003-2443-3903) and/or [GitHub profile](https://github.com/jordidj) for more details.



### 1. Waves in an ion-electron model

The response to inserting small amplitude oscillations in a homogenous background consisting of electrons and one ion species can be described by a dispersion relation that is fully characterised by 5 parameters: the electron and ion magnetisations, the electron and ion sound speeds, and the angle between the propagation vector and the background magnetic field. This dispersion relation features six pairs of forward-backward propagating waves, which we label S (green), A (red), F (blue), M (purple), O (cyan), and X (black). For propagation parallel and perpendicular to the magnetic field modes can cross in the frequency-wavenumber diagram, whilst this is prohibited for oblique angles, thus establishing a mode ordering: S < A < F < M < O < X. The number of mode crossings and which modes cross (at parallel/perpendicular propagation) depends on the parameter regime. We identified 6 parameter regimes at parallel propagation and 2 regimes at perpendicular propagation (where the S and A modes vanish). Below, three different regimes at parallel propagation are shown side by side. Black dots mark analytical approximations of the crossings.

![Two-fluid frequency-wavenumber diagrams in three different regimes at parallel propagation, featuring various crossings.]({{ site.url }}/images/JDJ_twofluid-crossings.png)

<img src="{{ site.url }}/images/JDJ_group-coronal-MO.gif" width="300" alt="Avoided MO crossing in animated group speed view" style="float: right; padding-left: 2.5rem; width: 40rem">

From the dispersion relation, we can also compute the phase and group speed at any propagation angle. Combining the information for all angles in one figure, we get phase and group speed diagrams. On the right is an animated group speed diagram for coronal loop conditions for a wavenumber interval around the avoided MO crossing. As you can see, the group speed curves of the M (purple) and O (cyan) mode reconnect at the avoided crossing. This reconnecting behaviour occurs for all avoided crossings. More diagrams and animations are available in De Jonghe & Keppens (2020) and its supplementary material.

Using the same two-fluid description and group speed expressions, we showed that all six modes exhibit a form of "whistling behaviour", albeit in different frequency ranges, where the group speed changes drastically with small changes in frequency. Additionally, from this formalism the Appleton-Hartree relation can be derived and expanded to include the effect of the electron thermal velocity. For more information, have a look at De Jonghe & Keppens (2021).



**Publications and proceedings**
1. De Jonghe, J. & Keppens, R. (2020). A two-fluid analysis of waves in a warm ion–electron plasma. *Phys. Plasmas* **27**, 122107. [DOI: 10.1063/5.0029534](https://doi.org/10.1063/5.0029534). [arXiv: 2011.06282](https://arxiv.org/abs/2011.06282).
2. De Jonghe, J., & Keppens, R. (2021). Two-fluid treatment of whistling behavior and the warm Appleton-Hartree extension. *J. Geophys. Res. Space Phys.* **126**, e2020JA028953. [DOI: 10.1029/2020JA028953](https://doi.org/10.1029/2020JA028953). [arXiv: 2104.05275](https://arxiv.org/abs/2104.05275).
3. De Jonghe, J. & Keppens, R. (2021). Laser-induced Cherenkov radiation in a warm two-fluid model. In *47th EPS Conference on Plasma Physics, EPS 2021*, 1235–1238. [Link](http://ocs.ciemat.es/EPS2021PAP/pdf/P5.4009.pdf).



### 2. New physics for Legolas

<img src="{{ site.url }}/images/legolas_logo_400x250.png" alt="Legolas logo" align="left">

The development of the [Legolas](https://legolas.science) code was initiated by [Niels Claes](../nielsclaes) to analyse the influence of non-ideal effects on inhomogeneous plasma configurations in Cartesian or cylindrical geometries. The result is the finite element code Legolas for 1D MHD spectroscopy. When the code became publicly available for the first time, it included flow, resistivity, thermal conduction, radiative cooling, and external gravity. The code and its features are presented in the accompanying release publication Claes, De Jonghe & Keppens (2020), with a variety of test cases from the spectroscopy literature.

In De Jonghe, Claes & Keppens (2022) we finally present the extension of the code with viscosity and the Hall current, both important effects in evaluating the stability of plasma configurations, e.g. in relation to the resistive tearing mode, alongside other smaller improvements such as the inclusion of an incompressible approximation and calculation of entropy and magnetic field perturbations. Besides viscosity and the Hall current, we also added the option to include the effect of electron inertia. Without the electron inertia term the HMHD model recovers the ion cyclotron resonance, but not the electron cyclotron resonance. Including the electron inertia term also adds the electron cyclotron resonance and brings the HMHD model closer to the two-fluid model. The figure below highlights this with a Legolas multirun of the homogeneous plasma slab with Hall current (a) without electron inertia and (b) with electron inertia term. (The lowest horizontal line is the ion cyclotron resonance, the highest horizontal line is the electron cyclotron resonance, and the blue solid lines are the analytic HMHD solution.) This is just one test case from this paper.

![Comparison of a Legolas multirun of the homogeneous plasma slab with Hall current for varying wavenumber without electron inertia (left) and with electron inertia (right). The left panel without electron inertia only has the ion cyclotron resonance, whereas the right panel with electron inertia also recovers the electron cyclotron resonance.]({{ site.url }}/images/JDJ_elecinertia.png)

The code is actively maintained and under continuous development by [Niels](../nielsclaes) and myself.

**Publications**
1. Claes, N., De Jonghe, J. & Keppens, R. (2020). Legolas: A modern tool for magnetohydrodynamic spectroscopy. *Astrophys. J., Suppl. Ser.* **251**, 25. [DOI: 10.3847/1538-4365/abc5c4](https://doi.org/10.3847/1538-4365/abc5c4). [arXiv: 2010.14148](https://arxiv.org/abs/2010.14148).
2. De Jonghe, J., Claes, N. & Keppens, R. (2022). Legolas: Magnetohydrodynamic spectroscopy with viscosity and Hall current. *J. Plasma Phys.* **88** (3), 905880321. [DOI: 10.1017/S0022377822000617](https://doi.org/10.1017/S0022377822000617). [arXiv: 2206.07377](https://arxiv.org/abs/2206.07377).



### 3. Tearing instability in flowing media

Ever since its discovery the resistive tearing mode has been the subject of many studies. Interest in this particular instability was recently reinvigorated by its possibly key role in triggering magnetic reconnection, which is required for the violent eruptions witnessed on the solar surface. However, observations are not in line with purely resistive simulations. Hence, other effects are also at play here, and should thus be accounted for. Besides viscosity and the Hall current, which both affect the tearing growth rate, another important candidate presents itself: background flow. Since solar plasma is constantly moving, we seek to understand how the tearing instability is affected by background flow.

To investigate this issue, we turn to the [Legolas](https://legolas.science) multirun framework, which allows us to perform many Legolas runs whilst varying one or more parameters. This can then be done for various setups, such as a magnetic field that varies its orientation throughout a plasma slab or a Harris current sheet, to identify which parameters play a role in the influence of flow on the tearing growth rate. It was found that many parameters affect the growth rate in an intricate way, as evidenced by the image below, showing the tearing growth rate during a simultaneous variation of the velocity coefficient and plasma-$\beta$ for the direction-varying magnetic field case mentioned above. More details and results can be found in the publications listed below.

![Legolas multiruns reveal how the tearing growth rate is affected in an intricate way by the combination of velocity coefficient and plasma-beta for a plasma slab with a direction-varying magnetic field.]({{ site.url }}/images/JDJ_v02beta.png)

**Publications and proceedings**
1. De Jonghe, J. & Keppens, R. (2023). Tearing growth rate of a viscoresistive Harris sheet subject to flow. In *49th EPS Conference on Plasma Physics, EPS 2023*. Awaiting publication.
2. De Jonghe, J. & Keppens, R. (2023). The linear regime of the flow-sheared resistive tearing mode. Under review.

---
*This page was last updated on 19 October 2023.*
