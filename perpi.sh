#!/bin/bash

tones=(
  # 16.35160 # C0 Double Pedal C
  # 17.32391 # C♯0/D♭0
  # 18.35405 # D0
  # 19.44544 # D♯0/E♭0
  # 20.60172 # E0
  # 21.82676 # F0
  # 23.12465 # F♯0/G♭0
  # 24.49971 # G0
  # 25.95654 # G♯0/A♭0
  # 27.50000 # A0
  # 29.13524 # A♯0/B♭0
  # 30.86771 # B0
  # 32.70320 # C1 Pedal C
  # 34.64783 # C♯1/D♭1
  # 36.70810 # D1
  # 38.89087 # D♯1/E♭1
  # 41.20344 # E1
  # 43.65353 # F1
  # 46.24930 # F♯1/G♭1
  # 48.99943 # G1
  # 51.91309 # G♯1/A♭1
  # 55.00000 # A1
  # 58.27047 # A♯1/B♭1
  # 61.73541 # B1

  # "65.40639:C"     # C2 Deep C
  # # "69.29566:C3/Db" # C#2/Db2
  # "73.41619:D"     # D2
  # # "77.78175:D#/Eb" # D#2/Eb2
  # "82.40689:E"     # E2
  # "87.30706:F"     # F2
  # # "92.49861:F#/Gb" # F#2/Gb2
  # "97.99886:G"     # G2
  # # "103.8262:G#/Ab" # G#2/Ab2
  # "110.0000:A"     # A2
  # # "116.5409:A#/Bb" # A#2/Bb2
  # "123.4708:B"     # B2

  "130.8128:C"     # C3
  # "138.5913:C#/Db" # C#3/Db3
  "146.8324:D"     # D3
  # "155.5635:D#/Eb" # D#3/Eb3
  "164.8138:E"     # E3
  "174.6141:F"     # F3
  # "184.9972:F#/Gb" # F#3/Gb3
  "195.9977:G"     # G3
  # "207.6523:G#/Ab" # G#3/Ab3
  "220.0000:A"     # A3
  # "233.0819:A#/Bb" # A#3/Bb3
  "246.9417:B"     # B3
  "261.6256:C"     # C4 Middle C
  # "277.1826:C#/Db" # C#4/Db4
  "293.6648:D"     # D4
  # "311.1270:D#/Eb" # D#4/Eb4
  "329.6276:E"     # E4
  "349.2282:F"     # F4
  # "369.9944:F#/Gb" # F#4/Gb4
  "391.9954:G"     # G4
  # "415.3047:G#/Ab" # G#4/Ab4
  "440.0000:A"     # A4 A440
  # "466.1638:A#/Bb" # A#4/Bb4
  "493.8833:B"     # B4
  "523.2511:C"     # C5 Tenor C
  # "554.3653:C#/Db" # C#5/Db5
  "587.3295:D"     # D5
  # "622.2540:D#/Eb" # D#5/Eb5
  "659.2551:E"     # E5
  "698.4565:F"     # F5
  # "739.9888:F#/Gb" # F#5/Gb5
  "783.9909:G"     # G5
  # "830.6094:G#/Ab" # G#5/Ab5
  "880.0000:A"     # A5
  # "932.3275:A#/Bb" # A#5/Bb5
  "987.7666:B"     # B5

  # 1046.502 # C6 Soprano C (High C)
  # 1108.731 # C♯6/D♭6
  # 1174.659 # D6
  # 1244.508 # D♯6/E♭6
  # 1318.510 # E6
  # 1396.913 # F6
  # 1479.978 # F♯6/G♭6
  # 1567.982 # G6
  # 1661.219 # G♯6/A♭6
  # 1760.000 # A6
  # 1864.655 # A♯6/B♭6
  # 1975.533 # B6
  # 2093.005 # C7 Double high C
  # 2217.461 # C♯7/D♭7
  # 2349.318 # D7
  # 2489.016 # D♯7/E♭7
  # 2637.020 # E7
  # 2793.826 # F7
  # 2959.955 # F♯7/G♭7
  # 3135.963 # G7
  # 3322.438 # G♯7/A♭7
  # 3520.000 # A7
  # 3729.310 # A♯7/B♭7
  # 3951.066 # B7
  # 4186.009 # C8 Eighth octave
  # 4434.922 # C♯8/D♭8
  # 4698.636 # D8
  # 4978.032 # D♯8/E♭8
  # 5274.041 # E8
  # 5587.652 # F8
  # 5919.911 # F♯8/G♭8
  # 6271.927 # G8
  # 6644.875 # G♯8/A♭8
  # 7040.000 # A8
  # 7458.620 # A♯8/B♭8
  # 7902.133 # B8
)
toneCount=${#tones[@]}

# totalQuestions=100
totalQuestions=5

# fill the question list with the tones list multiple times, until we pass
# the total question count to get a list with "at least" enough items for the
# amount of questions.
questionList=()
timesTonesInQuestionList=$(( ($totalQuestions / $toneCount) + 1 ))
for x in $(seq 1 $timesTonesInQuestionList); do
  questionList=( "${questionList[@]}" "${tones[@]}" )
done

# echo questionListSize=${#questionList[@]}
getNextQuestion() {
  questionListSize=${#questionList[@]}
  questionIndex=$(($RANDOM%$questionListSize))
  question=${questionList[$questionIndex]}
  Q_FREQUENCY="${question%:*}"
  Q_NAME="${question#*:}"
  unset -v "questionList[$questionIndex]"
  questionList=( "${questionList[@]}" )
}

# for i in $(seq 1 $totalQuestions); do
#   getNextQuestion
#   echo "N: $Q_FREQUENCY $Q_NAME"
# done

# echo questionListSize=${#questionList[@]}
# echo "ql:${questionList[@]}"


triesPerQuestion=()

for i in $(seq 1 $totalQuestions); do
  getNextQuestion
  # echo "N: $Q_FREQUENCY $Q_NAME"
  # randomTone=${tones[RANDOM%$toneCount]}
  # frequency="${randomTone%:*}"
  # name="${randomTone#*:}"
  guesses=()

  unset guess
  msg="[$i] Guess note:"

  while [[ "$guess" == "" || $Q_NAME != *$guess* ]]; do
    if [[ "$guess" == "" ]]; then
      speaker-test -p 5 -l 1 -t sine -f $Q_FREQUENCY >/dev/null
    fi
    read -p "$msg" guess
    if [[ "$guess" == "" ]]; then
      msg="Try again (not ${guesses[@]}):"
    elif [[ $Q_NAME == *$guess* ]]; then
      triesPerQuestion+=($((${#guesses[@]} + 1)))
      echo "Yes: $guess equals the tone $Q_NAME ($Q_FREQUENCY)"
    else
      guesses+=("$guess")
      msg="Try again (not ${guesses[@]}):"
    fi
  done
done

# triesPerQuestion=(1 5 3 2 1)
questionCount=${#triesPerQuestion[@]}
declare -i wrong
declare -i total
for i in $(seq 0 $(($questionCount -1))); do
  current=${triesPerQuestion[$i]}
  total+=$current
  wrong+=$(( 1 % $current))
done

percent=$(bc -l <<< "($questionCount - $wrong) / $questionCount * 100")

rnd() { LC_NUMERIC=C printf "%.2f\n" $@; }


# printf "%.2f" $percent
echo "Got $(rnd $percent)% correct with $wrong wrong answers."

echo "Average tries:$(rnd $(bc -l <<< "$total / $questionCount")) (${triesPerQuestion[@]})"
