<script>
   import { createMapStore } from './MapStore.svelte';
   import Button from './button.svelte';
   let queryuri = "/data?table=t";

   const store = createMapStore({
	});
    
    export function add(key,value){
        $store.set(key,value)
    }

    export function dumpstore(){
        return JSON.stringify($store.entries)
    }

    let keyinput = "";
    let valueinput = "";
    let state = {};
    
   function addtoobj(event){
        console.log(queryuri)
        console.log(dumpstore())
        console.log(keyinput)
        $store.set(keyinput,valueinput)
        state = objectifyStoreState($store.entries)
        document.getElementById("json").textContent = JSON.stringify(state, undefined, 2);
    
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
            console.log(d)
        })
        
    }

    function objectifyStoreState(v){
        var out = {}
        for (let i = 0; i < v.length; i++) {
            out[v[i][0]] = v[i][1];
        }   
        return out
    }
</script>

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
                        <div>{key}: {value} <button class="btn btn-sm btn-danger" on:click={() => $store.remove(key)} >X</button></div>
                    {/each}
                </div>
            </div>
        </div>
        <Button on:click={sendtoapi}>Send to Db</Button>    
    </section>
</div>
