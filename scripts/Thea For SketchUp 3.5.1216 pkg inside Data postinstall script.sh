#!/bin/sh
eval chmod -R 0755 -o $USER \"/tmp/Thea4SU/TheaData\"

if [ -e ~/Documents/Thea\ Render/TheaRenderDataPath.txt ]
then
    THDATA=`head -1 ~/Documents/Thea\ Render/TheaRenderDataPath.txt`
    #echo "Output: \"$THDATA\""

    #Deleting old LUT names - They have meaningful names now RV1158
	rm -f "$THDATA/lut/Thea Lut 01m.CUBE"
	rm -f "$THDATA/lut/Thea Lut 02m.CUBE"
	rm -f "$THDATA/lut/Thea Lut 03m.CUBE"
	rm -f "$THDATA/lut/Thea Lut 04m.CUBE"
	rm -f "$THDATA/lut/Thea Lut 05m.CUBE"
	rm -f "$THDATA/lut/Thea Lut 06m.CUBE"
	rm -f "$THDATA/lut/Thea Lut 07m.CUBE"
	rm -f "$THDATA/lut/Thea_Lut_08m_False_Color.CUBE"

    rsync -a /tmp/Thea4SU/TheaData/ "$THDATA"
else
	sudo install -m 0755 -o $USER -d ~/Documents/Thea\ Render
	touch ~/Documents/Thea\ Render/TheaRenderDataPath.txt
	echo "$HOME/Library/Application Support/Thea Render" > ~/Documents/Thea\ Render/TheaRenderDataPath.txt
	rsync -a /tmp/Thea4SU/TheaData/ "$HOME/Library/Application Support/Thea Render"
fi
