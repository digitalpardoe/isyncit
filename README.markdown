iSyncIt
=======
Simple, scheduled iSync-ing with automatic bluetooth control, all from your menu bar.

[![Project Status: Unsupported - The project has reached a stable, usable state but the author(s) have ceased all work on it. A new maintainer may be desired.](http://www.repostatus.org/badges/latest/unsupported.svg)](http://www.repostatus.org/#unsupported)

A Little History
----------------
**iSyncIt** is a small utility that I started writing in early-2006 to make it quicker to use iSync for
it's primary purpose - syncing my phone with OS X, when a PowerBook became my primary computer
I added functionality to **iSyncIt** to help preserve the battery life of my computer by automatically
controlling the power of bluetooth.

Disclaimer
----------
This was my first piece of OS X software (written before I knew what object-oriented programming
was) and over the past few years I've made some, effort to improve the quality of the code based on
Cocoa & Objetive-C paradigms that I have learnt, my main focus however has been adding features and
making the software as stable as possible.

Useful Bits
-----------
These are some of the more useful classes in the application;

* *DPGrowl* - Very quick & dirty way of producing a Growl alert.
* *DPLoginItem* - Quickly add and remove the application from a user's login items, taken from several sources & not the best way to do it in Snow Leopard (and probably Leopard).
* *ISI_Bluetooth* - Control the bluetooth power & check it's current status.
* *ISI_ChangeLogController* - Loading an RTF file into an NSTextView.
* *All Over The Place* - Running AppleScript from Objective-C.
* *ISI_Scheduling* - Executing periodic events and scheduled events, might be useful but I've never been quite sure if I implemented it correctly.
* *SS_PrefsController* - Not my code, it was created by [Matt Gemmell](http://mattgemmell.com/) and is therefore awesome code.

Past Versions
-------------
Development on **iSyncIt** started before I cared to learn what a version control system was, let alone
even consider using Git. The GitHub repository contains all versioned code dating back to when I
started using SVN (somewhere around version 1.3 of **iSyncIt**) however I kept archives of all the code
at each release, you can download these from the 'downloads' section of the GitHub project page (along
with the compiled binary versions of every release).

Licenses
--------
As I mentioned above, some of the code that makes up this application is not mine. The main piece of
code that comes to mind that isn't mine is *SS_PrefsController* (and associated) by [Matt Gemmell](http://mattgemmell.com/). When
I started developing **iSyncIt** 'licenses' didn't really enter my mind. I have endeavoured to make sure
all the code I used is correctly licensed before this release to open source but I am aware that I may
have forgotten where code originally came from, if you see something that belongs to you please let
me know so I can correct the situation and apply appropriate licenses. I haven't knowingly gone out
of my way to avoid giving people credit where credit is due.

All of my code is licensed under the terms found in the LICENSE file, the license is essentially based
on the BSD new license but breaks down into the following points (and yes, they're a little bit stolen
from Matt Gemmell);

1. You can use the code wherever you wish.
2. You can modify the code as much as you want and use the modified code wherever you wish.
3. You can redistribute the original, unmodified code, but you have to include the full license text.
4. You can redistribute the modified code as you wish (without the full license text).
5. In all cases, you must include an attribution mentioning Alex Pardoe as the original creator of the source.
6. I’m not liable for anything you do with the code, no matter what. So be sensible.
7. You can’t use my name or other marks to promote your products based on the code.

All other code licenses are contained within the files to which they apply.

Legal
-----
I realised several months into development that the name 'iSync' is probably trademarked and all sorts
of copyright of Apple (TM) and obviously, that's the way it'll stay. Unless I receive a much coveted
letter from Apple (TM) legal however, the name **iSyncIt** will remain.

Conclusion
----------
Feel free to fork, improve and reuse all the code contained within this repository. Hopefully, at least
some of the code will be helpful to new developers - perhaps even veteran developers.

If you find any mistakes, problems or want to get your improvements into a release feel free to contact
me using the information below (or through GitHub).

Happy forking!

Website: [http://digitalpardoe.co.uk/](http://digitalpardoe.co.uk/), Twitter: [http://twitter.com/digitalpardoe/](http://twitter.com/digitalpardoe/)
