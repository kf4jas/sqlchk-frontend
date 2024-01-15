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

<div class="text-column">
    <h1>SQL Load</h1>

    <section>
        <h2>Add to the Database (uri)</h2>
        <div>
            <label for="uri">Uri</label>
            <input type="text" id="uri" bind:value={queryuri} />
            <div>
                {#each $store.entries as [key, value]}
                    <div>{key}: {value} <button on:click={() => $store.remove(key)} >Delete</button></div>
                {/each}

                Key:<input type="text" id="key" bind:value={keyinput}><br />
                Value: <input type="text" id="value" bind:value={valueinput}><br />
                <Button on:click={addtoobj}>add to object</Button>
                <pre id="json"></pre>
            </div>
        </div>
        <Button on:click={sendtoapi}>Send to Db</Button>    
    </section>
</div>
