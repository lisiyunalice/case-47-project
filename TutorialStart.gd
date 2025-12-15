extends Node

@onready var player = $"../Player"
@onready var dialogue_ui: Control = get_node("../CanvasLayer/DialogueUI")
@onready var name_label: Label = dialogue_ui.get_node("NameLabel")
@onready var dialogue_label: Label = dialogue_ui.get_node("DialogueLabel")
@onready var portrait_npc: TextureRect = dialogue_ui.get_node("PortraitNPC")

var dialogue_index := 0
var dialogues := []

func _ready():
	start_intro_dialogue()

func start_intro_dialogue() -> void:
	var dialogue = [

		# ===== Entrance / Monologue =====
		{
			"speaker": "You",
			"text": "(I am a freelance journalist.)"
		},
		{
			"speaker": "You",
			"text": "(Recently, I was asked to investigate a murder case, so I arranged a meeting with one of the survivors.)"
		},
		{
			"speaker": "You",
			"text": "(I arrive at the entrance of Kamura's house.)"
		},

		# ===== First Meeting =====
		{
			"speaker": "Kamura",
			"text": "Hello. You must be the one who said you wanted to visit earlier."
		},
		{
			"speaker": "Kamura",
			"text": "My name is Kamura. It is a pleasure to meet you."
		},
		{
			"speaker": "You",
			"text": "(He looks pale and exhausted.)"
		},
		{
			"speaker": "Kamura",
			"text": "Please, come inside."
		},
		{
			"speaker": "Kamura",
			"text": "I just put some water on. I will make some tea shortly."
		},

		# ===== Living Room =====
		{
			"speaker": "Kamura",
			"text": "The weather outside is not very good today, is it?"
		},
		{
			"speaker": "Kamura",
			"text": "Sorry for making you come all this way."
		},
		{
			"speaker": "Kamura",
			"text": "To be honest, it would have been fine even if you arrived a bit later."
		},
		{
			"speaker": "You",
			"text": "(The Kamura family murder occurred one year ago.)"
		},
		{
			"speaker": "You",
			"text": "(One night, after returning home from work, Kamura Toru discovered the bodies of his wife Yukiko, aged 32, his daughter Aira, aged 6, and the suspect, Nobuaki Tambo, aged 31, in the bedroom.)"
		},
		{
			"speaker": "You",
			"text": "(The murder weapon was a kitchen knife from the Kamura household.)"
		},
		{
			"speaker": "You",
			"text": "(Based on the scene, it was concluded that the suspect brutally murdered the two victims and then took his own life.)"
		},
		{
			"speaker": "You",
			"text": "(There was no known connection between the Kamura family and the suspect, and no clear motive could be identified.)"
		},

		# ===== Kamura's Reaction =====
		{
			"speaker": "Kamura",
			"text": "Those things are all in the past."
		},
		{
			"speaker": "Kamura",
			"text": "Please do not bring them up anymore."
		},
		{
			"speaker": "Kamura",
			"text": "I am not sad. I simply believe that what is past should remain in the past."
		},
		{
			"speaker": "Kamura",
			"text": "By the way, there is something I would like to discuss with you."
		},

		# ===== Philosophical Turn =====
		{
			"speaker": "Kamura",
			"text": "You know, someone once asked this question."
		},
		{
			"speaker": "Kamura",
			"text": "If a tree falls in a forest where no one is present, does it make a sound?"
		},
		{
			"speaker": "Kamura",
			"text": "The answer is that if no one hears it, then it is as if it never made a sound at all."
		},
		{
			"speaker": "Kamura",
			"text": "In other words, if you, the guest, were not here..."
		},
		{
			"speaker": "Kamura",
			"text": "Then my family would be no different from never having existed."
		},

		# ===== Strange Sounds =====
		{
			"speaker": "You",
			"text": "(Hehe...Giggle...)I think I hear the sound of a child's laughter and footsteps coming from the second floor."
		},
		{
			"speaker": "Kamura",
			"text": "Oh, I apologize."
		},
		{
			"speaker": "Kamura",
			"text": "That must be my daughter, Aira, playing upstairs."
		},
		{
			"speaker": "You",
			"text": "(His expression does not seem like he is joking at all.)"
		},
		{
			"speaker": "Kamura",
			"text": "Yes... in fact, Aira never died."
		},

		# ===== Scream =====
		{
			"speaker": "You",
			"text": "(AAAAAAAAAAAAHHHHHHHHHHHHHHHHHHH------------------------------A woman's scream echoes from upstairs.)"
		},
		{
			"speaker": "Kamura",
			"text": "I am sorry. That was my wife's voice."
		},
		{
			"speaker": "Kamura",
			"text": "From time to time, she remembers the incident."
		},
		{
			"speaker": "Kamura",
			"text": "Even after all this time, she still has not come to terms with it."
		},
		{
			"speaker": "Kamura",
			"text": "It is... rather troublesome."
		},

		# ===== Exit =====
		{
			"speaker": "Kamura",
			"text": "I will go and speak with her."
		},
		{
			"speaker": "Kamura",
			"text": "Please excuse me."
		},
		{
			"speaker": "You",
			"text": "(Kamura leaves and goes upstairs.)"
		},
		{
			"speaker": "You",
			"text": "(An unsettling chill runs down my spine.)"
		},
		{
			"speaker": "You",
			"text": "(Kamura does not return.)"
		},
		{
			"speaker": "You",
			"text": "(Use WASD to move, Space to jump. Hover above any suspicious object to see what it is, and click it to collect. Remember, you can only remember 3 objects simultaneously, and HURRY...you only have 10 mintues...)"
		},
		{
			"speaker": "You",
			"text": "Perhaps I should take a look around the house."
		}
		

	]

	dialogue_ui.start(dialogue, player)
