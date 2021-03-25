# Quickstart guide on adding stuff to the website

> You can put questions, ideas, suggestions etc either in the #erc-prominent channel on Slack or in the "Discussions" tab above.

This repository contains the source code for the ERC PROMINENT website, which is rendered straight from the `master` branch using [Jekyll](https://jekyllrb.com). This is set up to happen automatically, every commit will rebuild the website and deploy it. Deployment will take 1-2 minutes, depending on the amount of pages and a green checkmark will appear if the build is successful.

## What's in the repository
I have added the general layout, so all that is left is populating the various pages with text, images, etc. The following folders are the "relevant" ones, all others are build-related:
- `index.md`: This is the homepage. You can edit the html here if you want, I've currently set this up such that all posts in media or news are automatically added at the bottom in 3 columns, underneath "Latest news".

- `_posts`: This contains two folders:
  - `media`: meant as a sort of gallery where you can showcase pictures, embed movies and so on related to your work.
  - `news`: meant for general news, such as published papers, press releases, blog posts, etc.

  Files in these folders should follow the format `YYYY-MM-DD-name.md`, which will automatically rearrange them (most recent ones first). You can take a look at the samples already there, all text written in these files uses simple markdown syntax.
- `about`: The `index.md` file here corresponds to the "about" page on the website, and can be modified using markdown syntax.
- `images`: All new images should go in this folder.
- `team`: Contains all files for the "Meet the Team" page on the website, the `index.md` file is the homepage. Note that this page uses html instead of markdown, I've marked where you should put a small bio. Also replace the `src="/images/bio-photo.jpg"` link with your personal image (if you want). The other files in this folder are personal pages, you reach these by clicking your bio photo. These pages are meant to have some more information, such as
  - Position/role within the project
  - Time period you're on the project
  - What you're working on
  - ...

- `media`: Contains the file for the "Media" page on the website. I've set this up to automatically arrange all files in the `_posts/media` folder in a grid with most recent first, so this can be left alone.
- `news`: Contains the file for the "News" page on the website. Similar to `media`, this will arrange all files in the `_posts/news` folder. Can be left alone.

## Adding a new post
If you look at samples already in the `_posts` directory, you'll see that the top of the page contains stuff between `---`. This is called "frontmatter", which tells the theme how to build the site. This has a few things:

- [required] `layout`: can be `"media", "article" or "default"`. Setting this to `"media"` optimises for a media layout (figures, video etc). `"article"` optimises for text wrapping and should be used for mainly text, `"default"` is just a plain template.
- [optional] `title`: title of the page
- [required] `categories`: set to `"media"` or `"articles"`
- [optional] `excerpt`: description of the page
- [optional] `share`: if `true`, adds "share on ..." buttons at the bottom
- [optional] `image`: has both `teaser` (small image before clicking) and `feature` (big image on top of the page). You can just use the name of the image, this will default to the `images` folder.

This has more optional stuff as well, you can take a look [here](https://mmistakes.github.io/jekyll-theme-skinny-bones/getting-started/#site-setup) (scroll down a bit to "posts") if you're interested.


## How to locally preview the website before pushing
It's a good idea to first render the website locally before you push to the `master` branch, as to avoid committing breaking changes. You will need [Jekyll](https://jekyllrb.com) for this, which uses Ruby. See [this page](https://jekyllrb.com/docs/installation/) for installation instructions and prerequisites. Normally both macOS and Linux should have Ruby distributions by default so you should be good here. If this is not the case for some reason, the instructions are quite straightforward and shouldn't be much work.

Once you have Ruby, install Jekyll through
```
gem install jekyll bundler
```
That's it, now cd into the repository, build and view:
```
cd erc_prominent
bundle exec jekyll serve
```
Open your browser at `http://127.0.0.1:4000` to view the locally built site. You can keep this command running and edit further, as long as you're serving you'll see your changes in real time by refreshing the page.
