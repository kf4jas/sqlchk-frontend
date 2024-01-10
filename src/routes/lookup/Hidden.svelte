<script>
    export let shown = false;
</script>

<svelte:options accessors={true}/>

{#if shown}
    <slot/>
{/if}
