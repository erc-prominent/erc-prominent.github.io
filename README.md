# Quickstart guide on adding stuff to the website

> You can put questions, ideas, suggestions etc either in the #erc-prominent channel on Slack or in the "Discussions" tab above.

This repository contains the source code for the ERC PROMINENT website, which is rendered straight from the `gh-pages` branch 
using [Jekyll](https://jekyllrb.com). The general framework is based on the [Skinny Bones](https://mmistakes.github.io/jekyll-theme-skinny-bones/) theme.
The website build process is set up to happen automatically, every commit will rebuild the website and deploy it. Deployment will take 1-2 minutes, depending on the amount of pages,
a green checkmark will appear if the build is successful. **Note**: _when you push, it can take a minute or two before your changes are visible since Jekyll needs to build the pages.
Refresh your browser after a few minutes to see the changes taking effect._

## Table of contents
1. [How to start editing](#how-to-start-editing)
2. [Overview of relevant pages](#overview-of-relevant-pages)
    - 2.1 [Homepage](#homepage)
    - 2.2 [About](#about)
    - 2.3 [News](#news)
    - 2.4 [Publications](#publications)
    - 2.5 [Media](#media)
    - 2.6 [Meet the team](#meet-the-team)
3. [Preview before pushing](#preview-before-pushing)
4. [Some convenient shortcuts](#some-convenient-shortcuts)

## How to start editing
The first step is cloning the repository:
```
git clone https://github.com/erc-prominent/erc-prominent.github.io.git
```
Next you can start editing the relevant pages, explained in the next section. 
If you already cloned the repository before you probably want to fetch the latest updates from the repository:
```
cd erc-prominent.github.io
git pull origin master
```
Now you can start making your changes. It is a good idea (but not required) to locally build the website first
before pushing your changes to the repository (see [here](#preview-before-pushing)). When you're done editing, commit your changes and push to the master branch:
```
git add <files>
git commit -m "<commit message>"
git push origin master
```

## Overview of relevant pages

### Homepage
The homepage can be found in `index.md`. This one will probably not need any editing, unless you want to change some things that are displayed in the tiles.
All media posts and news items that have dedicated pages to them will automatically appear in bullets at the bottom of the homepage.

### About
The About page can be found in `about/index.md`, which uses general markdown syntax. You can make any edits you want underneath the second `---` line.

### News
The News page is located in `news/index.md`, but does not require editing. When you want to add a News page, do so in the `_posts/news` directory. Every file added here
will automatically appear in the overview in the News tab. Files added to the `_posts/news` directory should follow the convention `YYYY-MM-DD_name.md`, you can take a look
at the item already there. The content between the two lines `---` is called _frontmatter_ and tells Jekyll how to build this page. Here is an example:
```
---
layout: article-aligned
title: "Launching Legolas"
categories: articles
excerpt: "Read up on the launch of the new Legolas code, a novel tool for MHD spectroscopy."
modified: 2021-04-07
share: false
image:
  teaser: legolas_logo_400x250.png
  feature:
---
```
- `layout`: can be "article" or "article-aligned". The first one is a more narrow page without alignment, the second one is a wider page with aligned text.
- `title`: quite self-explanatory
- `categories`: you should put "articles" here, this makes sure it gets automatically added in the News overview.
- `excerpt`: short description of the post, will appear underneath the title in the grid overview on the News page.
- `modified`: optional, this puts a "last modified at" line at the bottom of the page.
- `share`: if set to "false", removes the "Share on Twitter" buttons at the bottom.
- `image`:
    - `teaser`: a teaser image that will be added to the grid item in the News overview. Preferably this image should have dimensions 400x250 px so everything is aligned properly.
                Add images in the `images` folder.
    - `feature`: can be left empty. If not, this will put a big image on the page itself. For an example, see Jack's post in `_posts/media`.

Everything below the `---` line can be edited using regular markdown syntax.

### Publications
The publications page can be found in `publications/index.md`, which will be empty when you try a local build. The publication list is generated automatically after every commit
using the `publications/generate_publist.py` script which fetches all relevant papers related to the project from the web, parses them and puts them in a table. 
There is probably no need to edit the `index.md` file, but if you do so only do it above the "do not edit" line (everything below will be replaced). 

### Media
Can be found in `media/index.md`, uses the exact same setup as the News tab. The only difference here is that items should be added to the `_posts/media` folder, and set
`categories: media` instead of `categories: articles` in the frontmatter.
These pages are meant for picture galleries, YouTube videos, gifs, etc.

### Meet the team
The main page of this tab can be found in `team/index.md`. This is not really markdown syntax, but it should be clear where you can edit stuff based on what is already there.
Every member here has his/her own page in the same folder, which you can use to state when you entered the team, what you are working on, some results you already obtained, etc.
A small bio photo would also be quite nice, you can put these in the `images` folder.

## Preview before pushing
It's a good idea to first render the website locally before you push to the repository, since in some cases you spot typos/broken links/broken images only when you see the 
content rendered. You don't _have_ to do this, but it's quite convenient and avoids you having to push multiple things in rapid succession to tweak things.
You will need [Jekyll](https://jekyllrb.com) for this, which uses Ruby. See [this page](https://jekyllrb.com/docs/installation/) for installation instructions and prerequisites. 
Normally both macOS and Linux should have Ruby distributions by default, so you should be good here. 
If this is not the case for some reason, the instructions are quite straightforward and shouldn't be much work.

Once you have Ruby, install Jekyll through
```
gem install jekyll bundler
```
That's it, now cd into the repository, build and view:
```
cd erc_prominent.github.io
bundle exec jekyll serve
```
Open your browser at `http://127.0.0.1:4000` to view the locally built site. 
You can keep this command running and edit further, as long as you're serving you'll see your changes in real time by refreshing the page.

## Some convenient shortcuts

### Adding images
You can add images using markdown syntax as follows, but note that you should prepend `{{ site.url }}` before the link.
This will avoid broken links, and will also properly render the pages locally.
```markdown
![]({{ site.url }}/images/your_image.png)
```
If you want more control of where your image is placed, for example like I did on the "Releasing Legolas" News page, you'll need an image tag:
```html
<img src="{{ site.url }}/images/your_image.png" align="right">
```
which will align the image to the right and wrap the text around it. You can play around with `align="left"` or `align="center"` as well.

### Embedding YouTube links
This makes uses of `iframes`, but you don't need to do anything yourself. Just go to YouTube, click "share", then on "Embed" and copy-paste the link it generates into
your markdown document.
