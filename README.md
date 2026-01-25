# WatchBase

Everything worth watching, in one place.

## Getting Started

I'm using TMDB Api for the movies database.

To get started, please refer [the api documentation](https://developer.themoviedb.org/docs/getting-started) to get started.

### Using the API key

I'm using compile-time variables to inject the base url and the api key of TMDB API.

If you are using vscode, you can add the below parameters in the `args` property in `.vscode/launch.json` file.

```jsonc
{
  "configurations": [
    {
      // ...
      "args": [
        "--dart-define",
        "TMDB_API_BASE_URL=<PASTE_THE_BASE_URL_HERE>",
        "--dart-define",
        "TMDB_API_KEY=<PASTE_API_KEY_HERE>",
      ],
      // ...
    },
  ],
}
```
