# Keywording

A MacOS command line tool for marketing. Based on [iTunes Search API](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/) Keywording allows to estimate the keywords popularity in App Store, by region. A user can specify the keywords and country codes. The tool returns the number of the search results corresponding to each keyword and country. This eventually allows to estimate the keyword **competition** which is an essential part of the keywords optimization. [This post](https://kelindev.blogspot.com/2018/08/appstore-keywords.html) describes the details entire procedure of sorting and choosing keywords for App Store using free tools including Keywording.

## Usage

Keywords could be specified via parameters:

`./keywording \"<comma separated keywords>\" <country code>...`

Example:

```
$ ./keywording "figure,plot,graph" GB US
GB
figure: 161
graph: 190
plot: 191

US
figure: 174
graph: 191
plot: 196
```

Also, you can pass a file containing comma- or newline-separated keywords:

`./keywording -f <file> <country code>...`

Like:

`./keywording -f keywords.txt US GB NZ`

Type

`./keywording countries`

to output the list of local App Stores and their country codes. The up-to-date list can also be found [here](https://affiliate.itunes.apple.com/resources/documentation/linking-to-the-itunes-music-store/) under the Appendix: Country Codes and Storefront IDs table.

## Limitation

Due to API restriction, the maximum number of search result per keyword is **200**.
