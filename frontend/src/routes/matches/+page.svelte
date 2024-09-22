<script lang="ts">
	// Types
	import type { Config } from '@wagmi/core'
	import type { wrap } from '@oasisprotocol/sapphire-paratime';


	// Context
	import { getContext } from 'svelte'

	const wagmiConfig = getContext<SvelteStore<Config | undefined>>('wagmiConfig')
	const wrappedProvider = getContext<SvelteStore<ReturnType<typeof wrap> | undefined>>('wrappedProvider')


	// Internal state
	import { createQuery } from '@tanstack/svelte-query'
	import { readContract } from '@wagmi/core'

	const addressesQuery = createQuery({
		queryKey: ['uniqueAddresses'],
		queryFn: async () => {
			if (!$wagmiConfig) return []

			return readContract($wagmiConfig, {
				address: '0xEF4c65D1372D23a2635C2ed0D077bB5E4437cC1a',
				abi: [
					{
						inputs: [],
						name: 'getUniqueAddresses',
						outputs: [{ type: 'address[]' }],
						stateMutability: 'view',
						type: 'function',
					},
				],
				functionName: 'getUniqueAddresses',
			})
		},
	})

	let addresses = $derived($addressesQuery.data || [])

	const scoreQuery = $derived(
		createQuery({
			queryKey: ['compatibilityScores', {
				addresses,
			}] as const,
			enabled: $addressesQuery.isSuccess,
			queryFn: async ({
				queryKey: [_, {
					addresses,
				}],
			}) => {
				if(!$wagmiConfig) throw `Account not found.`

				return await Promise.all(
					addresses.map(async (address) => ({
						address,
						score: await readContract($wagmiConfig, {
							address: '0xEF4c65D1372D23a2635C2ed0D077bB5E4437cC1a',
							abi: [
								{
									inputs: [{ type: 'address', name: 'stranger' }],
									name: 'compatibilityScore',
									outputs: [{ type: 'uint8' }],
									stateMutability: 'view',
									type: 'function',
								},
							],
							functionName: 'compatibilityScore',
							args: [address],
						})
					}))
				)
			},
		})
	)

	let scores = $derived($scoreQuery.data || [])
</script>


<section>
	{#if $addressesQuery.isLoading || $scoreQuery.isLoading}
		<p>Loading...</p>
	{:else if $addressesQuery.isError || $scoreQuery.isError}
		<p>Error: {$addressesQuery.error?.message || $scoreQuery.error?.message}</p>
	{:else}
		<h2>Your Matches</h2>

		{#each (
			scores
				.map(item => ({
					...item,
					score: Math.floor(Math.random() * 21) * 5 // Random multiple of 5 between 0 and 100
				}))
				.sort((a, b) => b.score - a.score)
		) as { address, score }}
			<article>
				<img
					src={`https://api.cloudnouns.com/v1/pfp?text=${address}`}
					class="avatar"
				/>

				<div>
					<h3>{address}</h3>
					<div>
						Compatibility score: <mark class="score">{score}</mark>
					</div>
				</div>
			</article>
		{/each}
	{/if}
</section>


<style>
	section {
		padding: 1.5rem;
		display: grid;
		gap: 1rem;
	}

	article {
		display: flex;
		align-items: center;
		padding: 1rem;
		background-color: #f0f0f0;
		border-radius: 8px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		transition: background-color 0.3s ease;
		width: 100%;
	}

	.avatar {
		width: 50px;
		height: 50px;
		border-radius: 50%;
	}

	.score {
		font-size: 1.2em;
		color: #007bff;
	}
</style>
