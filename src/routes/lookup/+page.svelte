<script>
    import Output from './out.svelte'
    import Button from './button.svelte'
    import Table from './Table.svelte';
    import Hidden from './Hidden.svelte';
    import { sqlresults } from "./stores.js";
    
    let redStyle = "redTable";
	let blueStyle = "blueTable";
	let sqloutput = '';
	let sqlinput = 'select * from users;';
	let constrinput = 'postgresql://joee:password@localhost/joee?sslmode=require';
    let rows = [];
    let headers = [];
    let child;
    $sqlresults = [{ result : "No data" }];
    function getSQLResult(event){
        query = "/query?c="+encodeURI(constrinput)+"&q="+encodeURI(sqlinput)
        alert(query)
        var goodreq = true
        fetch(query)
            .then(function(res){ 
                if (res.ok) {
                    goodreq = true
                    return res.json()
                }
                return res.text();
            })
            .then(function(data){ 
                if (!goodreq) {
                    throw new Error(data)
                }
                if (Array.isArray(data.result) && data.result.length) {
                    $sqlresults = data.result
                } else {
                    $sqlresults = [{"Message":"No message"}]
                }

                alert( JSON.stringify( data ) )
            })
            .catch(error => {
                sqloutput = error
            })
    }

    function oldgetSQLResult(event){
        const newQuery = {
			query : sqlinput,
			constr : constrinput
		};
        var goodreq = false;
        fetch("/query",
        {
            headers: {
              "Content-Type": "application/json",
              // 'Content-Type': 'application/x-www-form-urlencoded',
            },
            method: "POST",
            body: JSON.stringify(newQuery)
        })
        .then(function(res){ 
            if (res.ok) {
                goodreq = true
                return res.json()
            }
            return res.text(); 
        })
        .then(function(data){ 
            if (!goodreq) {
                // console.log(data)
                throw new Error(data)
            }
            sqloutput = data.result
            alert( JSON.stringify( data ) )
        })
        .catch(error => {
            sqloutput = error
        })
	}
    function toggleHidden(){
        child.shown = !child.shown
    }

</script>

<style>
	h1 {
		color: purple;
		text-align:center;

	}

	section{
		margin: 1rem auto;
		width: 30rem;
	}

	label{
        width: 100%;
    }
	textarea{
        width: 100%;
        height: 50%;
    }
	input{
        width: 100%;
    }
    .shown {
		display: none;
	}
</style>

<svelte:head>
	<title>Application</title>
	<meta name="description" content="About this app" />
</svelte:head>

<div class="text-column">
<h1>SQL Lookup</h1>

<section>
	<h2>Query Database</h2>
	<div>
		<label for="constrinput">Connection String</label>
		<input type="text" id="constrinput" bind:value={constrinput} />
		<label for="query">Query</label>
        <textarea rows="10" id="query" bind:value={sqlinput}></textarea>
	</div>
    <Button on:click={getSQLResult}>query</Button>
</section>
<section>
    <button on:click={toggleHidden}>{child && child.shown ? 'Hide' : 'Show'}</button>
    <Hidden bind:this={child}>
        <Output sqlOutput={sqloutput}/>
    </Hidden>
    <Table tableData={$sqlresults} style={blueStyle}/>
</section>
</div>
