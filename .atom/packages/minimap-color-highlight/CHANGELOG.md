<a name="v3.1.0"></a>
# v3.1.0 (2015-01-05)

## :sparkles: Features

- Implement debounced decoration update ([7ac98258](https://github.com/abe33/minimap-color-highlight/commit/7ac982585c639ee055cce2c152f215d8868430b6))
- Implement temporary support for both minimap v3 and v4 ([b4097808](https://github.com/abe33/minimap-color-highlight/commit/b4097808a38f7fc963ba564bf9c3136a34e655b6))

<a name="v3.0.5"></a>
# v3.0.5 (2015-01-05)

## :bug: Bug Fixes

- Fix broken refresh when markers array is null ([1fab6c41](https://github.com/abe33/minimap-color-highlight/commit/1fab6c41d204062a30dadacde0dbe309cc48a9b0))

<a name="v3.0.4"></a>
# v3.0.4 (2015-01-03)

## :bug: Bug Fixes

- Fix binding for atom-color-highlight v3 ([6a6a309c](https://github.com/abe33/minimap-color-highlight/commit/6a6a309cac72b99474bc9ab27b471f86af03e4ad))

<a name="v3.0.3"></a>
# v3.0.3 (2014-10-22)

## :bug: Bug Fixes

- Add description in package.json

<a name="v3.0.2"></a>
# v3.0.2 (2014-10-22)

## :bug: Bug Fixes

- Fix broken access to scope in latest Atom ([f0dbddfe](https://github.com/abe33/minimap-color-highlight/commit/f0dbddfe86502041a4263b2374fa7611406b8f6e))

<a name="v3.0.1"></a>
# v3.0.1 (2014-10-14)

## :bug: Bug Fixes

- Fix access to removed private method ([5c970609](https://github.com/abe33/minimap-color-highlight/commit/5c970609036d41713bf03d084a10494e206828f7))
- Prevent an exception when trying to destroy an already destroyed view ([ed35276e](https://github.com/abe33/minimap-color-highlight/commit/ed35276e9ed86dd7afcd4d593d1940ee2bc3df6f))

<a name="v3.0.0"></a>
# v3.0.0 (2014-09-19)

## :sparkles: Features

- Add version test for minimap v3 ([99601c7a](https://github.com/abe33/minimap-color-highlight/commit/99601c7aef0305ebeb9ae1c21ca48afc665fe6a9))
- Add proper handling of atom-color-highlight filter options ([5bd5e230](https://github.com/abe33/minimap-color-highlight/commit/5bd5e2303cb464ad4b5684e5a5dbb0961cc2e0aa))
- Implement support for minimap decoration API ([c6435595](https://github.com/abe33/minimap-color-highlight/commit/c643559596fe335ba8c6740e8b6bb094c7356654))

## :bug: Bug Fixes

- Fix deprecated minimap methods calls ([833ea7d3](https://github.com/abe33/minimap-color-highlight/commit/833ea7d372b6542da31b36f32d7d66ff3e9ae816))
- Fix deprecated methods call ([35f23e19](https://github.com/abe33/minimap-color-highlight/commit/35f23e1907ff502e5ef6534248dbef4bf4ee2364))
- Fix broken activation/deactivation with more than one view ([7b6e48b5](https://github.com/abe33/minimap-color-highlight/commit/7b6e48b5c13d69ce29e7cf3616be8207c50149a6))

## :racehorse: Performances

- Avoid recreating all the decorations on markers update ([88dc039d](https://github.com/abe33/minimap-color-highlight/commit/88dc039dc813c32be4b35f33c319624f1a2ce1ee))

<a name="v1.0.0"></a>
# v1.0.0 (2014-08-16)

## :sparkles: Features

- Add patched methods for dot markers ([eb7d4d99](https://github.com/abe33/minimap-color-highlight/commit/eb7d4d99e691229f9437f303bcfc07f392e29616))
- Implement support for the minimap char position API ([8801ba8c](https://github.com/abe33/minimap-color-highlight/commit/8801ba8c6e0cba722a5d2136c588e7bba52bc384))

## :bug: Bug Fixes

- Fix missing markers patching when attaching the view ([33b3229b](https://github.com/abe33/minimap-color-highlight/commit/33b3229b922279efa1b690a438447e2cd150c184))
- Fix dot marker size and vertical placement ([48deff0c](https://github.com/abe33/minimap-color-highlight/commit/48deff0cd477faf8333a9f91ff5fa1a560f07c08))


<a name="v0.3.7"></a>
# v0.3.7 (2014-07-30)

## :bug: Bug Fixes

- Fix multiple view added to the minimap. ([ac329969](https://github.com/abe33/minimap-color-highlight/commit/ac329969927806de39e67ddfd6f0fc9543598eb2))

<a name="v0.3.6"></a>
# v0.3.6 (2014-07-29)

## :bug: Bug Fixes

- Fix highlights not attached again on active item change ([8f3b3202](https://github.com/abe33/minimap-color-highlight/commit/8f3b3202bac77109cd93a970caf326a1f461b75a))

<a name="v0.3.4"></a>
# v0.3.4 (2014-07-21)

## :bug: Bug Fixes

- Fix missing highlights when minimap is created after highlights view ([1d459167](https://github.com/abe33/minimap-color-highlight/commit/1d459167863c0e0c0ea42fe6d47b7cc1ee8cbfb0))

<a name="v0.3.3"></a>
# v0.3.3 (2014-07-10)

## :bug: Bug Fixes

- Fix bad test for model existence ([911c6fff](https://github.com/abe33/minimap-color-highlight/commit/911c6fff038664ae1ac1ed663c48834876a36cc0))

<a name="0.3.2"></a>
# 0.3.2 (2014-07-10)

## :bug: Bug Fixes

- Fix error when accessing model after closing a tab ([bb905dd6](https://github.com/abe33/minimap-color-highlight/commit/bb905dd6f864bdc64c5d4f0f79fb58f1f039a00b))

<a name="v0.3.1"></a>
# v0.3.1 (2014-07-07)

## :bug: Bug Fixes

- Fix error raised on tab close due to missing editor ([a2772b64](https://github.com/abe33/minimap-color-highlight/commit/a2772b64ddf8c4494ff0c72e8c8f732be0e5a028))

<a name="v0.3.0"></a>
# v0.3.0 (2014-07-07)

- Prepares compatibility with the upcoming react support in minimap ([77e856ea](https://github.com/abe33/minimap-color-highlight/commit/77e856ea9d8b7cbcc048508585351e0c00de1782))

<a name="v0.1.0"></a>
# v0.1.0 (2014-04-08)

## :sparkles: Features

- Adds isActive plugin method ([d005b747](https://github.com/abe33/minimap-color-highlight/commit/d005b747fed9ede1537e705e1f0df6e75494a673))
- Adds screenshot in README ([411bd7b7](https://github.com/abe33/minimap-color-highlight/commit/411bd7b7a9628a6e4882bcff5d920705ee8168cb))
- Implements first display of colors in minimap ([be8b77ba](https://github.com/abe33/minimap-color-highlight/commit/be8b77baa93d1df1ae48867459b7324e9e032cf8))

## :bug: Bug Fixes

- Fix scale issue ([30a46581](https://github.com/abe33/minimap-color-highlight/commit/30a46581806b7bd63b85ecf468aab67c2ca70dfb))
- Fixes bugs on pane split with minimap active ([ba734ecc](https://github.com/abe33/minimap-color-highlight/commit/ba734ecc9f509a7c7270a420b21f8549d78678d2))
