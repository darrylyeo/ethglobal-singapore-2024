<script lang="ts">
	// Context
	import { browser } from '$app/environment'


	// Inputs
	let {
		children,
	} = $props()


	// Internal state
	import type { AppKit, CaipNetwork, Provider } from '@reown/appkit'

	let appKit: AppKit | undefined = $state()

	$effect(() => {
		if(browser) (async () => {
			const { WagmiAdapter } = await import('@reown/appkit-adapter-wagmi')
			const { createAppKit } = await import('@reown/appkit')

			const networks: CaipNetwork[] = [
				{
					id: 'eip155:23294',
					chainId: 23294,
					chainNamespace: 'eip155',
					name: 'Oasis Sapphire',
					currency: 'ROSE',
					explorerUrl: 'https://explorer.sapphire.oasis.io',
					rpcUrl: 'https://sapphire.oasis.io',
					imageUrl: 'https://avatars.githubusercontent.com/u/52803776',
					imageId: undefined,
				},
			]

			const projectId = import.meta.env.VITE_PROJECT_ID

			appKit = createAppKit({
				adapters: [
					new WagmiAdapter({
						networks,
						projectId,
					}),
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


	// Styles
	import '../global.css'
	import '../fonts.css'
</script>


<header class="row">
	<h1>App</h1>

	<div class="row">
		<w3m-button></w3m-button>
		<w3m-network-button></w3m-network-button>
	</div>
</header>


{@render children()}


<style>
	header {
		padding: 1rem;
	}
</style>