#!/bin/sh

function alias_routine {

SYN_TRG_PATH="`dirname ~/Desktop`/Music"

if [ -d "$SYN_TRG_PATH" ]; then
  return 0
fi

R_PATH=""

# Run the AppleScript to decode the alias.
if [ -f "$SYN_TRG_PATH" -a ! -L "$SYN_TRG_PATH" ]; then
R_PATH=`osascript << EOF
  tell application "Finder"
    set theItem to (POSIX file "$SYN_TRG_PATH") as alias
      get the POSIX path of ((original item of theItem) as text)
  end tell
EOF`
fi

if [ ! -z "$R_PATH" ] && [ -d "$R_PATH" ]; then
  echo "$R_PATH"
  return 1
fi

return 0

}

#czytamy zawartosc aliasu
R_PATH=`alias_routine`

if [ $? -eq 1 ]; then
  SYN_TRG_PATH="$R_PATH/Synapse Audio"
  SYN_TRG_PATH_PR="$R_PATH/.com.audiounit.SynapseAudio.Legend"
else
  SYN_TRG_PATH="$HOME/Music/Synapse Audio"
  SYN_TRG_PATH_PR="$HOME/Music/.com.audiounit.SynapseAudio.Legend"
fi

SYN_TRG_PLUGIN_PATH="$SYN_TRG_PATH/Legend"

# v2 - nowe katalogi

R_NEW_PATH_SYNAPSE="/Library/Application Support/Synapse Audio"
R_NEW_PLUGIN_PATH="$R_NEW_PATH_SYNAPSE/Legend"
R_NEW_SOUNDBANKS_PATH="$R_NEW_PLUGIN_PATH/Soundbanks"
R_NEW_FACTORY_PATH="$R_NEW_SOUNDBANKS_PATH/Legend Factory"

# utworzmy sobie katalogi i nadamy prawa

mkdir -p "$SYN_TRG_PATH/" >> /dev/null 2>&1
chown "$USER" "$SYN_TRG_PATH/" >> /dev/null 2>&1
chmod 755 "$SYN_TRG_PATH/" >> /dev/null 2>&1

mkdir -p "$R_NEW_PATH_SYNAPSE/" >> /dev/null 2>&1
chown "$USER" "$R_NEW_PATH_SYNAPSE/" >> /dev/null 2>&1
chmod 755 "$R_NEW_PATH_SYNAPSE/" >> /dev/null 2>&1

mkdir -p "$R_NEW_PLUGIN_PATH/" >> /dev/null 2>&1
chown "$USER" "$R_NEW_PLUGIN_PATH/" >> /dev/null 2>&1
chmod 755 "$R_NEW_PLUGIN_PATH/" >> /dev/null 2>&1

# tworzenie linka

if [ ! -L "$SYN_TRG_PLUGIN_PATH" ]; then
  ln -s "$R_NEW_PLUGIN_PATH/" "$SYN_TRG_PLUGIN_PATH" >> /dev/null 2>&1
fi

# sprawdzenie katalogów nowego Factory do przeniesienia

