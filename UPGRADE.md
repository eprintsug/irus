# Notes on upgrading IRUS

*If your EPrints service is hosted by a 3rd party, please liaise with them regarding the upgrade of the IRUS software.
They may already be aware of this process, or may have other ways to manage this.*

If you have installed IRUS from the EPrints Bazaar, and not edited the configuration files at all, 
the upgrade process should be as simple as clicking an 'Upgrade' button in the EPrints Bazaar.

If you have modified any of the IRUS files, that automated upgrade via the Bazaar may fail (see below).

* Navigate to the Admin screen in EPrints
* From the **System Tools** tab, click on the **EPrints Bazaar** button
* In the **Installed** tab, you should see the current version installed:
  ![Screenshot of Irus-v1.1.0 in EPrints Bazaar](UPGRADE-screenshots/irus-v1.1.0.png)
* In the **Available** tab, you should be able to see the latest version of the IRUS package, with an **Upgrade** button next to it:
  ![Screenshot of Irus-v1.2.1 Upgrade in EPrints Bazaar](UPGRADE-screenshots/irus-v1.2.1-upgrade.png)
* Clicking the **Upgrade** button should result in a message similar to this:
  ![Screenshot of Irus-v1.2.1 successful upgrade in EPrints Bazaar](UPGRADE-screenshots/irus-v1.2.1-upgraded.png)<br>
  **You should also restart the indexer at this time** and it would be advisable to restart the webserver.
  

## Failure due to edited files

If the above process results in a message such as:
![Screenshot of Irus-v1.2.1 Upgrade in EPrints Bazaar](UPGRADE-screenshots/irus-upgrade-failed.png)<br>
it means that there have been some alterations to the IRUS code on your server. This may have been someone adding the new tracker endpoint, for example. *NB There are ways to achieve this without editing the installed files. If you are in this situation and would like some advice about how to make more sensible changes to your repository configuration, please contact the EPrints Tech List.**

At this point it is probably safer to check on the server itself what has changed (and why). There may have been additional configuration added that will need to be re-implemented during the upgrade.

If you are confident that any changes that have been made to the IRUS install are either covered by the upgrade, or not necessary, you can follow this procedure to upgrade IRUS:
* From the EPrints Bazaar page, open the **Developer Tools** tab.
* Click on 'Edit' next to the IRUS package
![Screenshot edit button in EPrints Bazaar](UPGRADE-screenshots/irus-v1.1.0-edit-package.png)
* Don't edit anything, click **Save and Return**. This will re-calculate the checksums of the IRUS files, and allow you to upgrade as above.
![Screenshot edit button in EPrints Bazaar](UPGRADE-screenshots/irus-save-package.png)



## Other musings - do we need to cover more than the above?

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
