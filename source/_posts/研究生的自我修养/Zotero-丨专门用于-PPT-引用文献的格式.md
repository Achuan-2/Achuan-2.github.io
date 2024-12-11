---
title: Zotero丨专门用于PPT引用文献的格式
date: '2024-12-11 11:33:55'
updated: '2024-12-11 16:47:04'
categories:
  - 研究生的自我修养
permalink: /post/zotero-gun-format-for-ppt-reference-literature-1usphn.html
comments: true
toc: true
---



PPT引用文献我之前都是手动写，如果用其他格式，一般嫌弃有些信息没必要，只需要保留第一作者、文献名、年份、标题、DOI等。

最近忍无可忍，于是让GPT给我写了几个专门用于PPT引用文献的csl，这样zotero复制引用格式就可以直接用了。

ps：本来想让GPT再给我写一个csl，支持显示第一作者和通讯作者，但是没写出来，暂时放弃。

​![PixPin_2024-12-11_12-41-13](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-11_12-41-13-20241211124116-upvpx6p.png)​

## Csl

### PPT Ref 有title 有DOI 无通讯作者

​![PixPin_2024-12-11_12-36-53](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-11_12-36-53-20241211123655-eaalq1m.png)​

```xml
<?xml version="1.0" encoding="utf-8"?>
<style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0" demote-non-dropping-particle="never" page-range-format="expanded">
  <info>
    <title>PPT Ref 有title 有DOI 无通讯作者</title>
    <title-short>PPT Ref 有title 有DOI 无通讯作者</title-short>
    <id>Achuan-2/ppt_references_csl_doi_title</id>
    <author>
      <name>Achuan-2</name>
      <email>achuan-2@outlook.com</email>
    </author>
    <category citation-format="author-date"/>
    <category field="generic-base"/>
    <updated>2024-12-11T09:00:00+08:00</updated>
    <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
  </info>

  <locale xml:lang="en">
    <terms>
      <term name="et-al">et al.</term>
    </terms>
  </locale>

  <macro name="author">
    <names variable="author">
      <name form="long" and="text"  initialize="false"  initialize-with="" delimiter=", " et-al-min="2" et-al-use-first="1"/>
      <substitute>
        <names variable="editor"/>
        <text variable="title"/>
      </substitute>
    </names>
  </macro>

  <macro name="year">
    <date variable="issued">
      <date-part name="year"/>
    </date>
  </macro>

  <macro name="journal">
    <text variable="container-title" form="short"/>
  </macro>

  <macro name="doi">
    <choose>
      <if variable="DOI">
        <text variable="DOI" prefix="https://doi.org/"/>
      </if>
    </choose>
  </macro>

  <citation et-al-min="2" et-al-use-first="1" disambiguate-add-year-suffix="true">
    <sort>
      <key macro="author"/>
      <key macro="year"/>
    </sort>
    <layout prefix="(" suffix=")" delimiter=", ">
      <text macro="author"/>
      <text macro="year" prefix=", "/>
    </layout>
  </citation>

  <bibliography>
    <sort>
      <key macro="author"/>
      <key macro="year"/>
      <key variable="title"/>
    </sort>
    <layout>
      <group delimiter=" ">
        <text macro="author"/>
        <group delimiter="">
          <text macro="journal"/>
          <text macro="year" prefix=", "/>
          <text variable="title" prefix=". "/>
          <text macro="doi" prefix=". "/>
        </group>
      </group>
    </layout>
  </bibliography>
</style>

```

### PPT Ref 无title 有DOI 无通讯作者​​

​![PixPin_2024-12-11_15-18-33](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-11_15-18-33-20241211151835-hpsuges.png)​

```xml
<?xml version="1.0" encoding="utf-8"?>
<style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0" demote-non-dropping-particle="never" page-range-format="expanded">
  <info>
    <title>PPT Ref 无title 有DOI 无通讯作者</title>
    <title-short>PPT Ref 无title 有DOI 无通讯作者</title-short>
    <id>Achuan-2/ppt_references_csl_doi</id>
    <author>
      <name>Achuan-2</name>
      <email>achuan-2@outlook.com</email>
    </author>
    <category citation-format="author-date"/>
    <category field="generic-base"/>
    <updated>2024-12-11T09:00:00+08:00</updated>
    <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
  </info>

  <locale xml:lang="en">
    <terms>
      <term name="et-al">et al.</term>
    </terms>
  </locale>

  <macro name="author">
    <names variable="author">
      <name form="long" and="text"  initialize="false"  initialize-with="" delimiter=", " et-al-min="2" et-al-use-first="1"/>
      <substitute>
        <names variable="editor"/>
        <text variable="title"/>
      </substitute>
    </names>
  </macro>

  <macro name="year">
    <date variable="issued">
      <date-part name="year"/>
    </date>
  </macro>

  <macro name="journal">
    <text variable="container-title" form="short"/>
  </macro>

  <macro name="doi">
    <choose>
      <if variable="DOI">
        <text variable="DOI" prefix="https://doi.org/"/>
      </if>
    </choose>
  </macro>

  <citation et-al-min="2" et-al-use-first="1" disambiguate-add-year-suffix="true">
    <sort>
      <key macro="author"/>
      <key macro="year"/>
    </sort>
    <layout prefix="(" suffix=")" delimiter=", ">
      <text macro="author"/>
      <text macro="year" prefix=", "/>
    </layout>
  </citation>

  <bibliography>
    <sort>
      <key macro="author"/>
      <key macro="year"/>
      <key variable="title"/>
    </sort>
    <layout>
      <group delimiter=" ">
        <text macro="author"/>
        <group delimiter="">
          <text macro="journal"/>
          <text macro="year" prefix=", "/>
          <text macro="doi" prefix=". "/>
        </group>
      </group>
    </layout>
  </bibliography>
</style>

```

