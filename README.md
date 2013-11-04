# yhat-ruby
A ruby wrapper for the Yhat API.

### Making a prediction

    $ irb
    > require 'yhat'
    > require 'pp'
    > yh = Yhat.new("greg", "testing123", "http://yhat.enterprise-01.us-west-1.elb.amazonaws.com/")
    > pp(yh.predict("PydataBeerRec", { "beer" => "Coors Light" }.to_json))
    {"yhat_id"=>"b6d9ba8f-81bd-4d6c-bcca-17315faa4299",
     "result"=>
       [["Coors Light", "Natural Light", 13.10332],
        ["Coors Light", "Michelob Ultra", 13.58854],
        ["Coors Light", "Bud Light", 18.89981],
        ["Coors Light", "Fat Tire Amber Ale", 35.31271],
        ["Coors Light", "Blue Moon Belgian White", 35.50784],
        ["Coors Light", "Dale's Pale Ale", 36.80674],
        ["Coors Light", "Guinness Draught", 41.04731],
        ["Coors Light", "60 Minute IPA", 47.50289],
        ["Coors Light", "Sierra Nevada Pale Ale", 51.62802]]}

