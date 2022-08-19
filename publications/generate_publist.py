import os
import re
import shutil
from pathlib import Path
from tempfile import mkstemp

import requests
from bs4 import BeautifulSoup


def parse_href_links(item):
    parsed = BeautifulSoup(item, "html.parser")

    parsed_links = []
    for link in parsed.find_all("a"):
        name = link.text
        if "full paper" in name.lower():
            name = "Full paper"
        if "new light on solar flares" in name.lower():
            name = "Newsflash"
        if "legolas" in name.lower():
            name = "Website"
        if "arxiv" in name.lower():
            name = "ArXiv"
        if "lirias" in name.lower():
            name = "Lirias"
        try:
            url = link["href"]
            parsed_links.append({"name": name, "url": url})
        except KeyError:
            pass
    return parsed_links


def generate_publication_list(content):
    # extract papers from html content, these are list items
    start_tag = "<LI>"
    end_tag = "</LI>"
    nb_items = content.count(start_tag)
    items = []
    for i in range(nb_items):
        # start <LI> tag
        idx0 = content.find(start_tag) + len(start_tag)
        # end </LI> tag
        idx_end_tag = content.find(end_tag)
        idx_next_start_tag = content.find(start_tag, idx0)
        # handle cases where </LI> is missing, `find` returns -1 if not found
        if idx_next_start_tag < idx_end_tag and idx_next_start_tag != -1:
            idx1 = idx_next_start_tag
            extra_space = 0
        else:
            idx1 = idx_end_tag
            extra_space = len(end_tag)
        selected_item = content[idx0:idx1]
        content = content[idx1 + extra_space :]
        # only consider prominent-related papers
        if "PROMINENT" in selected_item:
            items.append(selected_item)

    publist = []
    for item in items:
        pub_dict = {}
        # replace unnecessary substrings
        item = (
            item.replace("[ERC PROMINENT]", "").replace("<P>", "").replace("&amp", "&")
        )
        # extract title
        title = re.search("`(.+?)'", item).group(1)
        pub_dict["title"] = title
        item = item[item.find("',") + 2 :].strip()

        # extract author info + journal
        info = item[: item.find("<A")].strip()
        # introduce markdown boldface syntax
        info = info.replace("<B>", "**").replace("</B>", "**")
        if info.endswith(","):
            info = info[:-1]
        pub_dict["info"] = info
        item = item[item.find("<A") :].strip()

        # parse remaining href links
        pub_dict["links"] = parse_href_links(item)
        publist.append(pub_dict)
    return publist


def generate_publications_page(publist):
    indexfile = (Path(__file__).parent / "index.md").resolve()
    filehandle, abspath = mkstemp()
    with os.fdopen(filehandle, "w") as new_file:
        with open(indexfile) as original_file:
            for line in original_file:
                new_file.write(line)
                if "do not edit" in line.lower():
                    new_file.write("\n")
                    new_file.write("| Reference | Links |\n")
                    new_file.write("|:--------- |:----- |\n")
                    break
            for item in publist:
                table_line = "".join(
                    [
                        "| ",
                        f"_{item['title']}_, {item['info']}",
                        " | ",
                    ]
                )
                new_file.write(table_line)
                for link in item["links"]:
                    new_file.write(f"[{link['name']}]({link['url']}) ")
                new_file.write(" | \n")
    # copy file permissions
    shutil.copymode(indexfile, abspath)
    # remove old file
    os.remove(indexfile)
    # save new file
    shutil.move(abspath, indexfile)


def main():
    # retrieve website content and decode to string
    content = requests.get(
        "https://perswww.kuleuven.be/~u0016541/Pub.html"
    ).content.decode("UTF-8")
    # starting from 2018 there are no prominent papers, find and cut
    idx_cut = content.find('<A NAME="Pub2018.html">')
    publist = generate_publication_list(content[:idx_cut])
    generate_publications_page(publist)


if __name__ == "__main__":
    main()
