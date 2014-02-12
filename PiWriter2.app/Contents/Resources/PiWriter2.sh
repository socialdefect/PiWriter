#!/usr/bin/env bash

DIALOG="${1}CocoaDialog.app/Contents/MacOS/CocoaDialog"

## What to do dialog
QUESTION=`"$DIALOG" dropdown --title 'PiWriter2 - Raspberry Pi SDcard Manager' --text 'Select an option from the list below:' --items 'Write Image To SD' 'Create SD Backup Image' --button1 'Start' --button2 'Quit'`

QUESTION=`echo "$QUESTION" | sed -n '2 p'`

if [ "$QUESTION" = '1' ] ; then
    MODE=backup
else
    MODE=write
fi

## Completion dialog
OnComplete(){
    if [ $? = 0 ] ; then
        "$DIALOG" msgbox --title "Completed" --button1 'Quit' --text 'The task has completed succesfully!' &>/dev/null
        exit 0
    else
        "$DIALOG" msgbox --title "Error" --button1 'Quit' --text 'The task has returned an error. Check the output messages to see why!' &>/dev/null
        exit 1
    fi
}

UnMount(){
    echo 'Unmounting Device...'
    for i in $@ ; do
        if [ $i = `mount | grep $i | awk '{ print $1 }'` ] ; then
            hdiutil unmount "$i"
        else
            echo 'Partition has not been mounted.'
        fi
        if [ "$?" != '0' ] ; then
            hdiutil unmount "$i" 
        fi
        if [ "$?" != '0' ] ; then
            "$DIALOG" msgbox --title "Error" --button1 'Quit' --text 'Cannot Unmount The SD Device... Will Now Exit... Please try to unmount the disk using Disk Utillity or restart your computer to make sure the device has disconnected properly before you try again!' &>/dev/null 
            exit 1
        fi
    done
}

if [ "$MODE" = 'backup' ] ; then
    DEVICE=`mount | grep $2 | awk '{ print $1 }'`
    DEVICE=`echo ${DEVICE%??} | sed s'/rdisk/disk/'`
    PARTITIONS=`ls ${DEVICE}s*`
    FILENAME=`"$DIALOG" filesave --title "Backup Location" --no-select-directories --text 'Select a location to store your backup image and enter a filename:' --no-select-multiple --with-extensions '.img'`
    $FILENAME
    UnMount "$PARTITIONS"
    COMPRESS=`"$DIALOG" dropdown --title "$TITLE" --string-output --text 'Do You Want To Use Compression??'  --button1 Continue  --items no fast best`
        COMPRESS=`echo "$COMPRESS" |  sed -n '2p'`
            
	CONTINUE=`"$DIALOG" msgbox --title "$TITLE" --text 'Start Backup Process.' --button1 Backup --button2 Quit --informative-text "TASK: Clone "$DEVICE" To: "$FILENAME"(.gz). Using Compression: "$COMPRESS" If This Is Correct Start Backup."`

	if [ "$CONTINUE" = '1' ] ; then
                echo 'Starting the cloning process.... Please be patient....'
                
                Rundd(){
                if [ "$COMPRESS" = 'no' ] ; then
                   dd if="$DEVICE" of="$FILENAME"
                elif [ "$COMPRESS" = 'fast' ] ; then
                    dd if="$DEVICE" conv=noerror,sync | gzip --fast -c > "$FILENAME".gz
                elif [ "$COMPRESS" = 'best' ] ; then
                    dd if="$DEVICE" conv=noerror,sync | gzip --best -c > "$FILENAME".gz
                fi
                
		if [ "$?" != '0' ] ; then
			"$DIALOG" msgbox --title "$TITLE - FAILED" --button1 'Quit' --text 'Failed To Create Backup Image!' &>/dev/null 
			exit 1
		else
			hdiutil eject "$DEVICE"
			"$DIALOG" ok-msgbox --title "$TITLE - FINISHED" --text 'Finished Writing Backup Image!' --informative-text 'You can now disconnect the SD Card.'  &>/dev/null
		fi
                }
                
		Rundd | "$DIALOG" progressbar --indeterminate --float --stopable --title "$TITLE" --text "Creating Backup Image... This Might Take a Long Time..."                

	fi
fi

if [ "$MODE" = 'write' ] ; then
    DEVICE=`mount | grep $2 | awk '{ print $1 }'`
    if [ `mount | grep $DEVICE | awk '{ print $3 }'` = '/' ] ; then
        "$DIALOG" msgbox --title "FAILED" --button1 'Quit' --text 'You have selected your Mac install disk!' &>/dev/null
        exit 1
    else
        DEVICE=`echo ${DEVICE%??} | sed s'/rdisk/disk/'`
    fi
    
    PARTITIONS=`ls ${DEVICE}s*`
    if [ `file $DEVICE | awk '{ print $2 }'` != 'block' ] ; then
        "$DIALOG" msgbox --title "Error:" --button1 'Quit' --text 'Device is not a valid block device!' &>/dev/null
        echo 'Usage: Drag a mounted SD card icon from your desktop on this window.'
        exit 1
    fi
    FILENAME=`"$DIALOG" fileselect --title "Select Image" --no-select-directories --text 'Select an image file:' --no-select-multiple --with-extensions '.img'`
    $FILENAME
    
    UnMount "$PARTITIONS"
            
	CONTINUE=`"$DIALOG" msgbox --title "$TITLE" --text 'Start SD Copy Process.' --button1 Start --button2 Quit --informative-text "TASK: Clone "$FILENAME" To: "$DEVICE". If This Is Correct Press Start."`

	if [ "$CONTINUE" = '1' ] ; then
                echo 'Starting the cloning process.... Please be patient....'
                
                
                   dd if="$DEVICE" of="$FILENAME" | "$DIALOG" progressbar --indeterminate --float --stopable --title "$TITLE" --text "Cloning Image To SD... This Might Take a Long Time..."
                                
		if [ "$?" != '0' ] ; then
			"$DIALOG" msgbox --title "$TITLE - FAILED" --button1 'Quit' --text 'Failed To Clone The Image To SD!' &>/dev/null 
			exit 1
		else
			hdiutil eject "$DEVICE"
			"$DIALOG" ok-msgbox --title "$TITLE - FINISHED" --text 'Finished Cloning Image To SD!' --informative-text 'You can now disconnect the SD Card.'  &>/dev/null
		fi
                

	fi
fi

exit 0