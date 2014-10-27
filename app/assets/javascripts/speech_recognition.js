//Adapted from MessyChef

var recognition;

voiceStalk.speechRecognition = {
    final_transcript: '',
    lastRecognition: 0,
    timeBetweenCommands: 3000,
  
     stop: function() {
        recognition.stop();
     },

    init: function() {

        if (!('webkitSpeechRecognition' in window)) {
            this.notSupportedMessage();
        } else {
            
            recognition = new webkitSpeechRecognition();   
            recognition.continuous = true;
            recognition.interimResults = true;
            recognition.lang = 'en-US';

            //is called several times if while speeking... builds a string 
            recognition.onresult = function(event) {
                //If the last word is a certain time ago, start a new sentence
                this.isNewCommand();

                //concat the single workds
                var interim_transcript = this.concatSpeechResults(event);

                if (this.final_transcript !== '') {
                    document.getElementById('interim').innerHTML = '"' + this.final_transcript + '"';
                    this.initCommand(this.final_transcript);
                }
            }.bind(this);

            //The speech recognition seems to end without any reason -> simply restarting it
            recognition.onend = function(evt) {
                console.log("end", evt);
                recognition.start();
            };

            recognition.start();
        }
    },

    concatSpeechResults: function(event) {
        var interim_transcript = '';
        for (var i = event.resultIndex; i < event.results.length; ++i) {
            if (event.results[i].isFinal) {
                this.final_transcript += event.results[i][0].transcript;
            } else {
                interim_transcript += event.results[i][0].transcript;
            }
        }
        document.getElementById('interim').innerHTML = '"' + interim_transcript + '"';

        return interim_transcript;

    },

    //Check if the last word is to old in order to start a new sentence 
    //Resets the stored sentence
    isNewCommand: function() {
        var tmpTime = new Date().getTime();
        if (tmpTime - this.lastRecognition > this.timeBetweenCommands) {
            this.lastRecognition = tmpTime;
            this.final_transcript = '';
            $('#downloadButton').click();
            return true;
        } else return false;
    },

    //GET call to retrieve the command from WIT (uses a proxy for oAuth2)

    initCommand: function(command) {
        $.ajax({
            //TODO change this url
            url: '/recipes/command_detect',
            type: 'POST',
            dataType: "JSON",
            data:(
                'cmd=' + command
                ),
            success: function(response){
                console.log(response);
            },
            error: function(response){
                console.log(response);
                var response = response;
                var r = response.responseText;

               

                if (r.indexOf("next") !=-1) { 
                    console.log("before the click");
                    
                    $('.flex-next').click();
                    $('.ui-button-text').click();

                } else if (r.indexOf("back") !=-1 ){

                    $('.flex-prev').click();
                    $('.ui-button-text').click();
                } else if (r.indexOf("search") !=1) {
                    
                    var valPos = r.indexOf("value") + 9;
                    var a = r.substr(valPos);
                    var b = a.length - 3;
                    var searchTerm = a.substr(0, b);
                    
                    $('.form-control').val(searchTerm);
                    $('button').click();
                    console.log("this is searching..");
                    
                } else {
                    alert("voicestalk did not understand command, sorry!");
                }


                console.log("ERROR");
            }

        });
    },

    notSupportedMessage: function() {
        alert('Speech Recognition is only supported by Chrome');
    }
};