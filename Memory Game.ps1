Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
while($true) {
    
    :checker while(($choice1 = read-host "Do you want to play with numbers, letters, or both? [N/L/B]")){
        switch ($choice1){
            "N"{$set = @(48..57); break checker}
            "L"{$set = @(65..90); break checker}
            "B"{$set = @(48..57 + 65..90); break checker}
            default{"Invalid input"}
        }
    }

    for($i=0;$i -lt $set.length; $i++){
        [char]$set[$i] = $set[$i] 
    }

    [int]$choice2 = read-host "How many values would you like to play with?"
    $values = $set | get-random -count $choice2
    
    for($i=0; $i -lt $values.length; $i++){
        $say = "$($values[$i])"
        $speak.speak($say)
        timeout /T 1 /NOBREAK > $null
    }

    if(!($points)){$points = 0}

    &{
        for($i=0;$i -lt $values.length; $i++){
            $i2 = $i + 1
            $suffix = switch -r($i2){"(?<!1)1$"{'st'}"(?<!1)2$"{'nd'}"(?<!1)3$"{'rd'}default{'th'}}
            $full = "$i2"+"$suffix"
            $answers = read-host "What was the $full value you heard?"
            if($answers -eq $values[$i]){
                Write-Output "You got it right!"
                $global:points+=1
                Write-Output "You have $global:points point(s)!"
            } else {
                Write-Output "Sorry, that was incorrect. `nYou get no points this round."
                Write-Output "You have $global:points point(s)"
            }
        }
    }
}