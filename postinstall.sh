#!/bin/bash

# Bashscript which is executed by bash *AFTER* complete installation is done
# (but *BEFORE* postupdate). Use with caution and remember, that all systems
# may be different! Better to do this in your own Pluginscript if possible.
#
# Exit code must be 0 if executed successfull.
#
# Will be executed as user "loxberry".
#
# We add 5 arguments when executing the script:
# command <TEMPFOLDER> <NAME> <FOLDER> <VERSION> <BASEFOLDER>
#
# For logging, print to STDOUT. You can use the following tags for showing
# different colorized information during plugin installation:
#
# <OK> This was ok!"
# <INFO> This is just for your information."
# <WARNING> This is a warning!"
# <ERROR> This is an error!"
# <FAIL> This is a fail!"

# To use important variables from command line use the following code:
ARGV0=$0 # Zero argument is shell command
ARGV1=$1 # First argument is temp folder during install
ARGV2=$2 # Second argument is Plugin-Name for scipts etc.
ARGV3=$3 # Third argument is Plugin installation folder
ARGV4=$4 # Forth argument is Plugin version
ARGV5=$5 # Fifth argument is Base folder of LoxBerry

pluginname=$3

# Available Icons 
# Renew with: wget -O - https://configurator.loxone.com/files/translations/IconsFilled/ | grep -io '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//i' -e 's/["'"'"']$//i' | grep 'svg'
icons=(
8-ball.svg
aal-alarm-2.svg
aal-alarm.svg
add-1.svg
add-circle-1.svg
air-conditioner.svg
air-heater.svg
alarm-1.svg
alarm-2.svg
alarm-afci.svg
alarm-clock-settings.svg
alarm-clock.svg
alarm-fire.svg
alarm-ok.svg
alarm-snooze.svg
alarm-stop.svg
alarm-time.svg
alarm-water.svg
arrow-down-1.svg
arrow-down-2.svg
arrow-down-3.svg
arrow-left-1.svg
arrow-left-2.svg
arrow-left-3.svg
arrow-right-1.svg
arrow-right-2.svg
arrow-right-3.svg
arrow-up-1.svg
arrow-up-2.svg
arrow-up-3.svg
attic.svg
automatic-2.svg
automatic.svg
away-mode.svg
awning-extend-2.svg
awning-extend-retract.svg
awning-extend.svg
awning-extended.svg
awning-retract-2.svg
awning-retract.svg
awning-retracted.svg
baby-bed.svg
baby-hanging-toy.svg
baby.svg
balcony-1.svg
balcony-2.svg
balcony-3.svg
balcony-4.svg
ball-badminton.svg
ball-basketball.svg
ball-football.svg
ball-soccer.svg
ball-volleyball.svg
barbecue-stove.svg
barn.svg
barrel-ale.svg
baseball.svg
bathtub.svg
battery-charge-1.svg
battery-charge.svg
battery-full.svg
battery-high.svg
battery-low.svg
battery-medium.svg
beach.svg
bed-double.svg
bed-single.svg
bed-sleep.svg
beer-glass-1.svg
beer-glass-2.svg
bell.svg
bench.svg
bin-1.svg
binders.svg
birthday-cake.svg
blinds-down.svg
blinds-half-closed.svg
blinds-opened.svg
blinds-shading-2.svg
blinds-up-down.svg
blinds-up.svg
bluetooth.svg
bottle-3.svg
bottle-4.svg
bowling.svg
brightness-decrease.svg
brightness-increase.svg
bubble-chat.svg
burger.svg
bus-2.svg
button-switch-on-off.svg
cactus.svg
camera-pause.svg
camera-play.svg
camera-previous.svg
camera-record.svg
camera-rewind.svg
camera-stop.svg
camera-tripod.svg
camper-trailer.svg
car-gate.svg
car-key.svg
car-park.svg
car.svg
cc-camera.svg
ceiling-lights.svg
cellar.svg
celsius.svg
central.svg
chair-1.svg
chair-2.svg
chair-6.svg
chair-office.svg
chairs-umbrella.svg
chandeliers.svg
check-circle-2.svg
chef-hat.svg
christmas-tree.svg
circle.svg
circulation-pump.svg
clock-3.svg
clock.svg
close-2.svg
close.svg
cloth-hanger-towel.svg
clothes-hanger.svg
cocktail.svg
coconut-juice.svg
coffee-bean-jar.svg
coffee-cup-2.svg
coffee-mug-1.svg
coffee-mug-2.svg
cog-double.svg
cog.svg
computer-chip-fire.svg
computer-chip-flash.svg
computer-imac-1.svg
computer-notebook.svg
computer-screen-2.svg
computer.svg
control-next.svg
control-pause.svg
control-play-pause.svg
control-play.svg
control-previous.svg
control-stop.svg
cooker-hood.svg
crate-trolley-1.svg
curtain-close-1.svg
curtain-close-2.svg
curtain-close-3.svg
curtain-closed.svg
curtain-open-1.svg
curtain-open-2.svg
curtain-open-3.svg
curtain-opened-1.svg
curtain-opened-2.svg
curtain-opened-3.svg
cycling-energy.svg
day-cloud.svg
deep-sleep-mode.svg
delete-1.svg
delete-2.svg
disable-sign.svg
dog-house.svg
door-enter.svg
door-exit.svg
door-lock.svg
door-open.svg
door-sign.svg
drawer-2.svg
drawer-3.svg
dress.svg
drop.svg
dumbbell-2.svg
dumbbell.svg
eco-car-charge.svg
eco-energy-1.svg
eco-energy-2.svg
eco-lightbulb.svg
eject-button.svg
electric-car.svg
electric-fan.svg
electric-pole.svg
electricity-outlet-1.svg
electricity-outlet-2.svg
electricity-outlet-3.svg
electricity-outlet-4.svg
electricity-outlet-5.svg
elevator-2.svg
email.svg
emergency-alarm.svg
espresso-machine-2.svg
fahrenheit.svg
fan-1.svg
fast-forward-button.svg
finger-tapping.svg
fire-extinguisher.svg
fireplace.svg
fitness-center.svg
flame-2.svg
flame.svg
flash-1.svg
flash-2.svg
flood.svg
florida-room.svg
flower-2.svg
flower.svg
folding-door-left-close.svg
folding-door-left-closed.svg
folding-door-left-open-close.svg
folding-door-left-open.svg
folding-door-left-opened.svg
folding-door-right-close.svg
folding-door-right-closed.svg
folding-door-right-open-close.svg
folding-door-right-open.svg
folding-door-right-opened.svg
food-dome-serving-2.svg
food-trolley.svg
forest-1.svg
forest-2.svg
forklift.svg
french-press.svg
frying-machine.svg
game-controller-3.svg
gameboy.svg
garage-close.svg
garage-closed.svg
garage-open-close.svg
garage-open.svg
garage-opened.svg
garage.svg
gas-burner.svg
gate-closed-1.svg
gate-closed-2.svg
gate-closed-3.svg
gate-open-1.svg
gate-open-2.svg
gate-open-3.svg
gauge.svg
glass-water.svg
globe-2.svg
globe-3.svg
graph-bar-2.svg
graph-line-3.svg
grill.svg
hair-dryer.svg
hallway.svg
hand-bag-2.svg
hanging-lamp-1.svg
hanging-lamp-2.svg
hanging-lamp-3.svg
heat-pump.svg
home-3.svg
home-4.svg
home-5.svg
home-fire-1.svg
home-hurricane.svg
honeycomb.svg
hourglass.svg
house-add.svg
house-block.svg
house-check.svg
house-information.svg
house-key.svg
house-location-pin.svg
house-present.svg
house-remove.svg
house-setting.svg
house-subtract.svg
house-warning.svg
humidity.svg
hurricane.svg
information-circle.svg
iron.svg
key-2.svg
keys.svg
knife-fork.svg
lamp-2.svg
lamp-3.svg
lamp-4.svg
lamp-5.svg
lamp-cabinet.svg
lamp-lava.svg
lamp-table.svg
letter-blocks.svg
lightbulb-1.svg
lightbulb-2.svg
lightbulb-3.svg
location-barn.svg
location-pin-add-2.svg
location-pin-favorite-2.svg
location-pin-globe-2.svg
location-pin-remove-2.svg
location-pin-subtract-2.svg
location-pin-unknown-2.svg
location-pin-user-2.svg
location-pin.svg
lock-close-1.svg
lock-door.svg
lock-open-1.svg
lock-open-2.svg
lockers.svg
login-key.svg
login.svg
luggage-carrier.svg
mailbox-1.svg
mailbox-3.svg
martial-art-robe.svg
meeting.svg
megaphone.svg
meter.svg
mixing-machine.svg
mode-1.svg
mode-2.svg
monitor.svg
moonrise.svg
moonset.svg
motorbike-1.svg
music-note-2.svg
music-note.svg
navigation-drawer.svg
next-button.svg
night-mode.svg
no-alarm-1.svg
no-alarm-2.svg
no-bell.svg
no-fan-1.svg
no-shield.svg
onnoff-circle.svg
onnoff.svg
open-2.svg
open.svg
oven.svg
park-sign.svg
park.svg
party-hat.svg
party-mode.svg
pause-button.svg
person-1.svg
person-2.svg
pet-cat.svg
pet-dog-walk.svg
pet-goldfish.svg
phone-4.svg
phone-hang-up.svg
phone-pick-up.svg
phone-signal-full.svg
phone-signal-high.svg
phone-signal-low.svg
phone-signal-medium.svg
phone-signal-none.svg
phone-signal-very-low.svg
photocopy-machine.svg
pie.svg
pingpong.svg
plant.svg
play-button-2.svg
play-pause-button.svg
playlist-3.svg
playlist-4.svg
plug-1.svg
pool-2.svg.svg
pool-cover-close.svg
pool-cover-open-close.svg
pool-cover-open.svg
pool-round-cover-close.svg
pool-round-cover-open-close.svg
pool-round-cover-open.svg
pool-round.svg
pool.svg
porch.svg
power-grid.svg
presence.svg
presentation-screen.svg
previous-button.svg
print-text.svg
projector-front.svg
projector-screen.svg
projector.svg
radiator.svg
rank-army-star-badge-2.svg
reception-table-2.svg
recharge-energy.svg
record-button.svg
refresh.svg
refrigerator.svg
remote-television.svg
remove-circle-1.svg
report-problem-circle.svg
report-problem-diamond.svg
report-problem-triangle.svg
restore.svg
rewind-button.svg
rock.svg
sauna-oven.svg
sauna.svg
server-3.svg
server-refresh-1.svg
server-remove-1.svg
server-setting-1.svg
server-timeout-1.svg
server-warning-1.svg
server.svg
settings-3.svg
shading.svg
shield-2.svg
shield-afci.svg
shield-cancel-2.svg
shield-cancel.svg
shield-cross.svg
shield-fire.svg
shield-frost.svg
shield-ok-2.svg
shield-ok.svg
shield-storm.svg
shield-time.svg
shield-water.svg
shield.svg
shirt-folded.svg
shirt.svg
shoe-1.svg
shoe-2.svg
shower-1.svg
shower-2.svg
sign-spa-2.svg
sign-toilet-1.svg
sign-toilet-2.svg
singing-vocal.svg
skylight-1.svg
snowflake.svg
sofa-1.svg
sofa-2.svg
sofa-3.svg
solar-panel.svg
sound-equalizer.svg
spa-vapor.svg
speakers-1.svg
speakers-4.svg
speakers.svg
speech-stand-2.svg
speech-stand.svg
spray-bottle.svg
sprinkler.svg
staircase-down-1.svg
staircase-down-2.svg
staircase-up-1.svg
staircase-up-2.svg
stairwell-1.svg
stairwell-2.svg
star.svg
stop-button.svg
storage-empty.svg
storage-full.svg
store.svg
stove.svg
substract-1.svg
subtract-circle-1.svg
suit.svg
sun-bath.svg
sun.svg
sunrise-sunset.svg
sunrise.svg
sunset.svg
swtich-down.svg
swtich-up.svg
t-shirt.svg
tank-top.svg
tap-single.svg
teddy-bear.svg
television-stand.svg
temperature-decrease.svg
temperature-increase-decrease.svg
temperature-increase.svg
thermometer-cold.svg
thermometer-hot.svg
thermometer-negative.svg
thermometer-positive.svg
thermometer.svg
thunderstorm.svg
tickmark.svg
timer-2.svg
timer.svg
tissue.svg
toggle.svg
toilet-seat.svg
toilet-sink.svg
toilet.svg
toolbox.svg
tools-box.svg
tools-driller.svg
tools-gardening.svg
tools-wood-saw.svg
transfer-circle.svg
transmission-tower-1.svg
tree-big-3.svg
tree-big-4.svg
tree.svg
trigger.svg
truck-2.svg
turntable.svg
tv-screen-1.svg
tv-screen-2.svg
tv-screen-3.svg
umbrella-open.svg
undershirt.svg
vacuum-cleaner.svg
valve-actuator-1.svg
valve-actuator-2.svg
vespa.svg
video-camera.svg
video-clip.svg
video-meeting-group.svg
video-meeting-laptop.svg
volume-down.svg
volume-max.svg
volume-min.svg
volume-mute.svg
volume-up.svg
wall-plant.svg
washing-machine.svg
water-drop.svg
water-drops.svg
water-faucet-1.svg
water-faucet-2.svg
water-hose-2.svg
water-hose.svg
water-level-down.svg
water-level-up.svg
weather-cock.svg
whiskey.svg
wifi-modem-2.svg
wifi-modem-3.svg
wind-fan.svg
wind-turbine.svg
windbag.svg
window-1.svg
window-2.svg
window-3.svg
window-4.svg
window-code-2.svg
window-code-3.svg
window-state-closed.svg
window-state-open-1.svg
window-state-open-2.svg
wine-bottle-glass-sparkling.svg
wine-bucket-sparkling.svg
wine-sparkling-cheers.svg
wrench-screwdriver.svg
wrench.svg
)

