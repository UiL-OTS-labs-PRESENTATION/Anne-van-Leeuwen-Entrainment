# Scenario for playing .wav files 
# 2015 adapted by Anne van Leeuwen for rhythm experiment 2.0
# listeners are presented with 3 dialogues (self-paced)
# after the third dialogue they have to evaluate how it sounds
 
# audio mode moet in exclusive mode staan als we gaan testen! aanpassen aub

scenario = "Entrainment";
pcl_file = "Entrainment_main.pcl";

no_logfile = false ;

#onderstaande moet op TRUE staan!!
write_codes = false;               
pulse_width= 10;

# define button codes, 1=enter, 2=x (helemaal niet mee eens), 3=c, 4=v, 5=b, 6=n, 7=m, 8=,(helemaal wel mee eens)  
active_buttons = 8;    
button_codes = 1,2,3,4,5,6,7,8;
#response_port_output = false;
response_logging = log_active;

default_font_size = 30;
default_font = "Arial";
default_text_color = 160,160,160;
default_background_color = 255,255,153;
#default_formatted_text = true;

begin;
	
picture {} default;			#blank screen

picture { text {caption = "WELKOM! \n \n Druk op Enter om met het experiment te beginnen"; font_size = 30;}; x=0; y=0;} beginexp; 
picture { text {caption = "Begin Oefensessie \n Druk op Enter om verder te gaan"; font_size = 30;}; x=0; y=0;} startoefen;
picture { text {caption = "Einde Oefensessie \n Heb je nog vragen? Stel deze dan nu aan de proefleider! \n Druk op Enter om verder te gaan"; font_size = 30;}; x=0; y=0;} eindoefen;
picture { text {caption = "BEGIN EXPERIMENT \n \n Druk op Enter om met het experiment te beginnen"; font_size = 30;}; x=0; y=0;} begintest; 
picture { text {caption = "Luister aandachtig \n Druk op Enter zodra het fragment groen is. \n Het fragment wordt dan afgespeeld"; font_size = 30;}; x=0; y=0;} aandacht; 
picture { text {caption = "EINDE EXPERIMENT \n Dank je wel voor het meedoen";}; x=0; y=0;} eindexp;    
	
