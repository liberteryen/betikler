
#!/system/bin/sh
# pm uninstall --user 0 com.android.contacts
# pm uninstall --user 0 com.android.dialer
# pm uninstall --user 0 com.android.messaging
PACKAGES="
com.mediatek.duraspeed
com.android.vending
com.google.android.dialer
com.generalmobile.app.musicplayer
com.generalmobile.app.gmfilemanager
com.generalmobile.assistant
com.google.android.projection.gearhead
com.google.android.gms.location.history
com.google.android.contacts
com.google.android.feedback
com.google.mainline.telemetry
com.google.android.apps.restore
com.google.android.apps.wellbeing
com.google.android.googlequicksearchbox
com.android.fmradio
com.android.chrome
com.google.android.apps.docs
com.google.android.syncadapters.contacts
com.google.android.apps.tachyon
com.google.android.apps.nbu.files
com.generalmobile.gmservice
com.google.android.gm
com.google.android.keep
com.google.android.videos
com.google.android.apps.youtube.music
com.google.android.apps.googleassistant
com.google.android.calendar
com.google.android.setupwizard
com.google.android.partnersetup
com.android.chrome
com.google.android.gm
com.google.android.apps.maps
com.google.android.youtube
com.google.android.apps.docs
com.google.android.apps.photos
com.google.android.music
com.google.android.videos
com.google.android.apps.tachyon
com.google.android.keep
com.google.android.apps.magazines
com.google.android.apps.googleassistant
com.google.android.calendar
com.google.android.apps.translate
com.google.ar.lens
com.google.android.apps.fitness
com.google.android.apps.authenticator2
com.google.android.apps.podcasts
com.google.android.apps.subscriptions.red
com.google.android.apps.classroom
com.google.android.apps.meetings
com.google.earth
com.google.android.apps.books
com.google.android.play.games
com.google.android.apps.walletnfcrel
com.google.android.street
com.google.android.apps.access.wifi.consumer
com.google.android.apps.chromecast.app
com.google.android.videos
com.google.android.wearable.app
com.google.android.apps.vega
com.google.android.apps.primer
com.google.android.apps.ads.publisher
com.google.android.apps.giant
com.google.android.apps.adwords
com.google.android.apps.shopping.express
com.google.android.apps.travel.onthego
com.google.vr.expeditions
com.google.android.apps.cultural
com.google.android.apps.kids.familylink
com.google.android.apps.paidtasks
com.google.android.apps.safetyhub
com.google.android.apps.enterprise.dmagent
com.google.android.apps.enterprise.cpanel
com.google.android.apps.cloudconsole
com.google.enterprise.cloudsearch
com.google.android.apps.jam
com.google.android.apps.googlevoice
com.google.android.contacts
com.google.android.apps.messaging
com.google.android.apps.recorder
com.google.android.apps.tasks
com.google.android.apps.wallpaper
com.google.android.calculator
com.google.android.deskclock
com.google.android.apps.nbu.files
com.google.android.gms
com.google.android.gsf
com.google.android.gsf.login
com.google.android.setupwizard
com.google.android.syncadapters.contacts
com.google.android.onetimeinitializer
com.google.android.apps.wellbeing
com.google.android.googlequicksearchbox
com.android.fmradio
com.android.chrome
com.google.android.apps.docs
com.google.android.syncadapters.contacts
com.google.android.apps.tachyon
com.google.android.apps.nbu.files
com.generalmobile.gmservice
com.google.android.gm
com.google.android.keep
com.google.android.videos
com.google.android.apps.youtube.music
com.google.android.apps.googleassistant
com.google.android.calendar
com.google.android.setupwizard
com.google.android.partnersetup
"

for pkg in $PACKAGES; do
    pm clear $pkg
    pm uninstall --user 0 $pkg
    echo "Removed: $pkg"
done

echo "All specified packages have been removed."

