<svelte:head>
	<title>Landing Page</title>
	<meta name="description" content="Svelte demo app for interview" />
</svelte:head>

<section>
	<h1>
		<span class="welcome">
			Hello!
		</span>

		I'm Using <br />SvelteKit app
	</h1>
</section>

<style>
	section {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}

	h1 {
		width: 100%;
	}

	.welcome {
		display: block;
		position: relative;
		width: 100%;
		height: 0;
		padding: 0 0 calc(100% * 495 / 2048) 0;
	}

</style>
