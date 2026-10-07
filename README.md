# SleeveNotes — Home Assistant add-on

A Home Assistant add-on wrapping [SleeveNotes](https://github.com/SiDtheTurtle/SleeveNotes),
a single-page vinyl record tracker with deep Discogs integration, a wishlist,
collection sync, offline PWA support and CSV import/export.

SleeveNotes is a single FastAPI + SQLite app — no database server to manage, so
the add-on is one lightweight container.

- **amd64** and **aarch64**.

## Install

Add this repository to Home Assistant:

```
https://github.com/Thrasher2020/sleevenotes-addon
```

Then install **SleeveNotes** from the Add-on Store and open its web UI
(`http://<your-host>:2026`).

## Setup

There are no add-on configuration options — everything is configured in-app:

1. Open the SleeveNotes UI → **Settings** (gear icon).
2. Under **Discogs**, enter your Discogs username and a
   [Personal Access Token](https://www.discogs.com/settings/developers).
3. Optionally map your Discogs custom fields (retailer, price, P&P, etc.) under
   **Settings → Discogs → Field Mapping**.

## Importing your existing collection

SleeveNotes can sync directly from Discogs:

- **Settings → Discogs → Sync Collection** — fetches your full Discogs
  collection and shows a diff before applying.

Or import a Discogs-format CSV via **Settings → Data → Import from CSV**.

## Persistence

Data lives in the add-on's data volume:

- SQLite database: `/data/sleevenotes.db`
- Cached cover art: `/data/images/`

Both survive restarts and updates.

## Updating SleeveNotes

Change the `SLEEVENOTES_VERSION` build argument in `Dockerfile` (default
`1.11.0`) and rebuild. SleeveNotes stores its schema in SQLite and recreates it
automatically, so upgrades are non-destructive.