if [ ! -d "$R_NEW_FACTORY_PATH" ]; then

  # ok, katalog nie istnieje, to zaczynamy przeniesienie

  mkdir -p "$R_NEW_FACTORY_PATH/" >> /dev/null 2>&1
  chown "$USER" "$R_NEW_FACTORY_PATH/" >> /dev/null 2>&1
  chmod 755 "$R_NEW_FACTORY_PATH/" >> /dev/null 2>&1

  mkdir -p "$R_NEW_FACTORY_PATH/Bass/" >> /dev/null 2>&1
  mkdir -p "$R_NEW_FACTORY_PATH/Chords/" >> /dev/null 2>&1
  mkdir -p "$R_NEW_FACTORY_PATH/Init Patch/" >> /dev/null 2>&1
  mkdir -p "$R_NEW_FACTORY_PATH/Lead/" >> /dev/null 2>&1
  mkdir -p "$R_NEW_FACTORY_PATH/Poly/" >> /dev/null 2>&1
  mkdir -p "$R_NEW_FACTORY_PATH/SFX/" >> /dev/null 2>&1
  mkdir -p "$R_NEW_FACTORY_PATH/Vintage/" >> /dev/null 2>&1
  
  # powtórka
  chown "$USER" "$R_NEW_FACTORY_PATH/" >> /dev/null 2>&1
  chmod 755 "$R_NEW_FACTORY_PATH/" >> /dev/null 2>&1
  
  # przeniesienie plików
  
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Ambos KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Ambos KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Avalanche KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Avalanche KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Bass Carpet RH.fxp" "$R_NEW_FACTORY_PATH/Bass/Bass Carpet RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Bass Drone DG.fxp" "$R_NEW_FACTORY_PATH/Bass/Bass Drone DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Bassline 303 KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Bassline 303 KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Berlin Bass DG.fxp" "$R_NEW_FACTORY_PATH/Bass/Berlin Bass DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Big Puncher TK.fxp" "$R_NEW_FACTORY_PATH/Bass/Big Puncher TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Bob Vocal KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Bob Vocal KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Boogie Bass EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Boogie Bass EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Bootsy Bass DG.fxp" "$R_NEW_FACTORY_PATH/Bass/Bootsy Bass DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Cooking EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Cooking EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Cynical EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Cynical EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Direct Start KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Direct Start KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Dry Punch RH.fxp" "$R_NEW_FACTORY_PATH/Bass/Dry Punch RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Eclectic EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Eclectic EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/EDM Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/EDM Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Electro Bass EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Electro Bass EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Electro Copter KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Electro Copter KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Fast Bass DG.fxp" "$R_NEW_FACTORY_PATH/Bass/Fast Bass DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Fat Bottom TK.fxp" "$R_NEW_FACTORY_PATH/Bass/Fat Bottom TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Feedback Bass DG.fxp" "$R_NEW_FACTORY_PATH/Bass/Feedback Bass DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Flap Bass DG.fxp" "$R_NEW_FACTORY_PATH/Bass/Flap Bass DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/FM Puncher BT.fxp" "$R_NEW_FACTORY_PATH/Bass/FM Puncher BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Fretless EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Fretless EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Goom Bass TK.fxp" "$R_NEW_FACTORY_PATH/Bass/Goom Bass TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Granite Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Granite Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Growl Bass DG.fxp" "$R_NEW_FACTORY_PATH/Bass/Growl Bass DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/High Pass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/High Pass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Imagination Bass EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Imagination Bass EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/In Sync KS.fxp" "$R_NEW_FACTORY_PATH/Bass/In Sync KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Japan is Big EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Japan is Big EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Knock Bass DG.fxp" "$R_NEW_FACTORY_PATH/Bass/Knock Bass DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Knock Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Knock Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Left Jab XS.fxp" "$R_NEW_FACTORY_PATH/Bass/Left Jab XS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Legacy EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Legacy EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/LFO Bass RH.fxp" "$R_NEW_FACTORY_PATH/Bass/LFO Bass RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Massive Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Massive Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Monkey Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Monkey Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Monster Voltage KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Monster Voltage KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Monument Bass EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Monument Bass EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Movie Stomps KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Movie Stomps KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/New House EX.fxp" "$R_NEW_FACTORY_PATH/Bass/New House EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Noise Bass EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Noise Bass EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/One Shot Wobble KS.fxp" "$R_NEW_FACTORY_PATH/Bass/One Shot Wobble KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Overdrive Bass DG.fxp" "$R_NEW_FACTORY_PATH/Bass/Overdrive Bass DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Peak Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Peak Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/PhotoBass DG.fxp" "$R_NEW_FACTORY_PATH/Bass/PhotoBass DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Pike Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Pike Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Polymath EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Polymath EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Predator KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Predator KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Pulse Bass EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Pulse Bass EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Quads RH.fxp" "$R_NEW_FACTORY_PATH/Bass/Quads RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Reso Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Reso Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Retro 70s KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Retro 70s KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Robots EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Robots EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Santanic Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Santanic Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Schnappi Bass IW.fxp" "$R_NEW_FACTORY_PATH/Bass/Schnappi Bass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Seventh Gate RH.fxp" "$R_NEW_FACTORY_PATH/Bass/Seventh Gate RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Shriller EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Shriller EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Skwekee Bass TK.fxp" "$R_NEW_FACTORY_PATH/Bass/Skwekee Bass TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Smooth Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Smooth Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Smooth Fingers EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Smooth Fingers EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Speaking Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Speaking Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Spicy Cajun EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Spicy Cajun EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Spring Dragon KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Spring Dragon KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Square EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Square EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Squatting EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Squatting EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Stabby Perker EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Stabby Perker EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Step Back KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Step Back KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Sub Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Sub Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Tangerines EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Tangerines EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/The Lord KS.fxp" "$R_NEW_FACTORY_PATH/Bass/The Lord KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/The Robots KS.fxp" "$R_NEW_FACTORY_PATH/Bass/The Robots KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/The Sound EX.fxp" "$R_NEW_FACTORY_PATH/Bass/The Sound EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Throat Bass TK.fxp" "$R_NEW_FACTORY_PATH/Bass/Throat Bass TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/To Hell KS.fxp" "$R_NEW_FACTORY_PATH/Bass/To Hell KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Trance Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Trance Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Trap Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Trap Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Triple Saw EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Triple Saw EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Tubby Electro KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Tubby Electro KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Undercover KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Undercover KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Unimog RH.fxp" "$R_NEW_FACTORY_PATH/Bass/Unimog RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Venga Bass KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Venga Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Wide Bass EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Wide Bass EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Wobble X KS.fxp" "$R_NEW_FACTORY_PATH/Bass/Wobble X KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Bass/Working Bull EX.fxp" "$R_NEW_FACTORY_PATH/Bass/Working Bull EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Analog Soul RH.fxp" "$R_NEW_FACTORY_PATH/Chords/Analog Soul RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Brassy ST.fxp" "$R_NEW_FACTORY_PATH/Chords/Brassy ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Buster Chords KS.fxp" "$R_NEW_FACTORY_PATH/Chords/Buster Chords KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Cinema Chords KS.fxp" "$R_NEW_FACTORY_PATH/Chords/Cinema Chords KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Cult Chord KS.fxp" "$R_NEW_FACTORY_PATH/Chords/Cult Chord KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Detroit KS.fxp" "$R_NEW_FACTORY_PATH/Chords/Detroit KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Dirty Major RH.fxp" "$R_NEW_FACTORY_PATH/Chords/Dirty Major RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Festival Chord KS.fxp" "$R_NEW_FACTORY_PATH/Chords/Festival Chord KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Fifths Lead TK.fxp" "$R_NEW_FACTORY_PATH/Chords/Fifths Lead TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Fifths Poly IW.fxp" "$R_NEW_FACTORY_PATH/Chords/Fifths Poly IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Grand Illusion IW.fxp" "$R_NEW_FACTORY_PATH/Chords/Grand Illusion IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Harbor RH.fxp" "$R_NEW_FACTORY_PATH/Chords/Harbor RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/High Freeze KS.fxp" "$R_NEW_FACTORY_PATH/Chords/High Freeze KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/James Chord KS.fxp" "$R_NEW_FACTORY_PATH/Chords/James Chord KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Kord Stab ST.fxp" "$R_NEW_FACTORY_PATH/Chords/Kord Stab ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Latina Pike KS.fxp" "$R_NEW_FACTORY_PATH/Chords/Latina Pike KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Love Parade KS.fxp" "$R_NEW_FACTORY_PATH/Chords/Love Parade KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Major Rise RH.fxp" "$R_NEW_FACTORY_PATH/Chords/Major Rise RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Membrane KS.fxp" "$R_NEW_FACTORY_PATH/Chords/Membrane KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Minor Glide RH.fxp" "$R_NEW_FACTORY_PATH/Chords/Minor Glide RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Santa Chord KS.fxp" "$R_NEW_FACTORY_PATH/Chords/Santa Chord KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Slow Starter ST.fxp" "$R_NEW_FACTORY_PATH/Chords/Slow Starter ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Sunny Day ST.fxp" "$R_NEW_FACTORY_PATH/Chords/Sunny Day ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Tech Stab DG.fxp" "$R_NEW_FACTORY_PATH/Chords/Tech Stab DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/The Abyss TK.fxp" "$R_NEW_FACTORY_PATH/Chords/The Abyss TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Chords/Unison Fifths RH.fxp" "$R_NEW_FACTORY_PATH/Chords/Unison Fifths RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Init Patch/Init Patch FX.fxp" "$R_NEW_FACTORY_PATH/Init Patch/Init Patch FX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Init Patch/Init Patch.fxp" "$R_NEW_FACTORY_PATH/Init Patch/Init Patch.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Acid Lead RH.fxp" "$R_NEW_FACTORY_PATH/Lead/Acid Lead RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Adagio KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Adagio KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Allstars KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Allstars KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Antiphone KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Antiphone KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Antonov KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Antonov KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Armin Lead DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Armin Lead DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Avalanche KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Avalanche KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Avatar Chimes KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Avatar Chimes KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Back to the Past KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Back to the Past KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Beating Saws EX.fxp" "$R_NEW_FACTORY_PATH/Lead/Beating Saws EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Brainstorm KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Brainstorm KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Brassic MH.fxp" "$R_NEW_FACTORY_PATH/Lead/Brassic MH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Candied Bacon XS.fxp" "$R_NEW_FACTORY_PATH/Lead/Candied Bacon XS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Code Red KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Code Red KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Commander KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Commander KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Daft Drunk KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Daft Drunk KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Daft Funk KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Daft Funk KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Dance Buzzer KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Dance Buzzer KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Devil Brass KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Devil Brass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Dirty Lead RH.fxp" "$R_NEW_FACTORY_PATH/Lead/Dirty Lead RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Driven Epic EX.fxp" "$R_NEW_FACTORY_PATH/Lead/Driven Epic EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/EDM Lead DG.fxp" "$R_NEW_FACTORY_PATH/Lead/EDM Lead DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/EDM Pluck KS.fxp" "$R_NEW_FACTORY_PATH/Lead/EDM Pluck KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/EDM Saxo KS.fxp" "$R_NEW_FACTORY_PATH/Lead/EDM Saxo KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Electro Lead RH.fxp" "$R_NEW_FACTORY_PATH/Lead/Electro Lead RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Euro Spike KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Euro Spike KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Fake Feedback KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Fake Feedback KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Fake Guitar DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Fake Guitar DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Fat Filter Mod Lead IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Fat Filter Mod Lead IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Fat Squares Lead IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Fat Squares Lead IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Fat Uni Brass IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Fat Uni Brass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Filter Drops EX.fxp" "$R_NEW_FACTORY_PATH/Lead/Filter Drops EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Florence KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Florence KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Flute of Analog KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Flute of Analog KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/FM Dream KS.fxp" "$R_NEW_FACTORY_PATH/Lead/FM Dream KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/French KS.fxp" "$R_NEW_FACTORY_PATH/Lead/French KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Funky Dance KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Funky Dance KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Fusion Pass KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Fusion Pass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Gamer TK.fxp" "$R_NEW_FACTORY_PATH/Lead/Gamer TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Gated Filter DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Gated Filter DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Gold Virus KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Gold Virus KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Goodbye Lover ST.fxp" "$R_NEW_FACTORY_PATH/Lead/Goodbye Lover ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Goomy IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Goomy IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Green Signal KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Green Signal KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Hacker KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Hacker KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Hard Sawtooth KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Hard Sawtooth KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Hardstyle Typ KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Hardstyle Typ KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Heavy Guitar DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Heavy Guitar DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/High Sky IW.fxp" "$R_NEW_FACTORY_PATH/Lead/High Sky IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Hyper Saws IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Hyper Saws IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Infinity KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Infinity KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Japan Pike KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Japan Pike KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Jazz Trombone DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Jazz Trombone DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Jozef KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Jozef KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Juno Space Harp DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Juno Space Harp DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Kit Lead DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Kit Lead DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Laser Harp KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Laser Harp KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Logos-ish Lead IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Logos-ish Lead IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Long Fade RH.fxp" "$R_NEW_FACTORY_PATH/Lead/Long Fade RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Lucky Lead IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Lucky Lead IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Mainstream KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Mainstream KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Modern Organ KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Modern Organ KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Modular FM KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Modular FM KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Monotony KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Monotony KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Mystic Cello KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Mystic Cello KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Odyssey KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Odyssey KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Old Theremin KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Old Theremin KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Orange KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Orange KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Organ Love KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Organ Love KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Oxygene DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Oxygene DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Peaches And Cream XS.fxp" "$R_NEW_FACTORY_PATH/Lead/Peaches And Cream XS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Pigment Pluck KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Pigment Pluck KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Plasma Cutter EX.fxp" "$R_NEW_FACTORY_PATH/Lead/Plasma Cutter EX.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Please Arp Me TK.fxp" "$R_NEW_FACTORY_PATH/Lead/Please Arp Me TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Pluck Luck ST.fxp" "$R_NEW_FACTORY_PATH/Lead/Pluck Luck ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Pluck The Day ST.fxp" "$R_NEW_FACTORY_PATH/Lead/Pluck The Day ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Polar KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Polar KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Pop Brass KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Pop Brass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Pulstar TK.fxp" "$R_NEW_FACTORY_PATH/Lead/Pulstar TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Racer KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Racer KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Radioactive Vox IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Radioactive Vox IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Rainbow KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Rainbow KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Reso Point KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Reso Point KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Resonator TK.fxp" "$R_NEW_FACTORY_PATH/Lead/Resonator TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Retro Crush KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Retro Crush KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Reverse Break KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Reverse Break KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Rezzy Uni Lead IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Rezzy Uni Lead IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Saigon DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Saigon DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Saraus Rex KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Saraus Rex KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Saturated Phat XS.fxp" "$R_NEW_FACTORY_PATH/Lead/Saturated Phat XS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Self-Osc Sine Ld IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Self-Osc Sine Ld IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Seven Days RH.fxp" "$R_NEW_FACTORY_PATH/Lead/Seven Days RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Shanghai KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Shanghai KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Small Acid KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Small Acid KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Spartacus KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Spartacus KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Speedy Keys KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Speedy Keys KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Spring KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Spring KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Spring Pike KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Spring Pike KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Square Glider Ld IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Square Glider Ld IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Squarez Lead TK.fxp" "$R_NEW_FACTORY_PATH/Lead/Squarez Lead TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Sun Flyer KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Sun Flyer KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Super Vox KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Super Vox KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Sweetness TK.fxp" "$R_NEW_FACTORY_PATH/Lead/Sweetness TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Synth Cello RH.fxp" "$R_NEW_FACTORY_PATH/Lead/Synth Cello RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Taiwan KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Taiwan KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Tatra KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Tatra KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Theremin DG.fxp" "$R_NEW_FACTORY_PATH/Lead/Theremin DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Three Partial Triangles IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Three Partial Triangles IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/ToraTora DG.fxp" "$R_NEW_FACTORY_PATH/Lead/ToraTora DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Trance Legend KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Trance Legend KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Trance Square KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Trance Square KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Tricky Saw RH.fxp" "$R_NEW_FACTORY_PATH/Lead/Tricky Saw RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Trumpet IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Trumpet IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Tube Box KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Tube Box KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Tude Lead TK.fxp" "$R_NEW_FACTORY_PATH/Lead/Tude Lead TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Tuna Perc ST.fxp" "$R_NEW_FACTORY_PATH/Lead/Tuna Perc ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Twelve Saws Lead IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Twelve Saws Lead IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Uni Horn IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Uni Horn IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Uni Lead TK.fxp" "$R_NEW_FACTORY_PATH/Lead/Uni Lead TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Unison PWM MH.fxp" "$R_NEW_FACTORY_PATH/Lead/Unison PWM MH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Unity RH+KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Unity RH+KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Vinyl KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Vinyl KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Violin RH.fxp" "$R_NEW_FACTORY_PATH/Lead/Violin RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Voice Classics KS.fxp" "$R_NEW_FACTORY_PATH/Lead/Voice Classics KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Zappy Uni Ld IW.fxp" "$R_NEW_FACTORY_PATH/Lead/Zappy Uni Ld IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Lead/Zero Pluck TK.fxp" "$R_NEW_FACTORY_PATH/Lead/Zero Pluck TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Bellic Echo Pad IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Bellic Echo Pad IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/BP Strings IW.fxp" "$R_NEW_FACTORY_PATH/Poly/BP Strings IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Brassy Glider IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Brassy Glider IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Cesar Strings KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Cesar Strings KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Christmas KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Christmas KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Cinematic Strings KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Cinematic Strings KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Classic Poly TK.fxp" "$R_NEW_FACTORY_PATH/Poly/Classic Poly TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Cold Gate KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Cold Gate KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/CS-80 Brass IW.fxp" "$R_NEW_FACTORY_PATH/Poly/CS-80 Brass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Dark Pad DG.fxp" "$R_NEW_FACTORY_PATH/Poly/Dark Pad DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Dramatic Strings KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Dramatic Strings KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Dream Pad RH.fxp" "$R_NEW_FACTORY_PATH/Poly/Dream Pad RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Eighties Synth TK.fxp" "$R_NEW_FACTORY_PATH/Poly/Eighties Synth TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Eternal Silence KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Eternal Silence KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Fall Dreams KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Fall Dreams KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Fat Poly Brass IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Fat Poly Brass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Fifths Rez Brass IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Fifths Rez Brass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Filter Rise TK.fxp" "$R_NEW_FACTORY_PATH/Poly/Filter Rise TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Forgotten Organ KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Forgotten Organ KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Four Strings TK.fxp" "$R_NEW_FACTORY_PATH/Poly/Four Strings TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Gated Pad RH.fxp" "$R_NEW_FACTORY_PATH/Poly/Gated Pad RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Glass Pad KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Glass Pad KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Hammond KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Hammond KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Home Organ KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Home Organ KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Icy Wasteland XS.fxp" "$R_NEW_FACTORY_PATH/Poly/Icy Wasteland XS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Interstellar KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Interstellar KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/JP Super Pad KS.fxp" "$R_NEW_FACTORY_PATH/Poly/JP Super Pad KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Juno Celesta DG.fxp" "$R_NEW_FACTORY_PATH/Poly/Juno Celesta DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Justanutha TK.fxp" "$R_NEW_FACTORY_PATH/Poly/Justanutha TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Legend-ary Brass IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Legend-ary Brass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Memory Brass IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Memory Brass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Modern Harpsichord ST.fxp" "$R_NEW_FACTORY_PATH/Poly/Modern Harpsichord ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Movie Pad TK.fxp" "$R_NEW_FACTORY_PATH/Poly/Movie Pad TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Music Box KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Music Box KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Night Witches KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Night Witches KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/No People KS.fxp" "$R_NEW_FACTORY_PATH/Poly/No People KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/OB Ensemble IW.fxp" "$R_NEW_FACTORY_PATH/Poly/OB Ensemble IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Oberish Synth TK.fxp" "$R_NEW_FACTORY_PATH/Poly/Oberish Synth TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Orbit Pad KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Orbit Pad KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/P5 Mildbrass IW.fxp" "$R_NEW_FACTORY_PATH/Poly/P5 Mildbrass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Pizzicato Dream XS.fxp" "$R_NEW_FACTORY_PATH/Poly/Pizzicato Dream XS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Poly Brass RH.fxp" "$R_NEW_FACTORY_PATH/Poly/Poly Brass RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Poly Eight KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Poly Eight KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Poly Gate KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Poly Gate KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Poly Strings ST.fxp" "$R_NEW_FACTORY_PATH/Poly/Poly Strings ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Pulse-ar IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Pulse-ar IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Radiation KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Radiation KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Rainbow Colors KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Rainbow Colors KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Rest in Peace KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Rest in Peace KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Rezzy Brass IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Rezzy Brass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Rezzy Mod Brass IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Rezzy Mod Brass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Rise & Fall Rez Pad IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Rise & Fall Rez Pad IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Rising Pad TK.fxp" "$R_NEW_FACTORY_PATH/Poly/Rising Pad TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Romantic Piano KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Romantic Piano KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Sharky ST.fxp" "$R_NEW_FACTORY_PATH/Poly/Sharky ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Shimmer TK.fxp" "$R_NEW_FACTORY_PATH/Poly/Shimmer TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Slightly Horny IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Slightly Horny IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Slow CS-like Brass IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Slow CS-like Brass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Soft Pad RH.fxp" "$R_NEW_FACTORY_PATH/Poly/Soft Pad RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Spaceball KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Spaceball KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Squelchy Pulse RH.fxp" "$R_NEW_FACTORY_PATH/Poly/Squelchy Pulse RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/String Ensemble IW.fxp" "$R_NEW_FACTORY_PATH/Poly/String Ensemble IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Sweeper IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Sweeper IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Sweet Pan RH.fxp" "$R_NEW_FACTORY_PATH/Poly/Sweet Pan RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Syn Strings DG.fxp" "$R_NEW_FACTORY_PATH/Poly/Syn Strings DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Synth Clavinet RH.fxp" "$R_NEW_FACTORY_PATH/Poly/Synth Clavinet RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/The Game KS.fxp" "$R_NEW_FACTORY_PATH/Poly/The Game KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Thematic Gate KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Thematic Gate KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Three Osc Saw Strings IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Three Osc Saw Strings IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Tremolo EP IW.fxp" "$R_NEW_FACTORY_PATH/Poly/Tremolo EP IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Universe KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Universe KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Poly/Vibra Lead KS.fxp" "$R_NEW_FACTORY_PATH/Poly/Vibra Lead KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Aborigine KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Aborigine KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/African Drum KS.fxp" "$R_NEW_FACTORY_PATH/SFX/African Drum KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Airwolf KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Airwolf KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Alien Talk KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Alien Talk KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Anomaly KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Anomaly KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Black Roll KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Black Roll KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/C64 Plus KS.fxp" "$R_NEW_FACTORY_PATH/SFX/C64 Plus KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Cine Hit KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Cine Hit KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Clap KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Clap KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Closed Hat DG.fxp" "$R_NEW_FACTORY_PATH/SFX/Closed Hat DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Copter DG.fxp" "$R_NEW_FACTORY_PATH/SFX/Copter DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Dancefloor Kick KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Dancefloor Kick KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Dark Atmosphere KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Dark Atmosphere KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Dark Cine Chords KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Dark Cine Chords KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Dark Impact KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Dark Impact KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Dark Inflator KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Dark Inflator KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Dark Tom KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Dark Tom KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Death Metal Voice IW.fxp" "$R_NEW_FACTORY_PATH/SFX/Death Metal Voice IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Drops MH.fxp" "$R_NEW_FACTORY_PATH/SFX/Drops MH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Electro Drum KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Electro Drum KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Electro Kick KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Electro Kick KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/EMS Beam KS.fxp" "$R_NEW_FACTORY_PATH/SFX/EMS Beam KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Free Fall KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Free Fall KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Gamma Shot KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Gamma Shot KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Haunted House KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Haunted House KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Hell Pass KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Hell Pass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/High Resolution KS.fxp" "$R_NEW_FACTORY_PATH/SFX/High Resolution KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Hihat ST.fxp" "$R_NEW_FACTORY_PATH/SFX/Hihat ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Holy Crash KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Holy Crash KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Horror KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Horror KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Ignition KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Ignition KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Input KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Input KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Invaders DG.fxp" "$R_NEW_FACTORY_PATH/SFX/Invaders DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/KeyFollowNoise DG.fxp" "$R_NEW_FACTORY_PATH/SFX/KeyFollowNoise DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Kick 60 Hz DG.fxp" "$R_NEW_FACTORY_PATH/SFX/Kick 60 Hz DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Kick Down KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Kick Down KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Kick Drum KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Kick Drum KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Kraftwerk Hit KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Kraftwerk Hit KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Kraftwerk Shot KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Kraftwerk Shot KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Landing KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Landing KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Laser Shot KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Laser Shot KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Master Sweep KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Master Sweep KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Minipops KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Minipops KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Mono Wind KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Mono Wind KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Movie FX KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Movie FX KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Noise Downlifter KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Noise Downlifter KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Paranormal KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Paranormal KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Perc Hit DG.fxp" "$R_NEW_FACTORY_PATH/SFX/Perc Hit DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Radio Waves KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Radio Waves KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Rain Storm TK.fxp" "$R_NEW_FACTORY_PATH/SFX/Rain Storm TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Random Slots KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Random Slots KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Red Laser KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Red Laser KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Robot Legend KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Robot Legend KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Self-Osc Kick IW.fxp" "$R_NEW_FACTORY_PATH/SFX/Self-Osc Kick IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Shaker KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Shaker KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Short Stream KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Short Stream KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Snare DG.fxp" "$R_NEW_FACTORY_PATH/SFX/Snare DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Snare Layer ST.fxp" "$R_NEW_FACTORY_PATH/SFX/Snare Layer ST.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Soft Impact KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Soft Impact KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Soft Wind KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Soft Wind KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Sonar KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Sonar KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Special Bongo KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Special Bongo KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Spiral KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Spiral KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Spot Lite KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Spot Lite KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Static Ego KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Static Ego KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Sub Down KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Sub Down KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Super Beam KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Super Beam KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Super Tom KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Super Tom KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Suspense DG.fxp" "$R_NEW_FACTORY_PATH/SFX/Suspense DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Take Off KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Take Off KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Terminated KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Terminated KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/The Beach DG.fxp" "$R_NEW_FACTORY_PATH/SFX/The Beach DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/TR Hihat KS.fxp" "$R_NEW_FACTORY_PATH/SFX/TR Hihat KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Trailer Boom KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Trailer Boom KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Uranium 2000 KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Uranium 2000 KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Vintage Dub Siren XS.fxp" "$R_NEW_FACTORY_PATH/SFX/Vintage Dub Siren XS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Vintage Ghost KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Vintage Ghost KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Whoosh KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Whoosh KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Wind Push KS.fxp" "$R_NEW_FACTORY_PATH/SFX/Wind Push KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/SFX/Wind2Rain DG.fxp" "$R_NEW_FACTORY_PATH/SFX/Wind2Rain DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/3 Osc Fatness Bass BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/3 Osc Fatness Bass BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Ace of Bass RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Ace of Bass RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Analog Agressor RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Analog Agressor RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Attack Bass KS.fxp" "$R_NEW_FACTORY_PATH/Vintage/Attack Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Autobass RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Autobass RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Black Dice KS.fxp" "$R_NEW_FACTORY_PATH/Vintage/Black Dice KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Bootsie Funk BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/Bootsie Funk BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Drone Lead KS.fxp" "$R_NEW_FACTORY_PATH/Vintage/Drone Lead KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/E-Bass KS.fxp" "$R_NEW_FACTORY_PATH/Vintage/E-Bass KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Fat Drive KS.fxp" "$R_NEW_FACTORY_PATH/Vintage/Fat Drive KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Fat Saw Bass IW.fxp" "$R_NEW_FACTORY_PATH/Vintage/Fat Saw Bass IW.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/FFM Funk BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/FFM Funk BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Funk 70s KS.fxp" "$R_NEW_FACTORY_PATH/Vintage/Funk 70s KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Generic Reso Lead BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/Generic Reso Lead BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Juicy Bass RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Juicy Bass RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Leonard KS.fxp" "$R_NEW_FACTORY_PATH/Vintage/Leonard KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Login KS.fxp" "$R_NEW_FACTORY_PATH/Vintage/Login KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Old 70s Lead RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Old 70s Lead RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Original KS.fxp" "$R_NEW_FACTORY_PATH/Vintage/Original KS.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Plain Bass RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Plain Bass RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Punchee Bass TK.fxp" "$R_NEW_FACTORY_PATH/Vintage/Punchee Bass TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Raw Saw RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Raw Saw RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Reso Funk Bass BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/Reso Funk Bass BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Resurrection BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/Resurrection BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Rusty Lead BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/Rusty Lead BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Sharktooth RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Sharktooth RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Shmurgler Bass BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/Shmurgler Bass BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Smooth Glider RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Smooth Glider RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Snappy Troutman Bass BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/Snappy Troutman Bass BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Sync like lead BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/Sync like lead BT.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Triple Barrel RH.fxp" "$R_NEW_FACTORY_PATH/Vintage/Triple Barrel RH.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Tuba DG.fxp" "$R_NEW_FACTORY_PATH/Vintage/Tuba DG.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Vintage Bass TK.fxp" "$R_NEW_FACTORY_PATH/Vintage/Vintage Bass TK.fxp" >> /dev/null 2>&1
  mv "$R_NEW_SOUNDBANKS_PATH/Vintage/Whiney Lead BT.fxp" "$R_NEW_FACTORY_PATH/Vintage/Whiney Lead BT.fxp" >> /dev/null 2>&1

  # i usuwanie starych katalogów (gdyby jakis nie byl pusty, to nie zostanie usuniety)
  
  rmdir "$R_NEW_SOUNDBANKS_PATH/Bass" >> /dev/null 2>&1
  rmdir "$R_NEW_SOUNDBANKS_PATH/Chords" >> /dev/null 2>&1
  rmdir "$R_NEW_SOUNDBANKS_PATH/Init Patch" >> /dev/null 2>&1
  rmdir "$R_NEW_SOUNDBANKS_PATH/Lead" >> /dev/null 2>&1
  rmdir "$R_NEW_SOUNDBANKS_PATH/Poly" >> /dev/null 2>&1
  rmdir "$R_NEW_SOUNDBANKS_PATH/SFX" >> /dev/null 2>&1
  rmdir "$R_NEW_SOUNDBANKS_PATH/Vintage" >> /dev/null 2>&1
  
  # powtórka i koniec
  chown "$USER" "$R_NEW_FACTORY_PATH/" >> /dev/null 2>&1
  chmod 755 "$R_NEW_FACTORY_PATH/" >> /dev/null 2>&1

