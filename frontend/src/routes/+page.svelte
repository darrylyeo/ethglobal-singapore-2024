<script lang="ts">
	// Constants
	const questions = [
		{ 
			title: 'Pets', 
			description: 'Fluffy felines or playful pups?', 
			options: [
				{ name: 'Cats', description: 'Team Meow' }, 
				{ name: 'Dogs', description: 'Team Woof' },
			],
		},
		{ 
			title: 'Sleep Schedule', 
			description: 'Rise and shine or night owl vibes?', 
			options: [
				{ name: 'Morning', description: 'Early bird catches the worm' }, 
				{ name: 'Night', description: 'Midnight oil burner' },
			],
		},
		{ 
			title: 'Hot Drink', 
			description: 'Java jolt or leaf water?', 
			options: [
				{ name: 'Coffee', description: 'Coffee addict' }, 
				{ name: 'Tea', description: 'Tea enthusiast' },
			],
		},
		{ 
			title: 'Season', 
			description: 'Sizzling sun or winter wonderland?', 
			options: [
				{ name: 'Summer', description: 'Beach bum' }, 
				{ name: 'Winter', description: 'Snow bunny' },
			],
		},
		{ 
			title: 'Personality', 
			description: 'Party animal or cozy hermit?', 
			options: [
				{ name: 'Extrovert', description: 'Social butterfly' }, 
				{ name: 'Introvert', description: 'Netflix and chill' },
			],
		},
		{ 
			title: 'Landscape', 
			description: 'Peak pursuits or sandy toes?', 
			options: [
				{ name: 'Mountains', description: 'Mountain goat' }, 
				{ name: 'Beach', description: 'Beach bum' },
			],
		},
		{ 
			title: 'Entertainment', 
			description: 'Page-turner or silver screen?', 
			options: [
				{ name: 'Book', description: 'Bookworm' }, 
				{ name: 'Movie', description: 'Movie buff' },
			],
		},
		{ 
			title: 'Snack Preference', 
			description: 'Sugar rush or salt cravings?', 
			options: [
				{ name: 'Sweet', description: 'Sweet tooth' }, 
				{ name: 'Salty', description: 'Savory snacker' },
			],
		},
		{ 
			title: 'Living Environment', 
			description: 'Urban jungle or rural retreat?', 
			options: [
				{ name: 'City', description: 'City slicker' }, 
				{ name: 'Countryside', description: 'Country mouse' },
			],
		},
		{ 
			title: 'Communication', 
			description: 'Chatty Cathy or text ninja?', 
			options: [
				{ name: 'Call', description: 'Ring ring' }, 
				{ name: 'Text', description: 'Thumb warrior' },
			],
		},
		{ 
			title: 'Ice Cream Flavor', 
			description: 'Cocoa dreams or vanilla vibes?', 
			options: [
				{ name: 'Chocolate', description: 'Chocoholic' }, 
				{ name: 'Vanilla', description: 'Vanilla bean' },
			],
		},
		{ 
			title: 'Vacation Style', 
			description: 'Thrill-seeker or zen master on vacay?', 
			options: [
				{ name: 'Adventure', description: 'Adventure junkie' }, 
				{ name: 'Relaxation', description: 'Relaxation guru' },
			],
		},
		{ 
			title: 'Life Planning', 
			description: 'Spreadsheet wizard or go-with-the-flow guru?', 
			options: [
				{ name: 'Planner', description: 'Planning pro' }, 
				{ name: 'Spontaneous', description: 'Spontaneity champion' },
			],
		},
		{ 
			title: 'Work Environment', 
			description: 'Pajama party or office gossip?', 
			options: [
				{ name: 'WFH', description: 'Home sweet home office' }, 
				{ name: 'Office', description: 'Cubicle dweller' },
			],
		},
		{ 
			title: 'Pizza Topping', 
			description: 'Pineapple on pizza: yay or nay?', 
			options: [
				{ name: 'Pineapple', description: 'Tropical pizza lover' }, 
				{ name: 'No Pineapple', description: 'Pizza purist' },
			],
		},
		{ 
			title: 'Morning Routine', 
			description: 'Chirpy morning lark or sleepy sloth?', 
			options: [
				{ name: 'Early Riser', description: 'Up with the sun' }, 
				{ name: 'Late Sleeper', description: 'Snooze button champion' },
			],
		},
		{ 
			title: 'Movie Genre', 
			description: 'Adrenaline rush or belly laughs?', 
			options: [
				{ name: 'Action', description: 'Action hero wannabe' }, 
				{ name: 'Comedy', description: 'Comedy connoisseur' },
			],
		},
		{ 
			title: 'Decision Making', 
			description: 'Impulsive adventurer or meticulous mastermind?', 
			options: [
				{ name: 'Spontaneous', description: 'Spontaneous spirit' }, 
				{ name: 'Planner', description: 'Planning perfectionist' },
			],
		},
		{ 
			title: 'Shopping Preference', 
			description: 'Couch surfing or mall crawling?', 
			options: [
				{ name: 'Online', description: 'Click and ship' }, 
				{ name: 'In Store', description: 'Retail therapy enthusiast' },
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
			<h3>{question.description}</h3>

			<div class="choices">
				{#each question.options as option}
					<label>
						<input
							type="radio"
							name={`question${index}`}
							value={option.name}
							bind:group={answers[index]}
						/>
						<span>{option.description}</span>
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

		span {
			display: flex;
			align-items: center;
			padding: 1rem;
			background-color: #f0f0f0;
			border-radius: 8px;
			box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
			transition: background-color 0.3s ease;
			width: 100%;
		}

		&:hover span {
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
