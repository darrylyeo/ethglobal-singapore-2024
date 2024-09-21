<script lang="ts">
	// Constants
	const questions = [
		{ 
			title: 'Pets', 
			description: 'Do you prefer fluffy felines or playful pups?', 
			options: [
				{ name: 'Cats', description: 'I’m on Team Meow.', emoji: '🐱' }, 
				{ name: 'Dogs', description: 'I’m on Team Woof.', emoji: '🐶' },
			],
		},
		{ 
			title: 'Sleep Schedule', 
			description: 'Are you a rise and shine person or do you have night owl vibes?', 
			options: [
				{ name: 'Morning', description: 'Early bird catches the worm!', emoji: '🌅' }, 
				{ name: 'Night', description: 'Burn the midnight oil!', emoji: '🌙' },
			],
		},
		{ 
			title: 'Hot Drink', 
			description: 'Do you prefer a java jolt or leaf water?', 
			options: [
				{ name: 'Coffee', description: 'I’m a coffee addict.', emoji: '☕' }, 
				{ name: 'Tea', description: 'I’m a tea enthusiast.', emoji: '🍵' },
			],
		},
		{ 
			title: 'Season', 
			description: 'Do you enjoy the sizzling sun or a winter wonderland?', 
			options: [
				{ name: 'Summer', description: 'I’m a beach bum.', emoji: '☀️' }, 
				{ name: 'Winter', description: 'I’m a snow bunny.', emoji: '❄️' },
			],
		},
		{ 
			title: 'Personality', 
			description: 'Are you more of a party animal or a cozy hermit?', 
			options: [
				{ name: 'Extrovert', description: 'I’m a social butterfly!', emoji: '🦋' }, 
				{ name: 'Introvert', description: 'I prefer Netflix and chill.', emoji: '🛋️' },
			],
		},
		{ 
			title: 'Landscape', 
			description: 'Do you prefer peak pursuits or sandy toes?', 
			options: [
				{ name: 'Mountains', description: 'I’m a mountain goat.', emoji: '🏔️' }, 
				{ name: 'Beach', description: 'I’m a beach bum.', emoji: '🏖️' },
			],
		},
		{ 
			title: 'Entertainment', 
			description: 'Do you prefer a page-turner or the silver screen?', 
			options: [
				{ name: 'Book', description: 'I’m a bookworm.', emoji: '📚' }, 
				{ name: 'Movie', description: 'I’m a movie buff.', emoji: '🎬' },
			],
		},
		{ 
			title: 'Snack Preference', 
			description: 'Do you crave a sugar rush or salt cravings?', 
			options: [
				{ name: 'Sweet', description: 'I have a sweet tooth.', emoji: '🍭' }, 
				{ name: 'Salty', description: 'I’m a savory snacker.', emoji: '🥨' },
			],
		},
		{ 
			title: 'Living Environment', 
			description: 'Do you thrive in an urban jungle or prefer a rural retreat?', 
			options: [
				{ name: 'City', description: 'I’m a city slicker.', emoji: '🏙️' }, 
				{ name: 'Countryside', description: 'I’m a country mouse.', emoji: '🏡' },
			],
		},
		{ 
			title: 'Communication', 
			description: 'Are you a more of phone yapper or a thumb tapper?',
			options: [
				{ name: 'Call', description: 'Ring ring!', emoji: '📞' }, 
				{ name: 'Text', description: 'I’m a thumb warrior.', emoji: '📱' },
			],
		},
		{ 
			title: 'Ice Cream Flavor', 
			description: 'Do you have cocoa dreams or vanilla vibes?', 
			options: [
				{ name: 'Chocolate', description: 'I’m a chocoholic.', emoji: '🍫' }, 
				{ name: 'Vanilla', description: 'I’m a vanilla bean lover.', emoji: '🍦' },
			],
		},
		{ 
			title: 'Vacation Style', 
			description: 'Are you a thrill-seeker or a zen master on vacation?', 
			options: [
				{ name: 'Adventure', description: 'I’m an adventure junkie.', emoji: '🏄‍♂️' }, 
				{ name: 'Relaxation', description: 'I’m a relaxation guru.', emoji: '🧘‍♀️' },
			],
		},
		{ 
			title: 'Life Planning', 
			description: 'Are you a spreadsheet wizard or a go-with-the-flow guru?', 
			options: [
				{ name: 'Planner', description: 'I’m a planning pro.', emoji: '📅' }, 
				{ name: 'Spontaneous', description: 'I’m a spontaneity champion.', emoji: '🎲' },
			],
		},
		{ 
			title: 'Work Environment', 
			description: 'Do you prefer a pajama party or office gossip?', 
			options: [
				{ name: 'WFH', description: 'I have a home sweet home office.', emoji: '🏠' }, 
				{ name: 'Office', description: 'I’m a cubicle dweller.', emoji: '🏢' },
			],
		},
		{ 
			title: 'Pizza Topping', 
			description: 'What is your stance on pineapple on pizza: yay or nay?', 
			options: [
				{ name: 'Pineapple', description: 'I’m a tropical pizza lover.', emoji: '🍍' }, 
				{ name: 'No Pineapple', description: 'I’m a pizza purist.', emoji: '🍕' },
			],
		},
		{ 
			title: 'Morning Routine', 
			description: 'Are you a chirpy morning lark or a sleepy sloth?', 
			options: [
				{ name: 'Early Riser', description: 'I’m up with the sun!', emoji: '🌞' }, 
				{ name: 'Late Sleeper', description: 'I’m a snooze button champion.', emoji: '😴' },
			],
		},
		{ 
			title: 'Movie Genre', 
			description: 'Do you prefer an adrenaline rush or belly laughs?', 
			options: [
				{ name: 'Action', description: 'I’m an action hero wannabe.', emoji: '💥' }, 
				{ name: 'Comedy', description: 'I’m a comedy connoisseur.', emoji: '😂' },
			],
		},
		{ 
			title: 'Decision Making', 
			description: 'Are you an impulsive adventurer or a meticulous mastermind?', 
			options: [
				{ name: 'Spontaneous', description: 'I have a spontaneous spirit.', emoji: '🎭' }, 
				{ name: 'Planner', description: 'I’m a planning perfectionist.', emoji: '🗓️' },
			],
		},
		{ 
			title: 'Shopping Preference', 
			description: 'Do you prefer couch surfing or mall crawling?', 
			options: [
				{ name: 'Online', description: 'I prefer to click and ship.', emoji: '💻' }, 
				{ name: 'In Store', description: 'I’m a retail therapy enthusiast.', emoji: '🛍️' },
			],
		},
	]


	// Internal state
	const answers = $state(
		Array(questions.length)
			.fill(undefined)
	)