fi

# interesuje nas tylko parametr 1

if [ -z "$1" ]; then
  exit 1
else

  SYN_SRC_PATH="`dirname "$1"`"

  if [ -z "$SYN_SRC_PATH" ]; then
    exit 2
  else

  # kopiowanie danych wtyczki

    cp -R -f "$SYN_SRC_PATH/Content/" "$R_NEW_PLUGIN_PATH/" >> /dev/null 2>&1

    # ustawienie praw odczytu i flag

    chown -R "$USER" "$R_NEW_PLUGIN_PATH" >> /dev/null 2>&1
    chflags -R nouchg,noschg "$R_NEW_PLUGIN_PATH" >> /dev/null 2>&1

    find "$R_NEW_PLUGIN_PATH" -type d -exec chmod 755 {} \; >> /dev/null 2>&1
    find "$R_NEW_PLUGIN_PATH" -type f -exec chmod 644 {} \; >> /dev/null 2>&1
    
    # i dodatkowo ustawienie praw odzytu i zaipsu dla ukrytych plików
    
    find "$R_NEW_PATH_SYNAPSE" -type f -iname ".*" -exec chown "$USER" {} \; >> /dev/null 2>&1
    find "$R_NEW_PATH_SYNAPSE" -type f -iname ".*" -exec chmod 644 {} \; >> /dev/null 2>&1

  fi

fi

# i dodatkowo usuwanie z kwarantanny

xattr -d com.apple.quarantine "$R_NEW_PATH_SYNAPSE" >> /dev/null 2>&1
xattr -dr com.apple.quarantine "$R_NEW_PATH_SYNAPSE" >> /dev/null 2>&1

xattr -d com.apple.quarantine "$R_NEW_PLUGIN_PATH" >> /dev/null 2>&1
xattr -dr com.apple.quarantine "$R_NEW_PLUGIN_PATH" >> /dev/null 2>&1

# uff, koniec

exit 0
