# StoreFrontSystemFiveM

A dynamic in-game marketplace system built for FiveM QBCore servers.  
Players can buy, sell, and browse items through a physical map location with a full UI and server-side item handling.

  Features
- Player-to-player item listings
- Configurable blacklist/whitelist items
- QBCore integration
- Map blip & location-based storefront
- Expandable to multiple zones or black markets
- Supports future NUI frontend (HTML/JS)

  Future Plans
- Auction system
- Seller accounts with history tracking
- Category filtering, search, & sorting
- Phone app integration (gksphone, lb-phone)
- Multiple market zones with region locking

  Framework
- QBCore (Lua-based)
- Optional NUI menu (HTML/CSS/JS) for advanced UI

  File Structure
- `client.lua` – handles menu UI & interaction
- `server.lua` – item storage & transaction logic
- `config.lua` – settings for shop location, blip, restrictions
- `html/` – optional UI frontend (coming soon)

--------------
   License
       MIT License
---------------
