$stimulus_list = EXPARAM( "Stimulus List" : 99);
$scenario = "Lijst$stimulus_list";
scenario = $scenario;
pcl_file = "Entrainment_main.pcl";

no_logfile = false;

#onderstaande moet op TRUE staan!!
write_codes = false;               
pulse_width= 10;

# define button codes, 1=enter, 2=x (helemaal niet mee eens), 3=c, 4=v, 5=b, 6=n, 7=m, 8=,(helemaal wel mee eens)  
active_buttons = 8;    
button_codes = 250,121,122,123,124,125,126,127;
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
		
		stimulus_event { nothing {}; } list_descriptor;
		
		picture beginexp;
		code = "startexp";
		target_button = 1;
		response_active = true;
		
} start_experiment;

trial {
	trial_type = correct_response;
	trial_duration = forever;
	
	picture startoefen;
	code = "Start Practice"; 
	target_button = 1;
	response_active = true;
} start_practice;

trial {
	start_delay = 500;
	trial_duration = 1500;
	
	picture aandacht;
	code ="aandacht";
} pay_attention;

trial {
	trial_duration = 2000;
	stimulus_event
	{
		picture { 
			bitmap {
				filename = "images/octocat.png"; preload = true; description = "baseline";
			}; 
			x=0; y=0;
		};
	} baseline_picture_start_event;
	
	stimulus_event
	{
		nothing {};
		deltat = 1900;
	} baseline_picture_end_event;
	
} baseline_with_picture;

trial{
	trial_duration = stimuli_length;
	monitor_sounds = false;
	
	stimulus_event {
		nothing {};
		time = 0;
	} graphic_ready_event_0;
	
	stimulus_event
	{
		nothing {};
		time = 500;
		duration = next_picture;
	} graphic_active_event_0;
	
	stimulus_event
	{
		sound {
			wavefile {
				filename = "sounds/error.wav";
				preload = true;
			} audio_item_0;
		} audio_0;
 
		time = 1000;
	} audio_play_event_0;
	
	stimulus_event
	{
		nothing {};
		deltat = 0;
	} audio_play_delayed_event_0;
	
	stimulus_event
	{
		nothing {};
	} audio_finish_event_0;
	
	stimulus_event {
		nothing {};
		duration = next_picture;
	} graphic_inactive_event_0;
	
	stimulus_event {
		nothing {};
		deltat = 100;
	} graphic_inactive_delayed_event_0;
	
	stimulus_event {
		nothing {};
		delta_time = 400;
	} graphic_smooth_transition_0;
	
} dialogue_type_0_trial;

trial{
	trial_duration = stimuli_length;
	monitor_sounds = false;
	
	stimulus_event
	{
		nothing {};
		time = 0;
		duration = next_picture;
	} graphic_active_event_1;
	
	stimulus_event
	{
		sound {
			wavefile {
				filename = "sounds/error.wav";
				preload = true;
			} audio_item_1;
		} audio_1;
 
		time = 500;
	} audio_play_event_1;
	
	stimulus_event
	{
		nothing {};
		deltat = 0;
	} audio_play_delayed_event_1;
	
	stimulus_event
	{
		nothing {};
	} audio_finish_event_1;
	
	stimulus_event {
		nothing {};
		duration = next_picture;
	} graphic_inactive_event_1;
	
	stimulus_event {
		nothing {};
		deltat = 100;
		duration = 400;
	} graphic_inactive_delayed_event_1;
	
} dialogue_type_1_trial;

trial{
	trial_duration = stimuli_length;
	trial_type = fixed;
	stimulus_event {
		picture pic1;
		duration = 8000; 
		code = "pauze_1of2";
		deltat = 0;
		response_active = false;
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
		time = 0;
		duration = 100;
		code = "blank";
		response_active = false;
	} blank_event;
	
	stimulus_event
	{
		picture default;
		time = 100;
		duration = 900;
		response_active = false;
	} blank_event_delayed;
	
} blank_event_dialogue_question;

trial{
	trial_duration = stimuli_length;
	trial_type = fixed;
	picture default;
	time = 0;
	duration = 500;
	code = "blank";
	response_active = false;	
} blank_trial;

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
} question;

# End of Practice
trial {
	start_delay = 1000;
	trial_type = correct_response;
	trial_duration = forever;
	
	picture eindoefen;
	target_button = 1;
	response_active = true;
	code = EXPARAM( "END_PRACTICE_TRIGGER" : 254);
	port_code = EXPARAM( "END_PRACTICE_TRIGGER" : 254);
	
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
		picture question;
		target_button = 2,3,4,5,6,7,8;
		code = "Question";
	} question_event;
	
} question_trial;

trial {
	trial_type = fixed;
	trial_duration = 500;
	
	picture question;
	time=0;
	
	nothing {};
	time=100;
	port_code = EXPARAM( "TRIAL_END_TRIGGER" : 255);
	code = EXPARAM( "TRIAL_END_TRIGGER" : 255);
	
} trial_feedback_vraag;