### PPT Ref 有title 无DOI 无通讯作者

​![PixPin_2024-12-11_15-18-23](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-11_15-18-23-20241211151825-zqxxjry.png)​

```xml
<?xml version="1.0" encoding="utf-8"?>
<style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0" demote-non-dropping-particle="never" page-range-format="expanded">
  <info>
    <title>PPT Ref 有title 无DOI 无通讯作者 </title>
    <title-short>PPT Ref 有title 无DOI 无通讯作者</title-short>
    <id>Achuan-2/ppt_references_csl_title</id>
    <author>
      <name>Achuan-2</name>
      <email>achuan-2@outlook.com</email>
    </author>
    <category citation-format="author-date"/>
    <category field="generic-base"/>
    <updated>2024-12-11T09:00:00+08:00</updated>
    <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
  </info>

  <locale xml:lang="en">
    <terms>
      <term name="et-al">et al.</term>
    </terms>
  </locale>

  <macro name="author">
    <names variable="author">
      <name form="long" and="text"  initialize="false" initialize-with="" delimiter=", " et-al-min="2" et-al-use-first="1"/>
      <substitute>
        <names variable="editor"/>
        <text variable="title"/>
      </substitute>
    </names>
  </macro>

  <macro name="year">
    <date variable="issued">
      <date-part name="year"/>
    </date>
  </macro>

  <macro name="journal">
    <text variable="container-title" form="short"/>
  </macro>

  <citation et-al-min="2" et-al-use-first="1" disambiguate-add-year-suffix="true">
    <sort>
      <key macro="author"/>
      <key macro="year"/>
    </sort>
    <layout prefix="(" suffix=")" delimiter=", ">
      <text macro="author"/>
      <text macro="year" prefix=", "/>
    </layout>
  </citation>

  <bibliography>
    <sort>
      <key macro="author"/>
      <key macro="year"/>
      <key variable="title"/>
    </sort>
    <layout suffix=".">
      <group delimiter=" ">
        <text macro="author"/>
        <group delimiter="">
          <text macro="journal"/>
          <text macro="year" prefix=", "/>
        </group>
      </group>
      <text variable="title" prefix=". " suffix="."/>
    </layout>
  </bibliography>
</style>

```

### PPT Ref 无title 无DOI 无通讯作者

​![PixPin_2024-12-11_12-26-04](https://fastly.jsdelivr.net/gh/Achuan-2/PicBed@pic/assets/PixPin_2024-12-11_12-26-04-20241211122606-4bkwnkn.png)​

```xml
<?xml version="1.0" encoding="utf-8"?>
<style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0" demote-non-dropping-particle="never" page-range-format="expanded">
  <info>
    <title>PPT Ref 无title 无DOI 无通讯作者 </title>
    <title-short>PPT Ref 无title 无DOI 无通讯作者</title-short>
    <id>Achuan-2/ppt_references_csl</id>
    <author>
      <name>Achuan-2</name>
      <email>achuan-2@outlook.com</email>
    </author>
    <category citation-format="author-date"/>
    <category field="generic-base"/>
    <updated>2024-12-11T09:00:00+08:00</updated>
    <rights license="http://creativecommons.org/licenses/by-sa/3.0/">This work is licensed under a Creative Commons Attribution-ShareAlike 3.0 License</rights>
  </info>

  <locale xml:lang="en">
    <terms>
      <term name="et-al">et al.</term>
    </terms>
  </locale>

  <macro name="author">
    <names variable="author">
      <name form="long" and="text" initialize="false" initialize-with="" delimiter=", " et-al-min="2" et-al-use-first="1"/>
      <substitute>
        <names variable="editor"/>
        <text variable="title"/>
      </substitute>
    </names>
  </macro>

  <macro name="year">
    <date variable="issued">
      <date-part name="year"/>
    </date>
  </macro>

  <macro name="journal">
    <text variable="container-title" form="short"/>
  </macro>

  <citation et-al-min="2" et-al-use-first="1" disambiguate-add-year-suffix="true">
    <sort>
      <key macro="author"/>
      <key macro="year"/>
    </sort>
    <layout prefix="(" suffix=")" delimiter=", ">
      <text macro="author"/>
      <text macro="year" prefix=", "/>
    </layout>
  </citation>

  <bibliography>
    <sort>
      <key macro="author"/>
      <key macro="year"/>
      <key variable="title"/>
    </sort>
    <layout suffix=".">
      <group delimiter=" ">
        <text macro="author"/>
        <group delimiter="">
          <text macro="journal"/>
          <text macro="year" prefix=", "/>
        </group>
      </group>
    </layout>
  </bibliography>
</style>

```
