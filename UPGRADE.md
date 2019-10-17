# Notes on upgrading IRUS

*If your EPrints service is hosted by a 3rd party, please liaise with them regarding the upgrade of the IRUS software.
They may already be aware of this process, or may have other ways to manage this.*

If you have installed IRUS from the EPrints Bazaar, and not edited the configuration files at all, 
the upgrade process should be as simple as clicking an 'Upgrade' button in the EPrints Bazaar.

* Navigate to the Admin screen in EPrints
* From the **System Tools** tab, click on the **EPrints Bazaar** button
* In the **Installed** tab, you should see the current version installed:
  ![Screenshot of Irus-v1.1.0 in EPrints Bazaar](UPGRADE-screenshots/irus-v1.1.0.png)
* In the **Available** tab, you should be able to see the latest version of the IRUS package, with an **Upgrade** button next to it:
  ![Screenshot of Irus-v1.2.1 Upgrade in EPrints Bazaar](UPGRADE-screenshots/irus-v.1.2.1-upgrade.png)
* Clicking the **Upgrade** button should result in a message similar to this:
  ![Screenshot of Irus-v1.2.1 successful upgrade in EPrints Bazaar](UPGRADE-screenshots/irus-v.1.2.1-upgraded.png)<br>
  **You should also restart the indexer at this time** and it would be advisable to restart the webserver.
* If the above process results in a message such as:
  ![Screenshot of Irus-v1.2.1 Upgrade in EPrints Bazaar](UPGRADE-screenshots/irus-v.1.2.1-upgrade-failed.png)<br>
  it means that there have been some alterations to the IRUS code on your server.


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