picture { text {caption = 
"PAUZE

Neem een korte pauze.
Knipper even goed met je ogen, beweeg je nek langzaam heen en weer
en draai rustig met je schouders.

Druk op Enter als je klaar bent om door te gaan.";max_text_height = 1200; max_text_width = 1600; font_size = 30;}; x=0; y=0;} pauzeklein;

text {caption = "In de reactie van de tweede spreker hoorde ik:"; font_size = 30;} text1;

array {
	picture { bitmap { filename = "images/foto1.jpg"; preload = true; description = "pauze1" ;}; x=0; y=0;} pic1;
	picture { bitmap { filename = "images/foto2.jpg"; preload = true; description = "pauze2" ;}; x=0; y=0;} pic2;
	picture { bitmap { filename = "images/foto3.jpg"; preload = true; description = "pauze3" ;}; x=0; y=0;} pic3;
	picture { bitmap { filename = "images/foto4.jpg"; preload = true; description = "pauze4" ;}; x=0; y=0;} pic4;
	picture { bitmap { filename = "images/foto5.jpg"; preload = true; description = "pauze5" ;}; x=0; y=0;} pic5;
	picture { bitmap { filename = "images/foto6.jpg"; preload = true; description = "pauze6" ;}; x=0; y=0;} pic6;
} pauzes_figures;

trial {
		trial_type = correct_response;
		trial_duration = forever; 
		
		picture beginexp;
		code = "startexp";
		target_button = 1;
		response_active = true;
} startexp;

trial {
	trial_type = correct_response;
	trial_duration = forever;
	
	picture startoefen;
	code = "startoefen"; 
	target_button = 1;
	response_active = true;
} startoefenblok;

trial {
	start_delay = 500;
	trial_duration = 1500;
	
	picture aandacht;
	code ="aandacht";
} payattention;
	
# we define a picture and name it
picture { 
	bitmap 
	{	filename = ""; 
		preload = false;
	} p; 
	x=0; y=0;
} pct;

trial { 
	trial_duration = stimuli_length; 
	monitor_sounds = true;

	stimulus_event{
		picture pct;
		deltat = 100;
		response_active = false;
		code = "active";
		duration = next_picture;
	} event0;
		
	stimulus_event {
		sound {
			wavefile {
				filename = "sounds/error.wav";
				preload = false;
			} wavefile_stimulus;
		} sound_file; 
		
		deltat = 0; 
		code = "";			
		response_active = false;
	} wav_event;
		
	stimulus_event {
		nothing {};
		deltat = 0; 
		code = "";
		response_active = false;
	} event_nothing;
	
} playsent;

trial{
	trial_duration = stimuli_length;
	trial_type = fixed;
	trial_duration = 8000;
	stimulus_event {
		picture pic1;
		duration = 8000; 
		code = "pauze_1of2";
		deltat = 0;
		response_active = false;
		duration = next_picture;
	} event_pauze_picture;
} trial_pauze_picture;

trial {
	trial_type = correct_response;
	trial_duration = forever;
	stimulus_event {
		picture pauzeklein;
		target_button = 1;
		code = "pauze_2of2";
	} event_pauze_text;
} trial_pauze_text;

trial{
	trial_duration = stimuli_length;
	trial_type = fixed;
	stimulus_event
	{
		picture default;
		deltat = 0;
		duration = 500;
		code = "";
		response_active = false;
	} event_blank;
} trial_blank;

# trial definition voor inactive start and end
trial{
	trial_type = fixed;
	trial_duration = 500;
	
	stimulus_event
	{
		picture pct;
		deltat = 0;
		duration = next_picture;
		code = "";
		response_active = false;
	} event_inactive;
} trial_inactive;

trial{
	trial_type = fixed;
	trial_duration = 1500;
	
	stimulus_event
	{
		picture pct;
		deltat = 0;
		duration = next_picture;
		code = "";
		response_active = false;
	} event_inactive_start;
} trial_inactive_start;


#trial active first display
trial {		
	trial_type = correct_response;
	trial_duration = forever; 
	
	stimulus_event
	{
		picture pct;
		deltat = 0;
		code = "";
		response_active = true;
		target_button = 1;
		duration = next_picture;
	} event_active;
	
} trial_active;

trial {		
	trial_type = fixed;
	trial_duration = 200;
	
	stimulus_event
	{
		picture pct;
		deltat = 0;
		code = "";
		response_active = false;
		duration = next_picture;
	} event_active_stay;
} trial_active_stay;

array {
	ellipse_graphic {
		ellipse_width = 20;
		ellipse_height = 20;
		color = 166, 166, 166;
		rotation = 30;
	} circle0;

} feedback_circles;

ellipse_graphic {
	ellipse_width = 20;
	ellipse_height = 20;
	color = 166, 166, 166;
	rotation = 30;
} circle1;

ellipse_graphic {
	ellipse_width = 20;
	ellipse_height = 20;
	color = 166, 166, 166;
	rotation = 30;
} circle2;

ellipse_graphic {
	ellipse_width = 20;
	ellipse_height = 20;
	color = 166, 166, 166;
	rotation = 30;
} circle3;

ellipse_graphic {
	ellipse_width = 20;
	ellipse_height = 20;
	color = 166, 166, 166;
	rotation = 30;
} circle4;

ellipse_graphic {
	ellipse_width = 20;
	ellipse_height = 20;
	color = 166, 166, 166;
	rotation = 30;
} circle5;

ellipse_graphic {
	ellipse_width = 20;
	ellipse_height = 20;
	color = 166, 166, 166;
	rotation = 30;
} circle6;

ellipse_graphic {
	ellipse_width = 20;
	ellipse_height = 20;
	color = 166, 166, 166;
	rotation = 30;
} circle7;

text {caption = "VERWIJDERING"; font_size = 25;}text_verwijdering;
text {caption = "TOENADERING"; font_size = 25;} text_toenadering;

picture {
	text text1; x=0; y=0;
	text text_verwijdering; right_x=-200; y=-150;
	ellipse_graphic circle1; x=-150; y=-150;
	ellipse_graphic circle2; x=-100; y=-150;
	ellipse_graphic circle3; x=-50; y=-150;
	ellipse_graphic circle4; x=0; y=-150;
	ellipse_graphic circle5; x=50; y=-150;
	ellipse_graphic circle6; x=100; y=-150;
	ellipse_graphic circle7; x=150; y=-150;
	text text_toenadering; left_x=200; y=-150;
} vraag;
			

	
	


	# End of Practice
	trial {
		start_delay = 1000;
		trial_type = correct_response;
		trial_duration = forever; 
		picture eindoefen;
		code = "eindeoefening";
		target_button = 1;
		response_active = true;
	} endpractice;

	# Begin of Testitems
	trial {
		trial_type = correct_response;
		trial_duration = forever; 
		picture begintest;
		code = "starttest";
		target_button = 1;
		response_active = true;
	} starttest;

	# End of Experiment
	trial {
		start_delay = 1000;
		trial_type = correct_response;
		trial_duration = forever; 
		picture eindexp;
		code = "eindexp";
		target_button = 1;
		response_active = true;
	} endexp;

	trial {
		trial_type = correct_response;
		trial_duration = forever;
		
		stimulus_event {
			picture vraag;
			target_button = 2,3,4,5,6,7,8;
			code = "vraag";
		} event_vraag;
		
	} trial_vraag;

	trial {
		trial_type = fixed;
		trial_duration = 500;
		picture vraag;
		
	} trial_feedback_vraag;