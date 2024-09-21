<script lang="ts">
	// Constants
	const questions = [
		{ text: 'Cats or dogs?', options: ['Cats', 'Dogs'] },
		{ text: 'Morning person or night owl?', options: ['Morning person', 'Night owl'] },
		{ text: 'Coffee or tea?', options: ['Coffee', 'Tea'] },
		{ text: 'Summer or winter?', options: ['Summer', 'Winter'] },
		{ text: 'Introvert or extrovert?', options: ['Introvert', 'Extrovert'] },
		{ text: 'Mountains or beach?', options: ['Mountains', 'Beach'] },
		{ text: 'Book or movie?', options: ['Book', 'Movie'] },
		{ text: 'Sweet or salty snacks?', options: ['Sweet', 'Salty'] },
		{ text: 'City or countryside?', options: ['City', 'Countryside'] },
		{ text: 'Phone call or text?', options: ['Phone call', 'Text'] },
		{ text: 'Chocolate or vanilla?', options: ['Chocolate', 'Vanilla'] },
		{ text: 'Adventure or relaxation on vacation?', options: ['Adventure', 'Relaxation'] },
		{ text: 'Plan everything or go with the flow?', options: ['Plan everything', 'Go with the flow'] },
		{ text: 'Work from home or work in an office?', options: ['Work from home', 'Work in an office'] },
		{ text: 'Pizza with pineapple or without?', options: ['With pineapple', 'Without pineapple'] },
		{ text: 'Early riser or sleep in?', options: ['Early riser', 'Sleep in'] },
		{ text: 'Action movies or comedies?', options: ['Action movies', 'Comedies'] },
		{ text: 'Spontaneous or a planner?', options: ['Spontaneous', 'Planner'] },
		{ text: 'Online shopping or in-store shopping?', options: ['Online shopping', 'In-store shopping'] },
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
			<h3>{question.text}</h3>

			<div class="choices">
				<label>
					<input
						type="radio"
						name={`question${index}`}
						value={question.options[0]}
						bind:group={answers[index]}
					/>
					<span>{question.options[0]}</span>
				</label>

				<label>
					<input
						type="radio"
						name={`question${index}`}
						value={question.options[1]}
						bind:group={answers[index]}
					/>
					<span>{question.options[1]}</span>
				</label>
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
