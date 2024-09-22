import { wrap } from '@oasisprotocol/sapphire-paratime'

if(globalThis.ethereum)
	globalThis.ethereum = wrap(globalThis.ethereum)
