# 1.0.0 (2024-11-13)


### Bug Fixes

* add simple http endpoint ([6c1e62a](https://github.com/davidkelley/tortoise-tts/commit/6c1e62acc12bd4c534c6be9eb1e3310d5529d624))
* docker flow ([ef5e8e2](https://github.com/davidkelley/tortoise-tts/commit/ef5e8e2c52885e4793ba986680f1c77362cc3c65))
* publish latest version using semantic-release ([62b66e7](https://github.com/davidkelley/tortoise-tts/commit/62b66e7aee1227a25a3aa4e34a3e8348c3233cd4))
* remove cache for npm ([38aeba2](https://github.com/davidkelley/tortoise-tts/commit/38aeba228814a90a730a81f43608ebc211be00a0))
* remove missing version of tokenizers ([fac2d9f](https://github.com/davidkelley/tortoise-tts/commit/fac2d9fa0f00d534ff10ae22fba9054745cd9297))


### Features

* updated `Dockerfile` ([be323bd](https://github.com/davidkelley/tortoise-tts/commit/be323bd051a6e5819feb1fa76d9190867f281fe1))

## Changelog
#### v3.0.0; 2023/10/18
- Added fast inference for tortoise with HiFi Decoder (inspired by xtts by [coquiTTS](https://github.com/coqui-ai/TTS) 🐸, check out their multilingual model for noncommercial uses)
#### v2.8.0; 2023/9/13
- Added custom tokenizer for non-english models
#### v2.7.0; 2023/7/26
- Bug fixes
- Added Apple Silicon Support
- Updated Transformer version
#### v2.6.0; 2023/7/26
- Bug fixes

#### v2.5.0; 2023/7/09
- Added kv_cache support 5x faster
- Added deepspeed support 10x faster
- Added half precision support
  
#### v2.4.0; 2022/5/17
- Removed CVVP model. Found that it does not, in fact, make an appreciable difference in the output.
- Add better debugging support; existing tools now spit out debug files which can be used to reproduce bad runs.

#### v2.3.0; 2022/5/12
- New CLVP-large model for further improved decoding guidance.
- Improvements to read.py and do_tts.py (new options)

#### v2.2.0; 2022/5/5
- Added several new voices from the training set.
- Automated redaction. Wrap the text you want to use to prompt the model but not be spoken in brackets.
- Bug fixes

#### v2.1.0; 2022/5/2
- Added ability to produce totally random voices.
- Added ability to download voice conditioning latent via a script, and then use a user-provided conditioning latent.
- Added ability to use your own pretrained models.
- Refactored directory structures.
- Performance improvements & bug fixes.
