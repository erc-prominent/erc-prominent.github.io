---
layout: archive
title: "News"
excerpt: "A collection of news items related to the PROMINENT project"
---

<div class="tiles">
{% for post in site.categories.articles %}
  {% include post-grid.html %}
{% endfor %}

<!-- Special tile with link to Wenzhi's flare model newsflash -->
<div class="tile">
  <div class="post-teaser">
    <a href="https://nieuws.kuleuven.be/en/content/2020/ku-leuven-researchers-shed-new-light-on-solar-flares">
      <img src="{{ site.url }}/images/wenzhi_flare_400x250.png">
    </a>
  </div>
  <p class="entry-date">June 18, 2020</p>
  <a href="https://nieuws.kuleuven.be/en/content/2020/ku-leuven-researchers-shed-new-light-on-solar-flares">
    <h2 class="post-title">New light on solar flares</h2>
  </a>
  <p class="post-excerpt">
    Read the newsflash on the First Self-Consistent Model of a Solar Flare. See also the
    <a href="https://www.robtv.be/nieuws/onderzoekers-ku-leuven-leggen-geheimen-van-zonnevlammen-bloot-100373">TV interview (in Dutch)</a>.
  </p>
</div>

<!-- Special tile with link to the Solar Orbiter newsflash -->
<div class="tile">
  <div class="post-teaser">
    <a href="https://ec.europa.eu/research-and-innovation/en/horizon-magazine/five-things-were-going-learn-europes-solar-orbiter-mission">
      <img src="{{ site.url }}/images/esa_so_400x250.png">
    </a>
  </div>
  <p class="entry-date">February 7, 2020</p>
  <a href="https://ec.europa.eu/research-and-innovation/en/horizon-magazine/five-things-were-going-learn-europes-solar-orbiter-mission">
    <h2 class="post-title">Newsflash on Solar Orbiter</h2>
  </a>
  <p class="post-excerpt">
    Read the newsflash on the occasion of the Solar Orbiter launch: <i>Five things we are going to learn from Europe's Solar Orbiter Mission</i>.
  </p>
</div>

<!-- Special tile with link to Rony's interview -->
<div class="tile">
  <div class="post-teaser">
    <a href="https://set.kuleuven.be/en/news/interview-rony-keppens">
      <img src="{{ site.url }}/images/kul_logo_400x250.png">
    </a>
  </div>
  <p class="entry-date">September 24, 2019</p>
  <a href="https://set.kuleuven.be/en/news/interview-rony-keppens">
    <h2 class="post-title">Interview with Rony Keppens</h2>
  </a>
  <p class="post-excerpt">
    Read the interview with prof. Rony Keppens, the PI of this project, on being awarded the ERC grant and how it fits into the research group.
  </p>
</div>

</div>





