# <img valign='top' src="https://what3words.com/assets/images/w3w_square_red.png" width="64" height="64" alt="what3words">&nbsp;Voice API


# Overview

The what3words Swift API wrapper enables the conversion of a spoken 3 word address in audio to a list of three word address suggestions.

# Authentication

To use this library, you’ll need a what3words API key, which can be obtained [here](https://what3words.com/select-plan). If you wish to use Voice API calls, add a Voice API plan to your [account](https://accounts.what3words.com/billing).


# Example

An iOS UIKit example using the Voice API is provided in this package: [./Examples/VoiceAPI/VoiceAPI.xcodeproj](./Examples/VoiceAPI/VoiceAPI.xcodeproj)

# Installation

The Voice API wrapper is included in what3words' [Swift API Wrapper](https://github.com/what3words/w3w-swift-wrapper) code.  Installation instructions can be found in its [README](README.md).

## Usage

### Import

In any Swift file where you use the what3words API, import:

```swift
import W3WSwiftApi
```

### Initialise

Initialize the W3W API class:

```swift
let api = What3WordsV3(apiKey: "YourApiKey")
```

##### Example
This example instantiates a `W3WMicrophone` which provides an audio stream to `autosuggest(audio:)` and begins recording when `autosuggest` is called.

```swift
// instantiate the API
let api = What3WordsV3(apiKey: "YourApiKey")

// make a microphone
let microphone = W3WMicrophone()

// call autosuggest
api.autosuggest(audio: microphone, language: "en") { suggestions, error in
  for suggestion in suggestions ?? [] {
    print(suggestion.words ?? "no suggestions")
  }
}
```


The `W3WMicrophone` class uses the device's microphone and provides an audio stream to `autosuggest(audio:)`, which will automatically call `microphone.start()` when passed W3WMicrophone instance.

### Options

The same options as in the core API calls are available for Voice API calls, detailed in the [API documentation](https://developer.what3words.com/public-api/docs#autosuggest).

##### Example

Focus results around specific coordinates.

```swift
// coords
let coords = CLLocationCoordinate2D(latitude: 51.4243877, longitude: -0.34745)

// make options
let options = W3WOptions().focus(coords)

// call autosuggest
api.autosuggest(audio: microphone, language: "en", options: options) { suggestions, error in
  for suggestion in suggestions ?? [] {
    print(suggestion.words ?? "no suggestions", suggestion.nearestPlace ?? "")
  }
}
```


#### Languages

Retrieve the list of currently supported languages with `availableVoiceLanguages(completion:)`:

```Swift
api.availableVoiceLanguages() { languages, error in
  for language in languages ?? [] {
    print(language.code, language.name, language.nativeName)
  }
}

```

#### User Feedback

The `W3WMicrophone` class includes a volumeUpdate closure, which is called intermittently to provide audio amplitude data, useful for visual feedback.

```Swift
public var volumeUpdate: (Double) -> ()
```

This is called with a value between 0 and 1 indicating relative volume.  For example you might have something like the following in your code:

```Swift
microphone?.volumeUpdate = { volume in 
  yourViewController.updateMicrophoneView(volume: volume)
}
```

### Using Custom Audio Data

For custom audio data sources (e.g., streaming audio or bespoke devices), use `W3WAudioStream` and pass it to `autosuggest(audio: W3WAudioStream)`. Send data via `add(samples:)`, ending with `endSamples()` when done.

##### Example:

```Swift
// instantiate the API
let api = What3WordsV3(apiKey: "YourApiKey")

// make the audio stream
let audio = W3WAudioStream(sampleRate: 44100, encoding: .pcm_f32le)

// call autosuggest
api.autosuggest(audio: audio, language: "en") { suggestions, error in
  yourSoundObject.stop()
  for suggestion in suggestions ?? [] {
    print(suggestion.words ?? "no suggestions")
  }
}

// start sending audio data to autosuggest via the audio stream
while (yourSoundObject.isProducingAudio() {
    audio.add(samples: yourSoundObject.getNextSampleSet())
}
audio.endSamples()

```

### Alternative Approach

The Voice API is implemented as an extension of `What3WordsV3`, adding an additional `autosuggest(audio:)` function. This allows separation of the Voice API code from the main API functions if needed.

If only the Voice API is required, instantiate `W3WVoiceApi` directly:
```swift
let voiceApi = W3WVoiceApi(apiKey: "YourApiKey")
```

The two functions are the same: `autosuggest(audio:completion:)` and `availableVoiceLanguages(completion:)`.
