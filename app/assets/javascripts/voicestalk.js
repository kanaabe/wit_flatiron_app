var voiceStalk = {

    //allowed methods is all intents of all of Ruby006
    ALLOWED_METHODS: ['directions'],
    

    init: function() {
        this.speechRecognition.init();
    },

    handleCommand: function(command) {
        var witResult = command.outcome;
        if (this.ALLOWED_METHODS.indexOf(witResult.intent) > -1) {
            
            
            this[witResult.intent](witResult);
        }
    }

};
