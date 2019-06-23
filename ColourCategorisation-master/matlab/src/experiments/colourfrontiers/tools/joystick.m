function joystick(mode, buttons)
% 
% Usage:
% 
% [buttons elapsed_time]=joystick('wait')
% [buttons elapsed_time]=joystick('wait', buttons_to_check)
% 
% waits for a button to be pressed. The parameter 'buttons_to_check' is an array indicating which 
% buttons should be checked. The ouput is an array the same length as 'buttons_to_check' or with 
% length N where N is the number of buttons o the devide, if the second parameter is not set. 
% 'time' is the amount of time elapsed between the function call and the user response.
% 
% Example:
% 
% [buttons elapse_time]=joystick('wait',[3 5])
% 
% will wait for the button 3 or 5 to be pressed. It will return a 1x2 array with 1 at the first 
% position if the button 3 has been pressed, and 1 at the second position if button 5 has been pressed.
% 
% 
% [buttons stick_1 stick_2]=joystick()
% [buttons stick_1 stick_2]=joystick('get')
 [buttons stick_1 stick_2]=joystick('get', buttons_to_check)
% 
% checks wich buttons is pressed at the moment without waiting. As above, the buttons to check can be 
% selected with the second parameter. It also returns the position of the analog sticks. The values 
% stick_1 and stick_2 are 1x2 arrays indicating the horizontal and vertical position of the stick. 
% The range of values of position are [-10 10].
