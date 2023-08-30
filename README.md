# PokemonX - Flutter App with all platforms.

### Installation

```
git clone https://github.com/devSumanrazz/PokemonX.git

flutter pub get

flutter run
```
### Packages Used

[Flutter Riverpod](https://pub.dev/packages/flutter_riverpod): For State Management.

[DIO](https://pub.dev/packages/dio): For handling http requests.

[Cached Network Image](https://pub.dev/packages/cached_network_image): For caching network image display.

[Google Fonts](https://pub.dev/packages/google_fonts): For displaying custom google fonts.

[Get Storage](https://pub.dev/packages/get_storage): For handling http response for local caching.


### Features
- Local Caching enabled with Get Storage(Currently 1 Hour)
- Search Pokemon  
## Open API

<img src="https://user-images.githubusercontent.com/24237865/83422649-d1b1d980-a464-11ea-8c91-a24fdf89cd6b.png" align="right" width="21%"/>

Pokedex using the [PokeAPI](https://pokeapi.co/) for constructing RESTful API.<br>
PokeAPI provides a RESTful API interface to highly detailed objects built from thousands of lines of data related to Pokémon.

PokeAPI is not directly accessed but proxied through a server created with [Dart Frog](https://dartfrog.vgv.dev/): For handling http response for local caching. and hosted in Google Cloud Run.

### Flutter-Web Demo
https://sumanrajpathak.com.np/web-demo/