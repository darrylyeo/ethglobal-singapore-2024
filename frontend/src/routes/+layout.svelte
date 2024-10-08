<script lang="ts">
	// Context
	import { browser } from '$app/environment'


	// Inputs
	let {
		children,
	} = $props()


	// Functions
	const _wrap = (provider) => (
		new Proxy(
			wrap(provider),
			{
				get(target, prop) {
					if (prop === 'removeListener') {
						// return () => {}
						return Reflect.get(target, prop)
					}
					return Reflect.get(target, prop)
				}
			}
		)
	)


	// Internal state
	import type { AppKit, CaipNetwork, Provider } from '@reown/appkit'
	import { watchAccount, type Config } from '@wagmi/core'

	let appKit: AppKit | undefined = $state()
	let wagmiConfig: Config | undefined = $state()

	$effect(() => {
		if(browser && globalThis.ethereum)
			globalThis.ethereum = _wrap(globalThis.ethereum)
	})

	$effect(() => {
		if(browser) (async () => {
			const { WagmiAdapter } = await import('@reown/appkit-adapter-wagmi')
			const { createAppKit } = await import('@reown/appkit')

			const networks: CaipNetwork[] = [
				// {
				// 	id: 'eip155:23294',
				// 	chainId: 23294,
				// 	chainNamespace: 'eip155',
				// 	name: 'Oasis Sapphire',
				// 	currency: 'ROSE',
				// 	explorerUrl: 'https://explorer.sapphire.oasis.io',
				// 	rpcUrl: 'https://sapphire.oasis.io',
				// 	imageUrl: 'https://avatars.githubusercontent.com/u/52803776',
				// 	imageId: undefined,
				// },
				{
					id: 'eip155:23295',
					chainId: 23295,
					chainNamespace: 'eip155',
					name: 'Oasis Sapphire Testnet',
					currency: 'ROSE',
					explorerUrl: 'https://testnet.explorer.sapphire.oasis.io',
					rpcUrl: 'https://testnet.sapphire.oasis.io',
					imageUrl: 'https://avatars.githubusercontent.com/u/52803776',
					imageId: undefined,
				},
			]

			const projectId = import.meta.env.VITE_PROJECT_ID

			const wagmiAdapter = new WagmiAdapter({
				networks,
				projectId,
			})

			wagmiConfig = wagmiAdapter.wagmiConfig

			if(wagmiConfig._internal.mipd){
				const originalGetProviders = wagmiConfig._internal.mipd.getProviders

				wagmiConfig._internal.mipd.getProviders = () => {
					console.log('getProviders')
					const providers = originalGetProviders()

					return providers.map(providerDetail => ({
						...providerDetail,
						provider: _wrap(providerDetail.provider)
					}))
				}
			}

			appKit = createAppKit({
				adapters: [
					wagmiAdapter
				],
				metadata: {
					name: 'Html Example',
					description: 'Html Example',
					url: 'https://reown.com/appkit',
					icons: ['https://avatars.githubusercontent.com/u/37784886'],
				},
				networks,
				projectId,
				themeMode: 'light',
			})
		})()
	})

	let provider: Provider | undefined = $state()

	$effect(() => {
		if(!wagmiConfig) return

		watchAccount(wagmiConfig, {
			onChange: async account => {
				// provider = await account.connector?.getProvider?.() as Provider | undefined

				if(account.connector){
					const { getProvider } = account.connector

					account.connector.getProvider = async (...args) => {
						const provider = await getProvider(...args)
						return _wrap(provider)
					}
				}
			},
		})
	})

	// $effect(() => {
	// 	provider = appKit?.getProvider()

	// 	appKit?.subscribeProvider(({ provider: _ }) => {
	// 		provider = _
	// 	})
	// })


	import { wrap } from '@oasisprotocol/sapphire-paratime'

	let wrappedProvider = $derived(
		provider && (
			_wrap(provider)
		)
	)


	// Context
	import { setContext } from 'svelte'
	import { writable } from 'svelte/store'

	const wagmiConfigStore = writable<typeof wagmiConfig>(wagmiConfig)
	$effect(() => { wagmiConfigStore.set(wagmiConfig) })
	setContext('wagmiConfig', wagmiConfigStore)
	
	const wrappedProviderStore = writable<typeof wrappedProvider>(wrappedProvider)
	$effect(() => { wrappedProviderStore.set(wrappedProvider) })
	setContext('wrappedProvider', wrappedProviderStore)


	// TanStack Query
	import { QueryClient, QueryClientProvider } from '@tanstack/svelte-query'

	const queryClient = new QueryClient()


	// Styles
	import '../global.css'
	import '../fonts.css'
</script>


<QueryClientProvider
	client={queryClient}
>
	<header class="row">
		<div class="row">
			<a href="/"><h1>🌴 Watering Hole</h1></a>

			<nav class="row">
				<a href="/">Questionnaire</a>
				<a href="/matches">Matches</a>
			</nav>
		</div>

		<div class="row">
			<w3m-network-button></w3m-network-button>
			<w3m-button></w3m-button>
		</div>
	</header>

	<main>
		{@render children()}
	</main>
</QueryClientProvider>


<style>
	:global(body) {
		background-color: rgb(230, 238, 255);
	}

	header {
		padding: 1rem;

		& > :first-child {
			gap: 1.5em;
		}

		nav {
			gap: 1em;
		}

		a {
			color: inherit;

			&:hover {
				color: lightblue;
			}
		}
	}
</style>
