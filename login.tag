<login> 
	<form> 
		<div class="input-group {'has-error':usrError}">  
			<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
			<input type="text" class="form-control" placeholder="Email" ref="usr"> 
		</div> 
		<div class="input-group {'has-error':pwdError}">
			<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
			<input type="password" class="form-control" placeholder="Password" ref="pwd">
		</div>
		<button type="button" class="btn btn-primary" onclick="{authorize}">Login</button>  
	</form>

	<script>
		const base = ''
		this.user = ''

		this.authorize = ()=>{ 
			this.err =str=> {
				if(this.refs[str].value==''){
					this[str+'Error'] = true
					return true 
				}
				this[str+'Error'] = false 
				return false
			}
			if(this.err('usr') || this.err('pwd'))
				return;  
			
 			this.pwd = this.refs.pwd.value

			// fetch(base+'/?auth='+this.user)
			// 	.then(res=> this.auth = true )
			 
			// fetch(base+'/?usr='+decodeURI(this.refs.usr.value)+'&pwd='+this.refs.pwd.value)
			// .then(res => { 
				//if(res.body=='OK')
				setTimeout(()=>{ 
					this.parent.update({ showSelectors:true, logged:true})
				},500)
			// })
		}
		this.on('update',()=>{ 
			if(this.parent.user===false){ 
				for(k in this.refs)
					this.refs[k].value = ''
 
				// fetch(`${base}/?logout=${this.user}`)
				// .then(res=>{
				// 	if(res.status==200){
				// 		this.refs.user.value = ''
				// 		this.refs.pwd = ''
				// 	}else
				// 		console.error('Failed to logout')
				// })
			}
		})

	</script>
	<style>
	:scope { position: fixed; top: 50%; left: 50%; display: block; transform: translate(-50%, -50%) }
	.input-group { width: 300px;}
	div {margin-bottom: 3px;}
	</style>
</login>