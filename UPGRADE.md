# Notes on upgrading IRUS

* Indexer (check for waiting-to-be-sent data)
* If a prevsious version was installed, and e.g. the file `~/lib/cfg.d/pirus.pl` has been changed (new 
tracker URL added), trying to install new version from Bazaar might fail
* 

For a 'clean' re-install:
- Stop Indexer
- Check for Existing Task (make note of ID from params)
  - Make note of accessid (from DB or /cgi/counter?) before starting
- Remove Event/PIRUS.pm; config file ~/lib/cfg.d/pirus.pl; [other files?]
- Check for any other mentions of IRUS in repo config e.g. 
`>grep -ri 'irus' ~/archives/ARCHIVEID/cfg/`
- Remove ~/lib/epm/irus/
- restart Apache
- Visit Admin -> Sys Conf -> Bazaar
- Install v1.2.2

---do something with AccessID..?