</script>


<form
	onsubmit={(e) => {
		e.preventDefault()
		console.log(answers)
	}}
>
	{#each questions as question, index}
		<section>
			<h3>{question.title}</h3>

			<p>{question.description}</p>

			<div class="choices">
				{#each question.options as option}
					<label>
						<input
							type="radio"
							name={`question${index}`}
							value={option.name}
							bind:group={answers[index]}
						/>
						<span><span class="emoji">{option.emoji}</span> {option.description}</span>
					</label>
				{/each}
			</div>
		</section>
	{/each}

	<footer>
		<button type="submit">Submit</button>
	</footer>
</form>


<style>
	section,
	footer {
		padding: 1.5rem;
		display: grid;
		gap: 1rem;
	}

	section {
		transition: background-color 0.3s;

		&:focus-within {
			background-color: rgba(237, 241, 245, 0.524);
		}

		.choices {
			display: grid;
			grid-auto-flow: column;
			grid-template-columns: 1fr 1fr;
		}
	}

	label {
		cursor: pointer;
		display: flex;
		align-items: center;

		& > span {
			display: flex;
			align-items: center;
			padding: 1rem;
			background-color: #f0f0f0;
			border-radius: 8px;
			box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
			transition: background-color 0.3s ease;
			width: 100%;

			.emoji {
				font-size: 1.5em;
			}
		}

		&:hover > span {
			background-color: #e0e0e0;
		}

		input[type="radio"] {
			position: absolute;
			opacity: 0;
			pointer-events: none;

			&:checked + span {
				background-color: #ccdfff;
				font-weight: bold;
			}
		}
	}

	button[type="submit"] {
		background-color: #4CAF50;
		border: none;
		color: white;
		padding: 0.75em 1.25em;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 1em;
		margin: 0.25em 0.125em;
		cursor: pointer;
		border-radius: 3.125em;
		transition: background-color 0.3s ease;

		&:hover {
			background-color: #45a049;
		}

		&:focus {
			outline: none;
			box-shadow: 0 0 0 0.1875em rgba(76, 175, 80, 0.5);
		}
	}
</style>
