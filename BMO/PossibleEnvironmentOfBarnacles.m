   function Map=PossibleEnvironmentOfBarnacles(Map,PinesLength,Xcenter,YCenter,LimitedPL)
     if PinesLength~=0 %SelfMeating
         if PinesLength <= LimitedPL %OverCast
             Map= MapBarnacles(Map,PinesLength,Xcenter,YCenter);
         else
             PinesLength =  randi([0,10]);
             if PinesLength <= LimitedPL
                 Map= MapBarnacles(Map,PinesLength,Xcenter,YCenter);
             end
         end
     end