folder=(
$LBPDATA/$pluginname/loxone_icons/svg/filled
$LBPDATA/$pluginname/loxone_icons/svg/outlined
$LBPDATA/$pluginname/loxone_icons/png/filled
$LBPDATA/$pluginname/loxone_icons/png/outlined
)

# Create folders
rm -r $LBPDATA/$pluginname/loxone_icons
for i in "${folder[@]}"; do   # The quotes are necessary here
	mkdir -p $i
done

# Download SVG icons
echo "<INFO> Downloading Icons from Loxone Website..."
for i in "${icons[@]}"; do   # The quotes are necessary here
	if [ ! -e "$LBPDATA/$pluginname/icons/svg/filled/$i" ]; then
		echo "<INFO> Downloading $i..."
		wget https://configurator.loxone.com/files/translations/IconsFilled/$i -P $LBPDATA/$pluginname/loxone_icons/svg/filled/
	fi
	if [ ! -e "$LBPDATA/$pluginname/icons/svg/outlined/$i" ]; then
		echo "<INFO> Downloading $i..."
		wget https://configurator.loxone.com/files/translations/Icons/$i -P $LBPDATA/$pluginname/loxone_icons/svg/outlined/
	fi
done

# Create PNG icons
echo "<INFO> Converting all downloaded icons from SVG to PNG..."
for i in "${icons[@]}"; do   # The quotes are necessary here
	echo "<INFO> Converting $i to PNG..."
	basename=$(basename $i .svg)
	if [ -e "$LBPDATA/$pluginname/loxone_icons/svg/filled/$i" ]; then
		cat $LBPDATA/$pluginname/loxone_icons/svg/filled/$i | sed -E 's/<path/<path fill="#FFFFFF"/g' | rsvg-convert -f png -w 96 -h 96 /dev/stdin > $LBPDATA/$pluginname/loxone_icons/png/filled/$basename.png
	fi
	if [ -e "$LBPDATA/$pluginname/loxone_icons/svg/outlined/$i" ]; then
		cat $LBPDATA/$pluginname/loxone_icons/svg/outlined/$i | sed -E 's/black/white/g' | rsvg-convert -f png -w 96 -h 96 /dev/stdin > $LBPDATA/$pluginname/loxone_icons/png/outlined/$basename.png
	fi
done

# Create Zip Archiv
echo "<INFO> Creating a ZIP archive of all icons for downloading..."
cd $LBPDATA/$pluginname
7z a loxone_icons.zip loxone_icons
mv loxone_icons.zip loxone_icons

echo "<INFO> Installing loxicon from https://github.com/strobejb/loxicon/..."
cd $LBPBIN/$pluginname
git clone https://github.com/strobejb/loxicon/
if [ -e "$LBPBIN/$pluginname/loxicon/loxicon.py" ]; then
    echo "<OK> Installation of loxicon script successfull."
else
    echo "<WARNING> Installation of loxicon script failed. The plugin will not work without."
    echo "<WARNING> Giving up."
    exit 2
fi

echo "<INFO> Configuring elFinder..."
rm $LBPHTMLAUTH/$pluginname/files
ln -s $LBPDATA/$pluginname $LBPHTMLAUTH/$pluginname/files

# Exit with Status 0
exit 0
