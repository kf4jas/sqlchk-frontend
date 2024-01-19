<script>
	import { page } from '$app/stores';
</script>

<header>
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
        <a class="navbar-brand text-end" href="/static/">SQL Checker</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item" aria-current={$page.url.pathname === '/' ? 'page' : undefined}>
                    <a class="nav-link" href="/static/">Home</a>
                </li>
                <li class="nav-item" aria-current={$page.url.pathname === '/load' ? 'page' : undefined}>
                    <a class="nav-link" href="/static/load/">Load Data</a>
                </li>
                <li class="nav-item" aria-current={$page.url.pathname.startsWith('/lookup') ? 'page' : undefined}>
                    <a class="nav-link" href="/static/lookup/">Get Data</a>
                </li>
            </ul>
        </div>
	</nav>
</header>

<style>
.navbar-brand {
    margin: auto;
    padding: 1em;
    width: 40%;
}

</style>
