<svelte:head>
	<title>Load Data</title>
	<meta name="description" content="Load Data" />
</svelte:head>

<div class="mt-4 p-5 bg-secondary-subtle rounded">
    <section>
          <div class="row align-items-start">
            <div class="col">
                <div>
                    <pre id="json"></pre>
                </div>
            </div>
            <div class="col">
                <h1>SQLChk Load</h1>
                <h2>Load Data into DB</h2>
                <div>
                    <label class="form-label" for="uri">Uri</label>
                    <input class="form-control" type="text" id="uri" bind:value={queryuri} />
                </div>
                <div class="input-group">
                    <input class="form-control" placeholder="key" type="text" id="key" bind:value={keyinput}>
                    <input class="form-control" placeholder="Value"type="text" id="value" bind:value={valueinput}>
                </div>
                <Button on:click={addtoobj}>add to object</Button>
            </div>
            <div class="col">
                <div>
                    {#each $store.entries as [key, value]}
                        <div>{key}: {value} <button class="btn btn-sm btn-danger" on:click={removekey(key)} >X</button></div>
                    {/each}
                </div>
            </div>
        </div>
        <Button on:click={sendtoapi}>Send to Db</Button>
    </section>
</div>

<script>
    import { onMount } from 'svelte';
   import { createMapStore } from './MapStore.svelte';
   import Button from './button.svelte';
   let queryuri = "/data?table=t";
   let keyinput = "";
   let valueinput = "";
   let state = {};
   const store = createMapStore({});
   export function add(key,value){
        $store.set(key,value)
   }

   export function rerender(){
        state = objectifyStoreState($store.entries)
        document.getElementById("json").textContent = JSON.stringify(state, undefined, 2);
   }

    export function dumpstore(){
        return JSON.stringify($store.entries)
    }
    
    export function clearArray() {
     for  (let i = 0; i < $store.entries.length; i++) {
         let k = $store.entries[i][0]
         removekey(k)
     }
    }
   function addtoobj(event){
        console.log(queryuri)
        console.log(dumpstore())
        console.log("$store.entries")
        $store.set(keyinput,valueinput)
        rerender()
        keyinput = "";
        valueinput = "";
    }

    function sendtoapi(event){
        state = objectifyStoreState($store.entries)
        if (Object.keys(state).length === 0) {
            alert("state is empty")
            return
        }
        console.log(state);
        console.log(queryuri);

        let options = {
            method: 'POST',
            headers: {
                'Content-Type':
                    //'application/json;charset=utf-8'
                    'application/json'
            },
            body: JSON.stringify(state)
        }
        fetch(queryuri,options)
          .then(res =>
            res.text())
          .then(d => {
            console.log("rest")
            console.log(d)
            console.log("entries")
            clearArray()
            rerender()
        })
        
    }

    function objectifyStoreState(v){
        var out = {}
        for (let i = 0; i < v.length; i++) {
            out[v[i][0]] = v[i][1];
        }   
        return out
    }
    function removekey(key){
        $store.remove(key);
        rerender()
    }
    onMount(async () => {
		    document.getElementById("json").textContent = JSON.stringify({}, undefined, 2);
	});
</script>
