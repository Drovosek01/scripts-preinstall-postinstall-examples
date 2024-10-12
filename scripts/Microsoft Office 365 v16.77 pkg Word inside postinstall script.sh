#!/bin/zsh

user_name=$(/usr/bin/defaults read /Library/Preferences/com.apple.loginwindow lastUserName)
domain="com.microsoft.autoupdate2"
domain_sys="/Library/Preferences/com.microsoft.autoupdate2"
defaults_cmd=(/usr/bin/sudo -u $user_name /usr/bin/defaults)
defaults_cmd_sys=(/usr/bin/defaults)
application="/Applications/Microsoft Word.app"
application_info_plist="$application/Contents/Info.plist"
lcid="1033"
app_domain="com.microsoft.office"

if /bin/test -f "$application_info_plist"
then
	application_bundle_signature=$($defaults_cmd read "$application_info_plist" CFBundleSignature)
	#WORD APP WILL ALWAYS BE CALLED MSWD15 from here to eternity because of MAU. 

	application_id=$(printf "%s2019" "$application_bundle_signature")

	$defaults_cmd write $domain Applications -dict-add "$application" "{ 'Application ID' = $application_id; LCID = $lcid ; 'App Domain' = '$app_domain' ; }"
	$defaults_cmd_sys write $domain_sys ApplicationsSystem -dict-add "$application" "{ 'Application ID' = $application_id; LCID = $lcid ; 'App Domain' = '$app_domain' ; }"
fi

licensingHelperPath="/Library/PrivilegedHelperTools/com.microsoft.office.licensingV2.helper"
if [[ -e "${licensingHelperPath}" ]]
then
	# Add Licensing Tool to Microsoft Autoupdate Application Dictionary
	$defaults_cmd write $domain Applications -dict-add "${licensingHelperPath}" "{ 'Application ID' = 'OLIC02'; LCID = $lcid ; 'App Domain' = '$app_domain' ; 'HideOnGUI' = YES ; }"
	$defaults_cmd_sys write $domain_sys ApplicationsSystem -dict-add "${licensingHelperPath}" "{ 'Application ID' = 'OLIC02'; LCID = $lcid ; 'App Domain' = '$app_domain' ; 'HideOnGUI' = YES ; }"
fi

exit 0
