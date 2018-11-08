<app>
	<carousel if={city} show={showCarousel} data={data}></carousel>
	<div class="centered" show={showSelectors}>
		<rg-select select={countriesList} api={api} ref="country"/>
		<rg-select select={citiesList} api={api} ref="city" />
		<button type="button" class="btn btn-primary" onclick={loadImages}>Continue</button>
		<button type="button" class="btn btn-warning" onclick={ user?logout:login }>{ user?'Logout':'Login' }</button>
	</div>
	<login hide={logged}></login>

	<script>
		const thres = 25
		const base = "."

		import { add } from 'bianco.events'
		import './carousel.tag'
		import './rg-select.tag'
		import './login.tag'

		this.api = riot.observable()		
		this.api.on('selected', t=>{
			this[t.type+'Changed'](t.item)
		})
		this.logged = false
		this.data = {} 
		
		var countriesAll = [ 
			{ name:"UK", cities:[{name:"Swindon"},{name:'Abcd'}] },  
			{ name:"NZ", cities:[{name:"Greymouth"},{name :"Whangarei"}] }  
	 	] 
		this.countriesList = {placeholder: 'Select a country', filter: 'name', options: countriesAll }
		this.citiesList = {	placeholder: 'Select a location', filter: 'name', options: [] } 
		    
 		this.countryChanged = t =>{ 
 			this.country = t 
			this.citiesList.options = this.country.cities 
			this.refs.city.curr =''
 		}
		this.cityChanged = t =>	this.city = t.name;

		this.loadImages= ()=>{ 
			let res={"pages":[[{"img":"244.jpg","cap":"City Meeting Room"},{"img":"Swindon Interchange Map.png","cap":"Interchange"}],[{"img":"0-0.jpg","cap":"<strong>BROWN</strong>  <i><nobr>(Guy* - Reigate)</nobr></i> <nobr><strong>Andy&Kate</strong></nobr> <i>< nobr>(Malcolm Lynes* - Reigate)</nob r></i> <br /><nobr>Rhain m (Dereham)Zo� m Dan Norman (Local)Gemma m Donovan Clarke (Gothenburg, Sweden)Sofia m Glen Smith (Luton)</nobr>"},{"img":"0-1.jpg", "cap":"<strong>COOK</strong>  <i><nobr>(Dennis* - Local)</nobr></i> <nobr><strong>Der ek&Glenda</strong></nobr> <i><nobr>(Ray Hattingh* -  Johannesburg)</nobr></i> <br /><nobr>Kerry m Nathan Whiteside (Local)Douglas m (Stow)Roz m Charlie Turner (Chippenham)</nobr><br /><nobr ><strong>Tatiana</strong> 05/01</nobr>"}],[{"img":"1-0.jpg","cap":"<div style=\"padding-bottom: 1em;\"><strong>COOK</strong> <nobr><strong>Mrs Jenny</strong></nobr>  <i><nobr>(Albert Pratt* - Bristol)</nobr></i> <br /><nobr>Husband Dennis <i><nobr>(Fred* - Johannesburg)</nobr></i>  - Taken 12/13</nobr><br /><nobr>1<sup>st</sup>  wife  Joan  <i><nobr>(Harold Stevenson* - Cape Town)</nobr></i>  - Taken 05/05</nobr><br /><nobr>Gwynn m Andy Preston (Local)Derek m</nobr><br /></nobr>1<sup>st</sup> husband William Angrave <i><nobr>(Fred* - Bath)</nobr></i> - Taken 08/94</nobr><br /></nobr>Willam's 1st wife Pam (Worrall - Bristol) Taken 11/65,</nobr><br /></nobr>Sue m  Tim Ryall (Farnham), Janet m Duncan Small (Bristol)"},{"img":"1-1.jpg","cap":"<strong>DIBLE</strong>  <i><nobr>(Phil - Local)</nobr></i> <nobr><strong>Derrick&Hanna</strong></nobr> <i><nobr>(Chris Pittock - Local)</nobr></i> <br /><nobr><strong>Moya</strong> 04/13<strong>Marl a</strong> 07/17</nobr>"}],[{"img":"2-0.jpg","cap":"<strong>DIBLE</st rong>  <i><nobr>(Robert - Local)</nobr></i> <nobr><strong>Phil&Kathy</strong></nobr> <i><nobr>(John Hicks* - Bexley)</nobr></i> <br /><nobr>Mr Matt Smith (Doncaster)Nick m (Hereford)Louanna m Matthew Preston (Local)Derrick mSophie m Douglas Cook (Stow)</nobr>"},{"img":"2-1.jpg","cap":"<strong>DIBLE</strong>  <i><nobr>(Robert - Local)</nobr></i> <no br><strong>Richard&Rachael</strong></nobr> <i><nobr>(Roy Beesley* - Bour nemouth)</nobr></i> <br /><nobr>Sandra m Roger Jones (Gloucester)Ross mGeorgina m Mathias Gunnarsson (Sm�landsstenar)</nobr><br /><nobr><strong>Olivia</strong><strong>Camilla</strong></nobr>"}],[ {"img":"3-0.jpg","cap":"<div style=\"padding-bottom: 1em;\"><strong>DIBLE</strong>  <i><nobr>(Cyril* - Salisbury)</nobr></i> <nobr><strong>Robert&Greta</strong></nobr> <i><nobr>(Geoffrey Lamming* - Trowbridge)</nobr>< /i> <br /><nobr>1<sup>st</sup>  wife  Shirley  <i><nobr>(Haldane - Glasgow)</nobr></i>  - Taken 12/07</nobr><br />< nobr>Richard mPhil mTina m Chris Pocock (Chippenham)Alison 12/03/64 - Taken 22/03/64Michael m (Chippenham)</nobr><br /><nobr>Greta's 1<sup>st</sup>  husband  Les Gear - Taken 08/08</nobr><br /></nobr><nobr>Graham m (Woodstock)Richard m (Stow)Mrs Hilary Gear (Bedford)</nobr><br /><nobr >Les's 1<sup>st</sup> wife Grace</nobr> <i><nobr>(Tom Herbert* - Cirencester)</nobr></i> - Taken 05/60: <nobr>Stuart m (Gloucester)Priscilla m Richard White (Columbus)</nobr>"},{"img":"3-1.jpg","cap":"<strong>DIBLE</strong>  <i><nobr>(Richard - Local)</nobr></i> <nobr><strong>Ross&Claudine</strong></nobr> <i><nobr>(Ray Ponsford* - Gloucester)</nobr></i> <br /><nobr><strong>Oscar</stro ng> 09/14<strong>Portia</strong> 04/06<strong>Chantelle</strong> 04/03</nobr>"}],[{"img":"4-0.jpg","cap":"<strong>FARR</strong>   <i><nobr>(John* - Bristol)</nobr></i> <nobr><strong>Duncan&Saskia</strong></nobr> <i><nobr >(Cedric Leflaive - Bristol)</nobr></i> <br /><nobr><strong>Tora</strong> 12/12<strong>Maxwell</strong> 06/14</nobr>"},{"img":"4-1.jpg","cap":"<strong>GILLINGHAM</strong>  <i><nobr>(Mrs Vera* - Local)</nobr></i> <nobr><strong>Andrew&Barbara</strong></nobr> <i><nobr>(Geoffrey Lamming* - Trowbridge)</nobr></i> "}],[{"img":"5-0.jpg","cap":"<div style=\"padding-bottom: 1em;\"><strong>HARRIS</strong> <nobr><strong>Mrs Daphne</strong></nobr>  <i><no br>(Frederick Lewis* - Broad Hinton)</nobr></i> <br /><nobr>Husband Don <i><nobr>(Charles* - Exeter)</nobr></i>  - Taken 06/01</nobr><br /><nobr>1<sup>st</sup>  wife  Doreen  <i><nobr>(Constant Hannen* - London)</nobr></i>  - Taken  09/84</nobr><br /><nobr>Yvonne m Bob Byne (Grangemouth)William 08/59 - Taken 09/59</nobr><br /><nobr>1<sup>st</sup>  husband  Henry Palmer <i><nobr>(John* - Cheltenham)</nobr></i>  - Taken 10/84 </nobr><br /><nobr>Henry's 1st wife Alice (Hamlin - Cheltenham) - Taken 11/67 - Edna - Taken 03/16 m John Page* (Bristol)</nobr> "},{"img":"5-1.jpg","cap":"<strong>LEWIS</strong>  <i><nobr>(Peter - Local)</nobr ></i> <nobr><strong>Daniel&Emma</strong></nobr> <i><nobr>(Paul Harris - Gloucester)</nobr></i> <br /><nobr><strong>Archie</strong> 08/00<strong>Lauretta</strong> 02/08<strong>Ted</strong> 11/02</nobr>"}],[{"img":"6-0.jpg","cap":"<strong>LEWIS</strong> <nobr><strong>Mr Peter</strong></nobr>  <i><nobr>(Frederick* - Broad Hinton)</nobr></i> <br /><nobr>Wife Janet <i><nobr>(Roy Herrington* - Local)</nobr></i>  - Taken 03/09</nobr><br /><nobr>Daniel m</nobr><br /><nobr><s trong>Gemma</strong></nobr>"},{"img":"6-1.jpg","cap":"<strong>LEWIS</strong> <nobr><strong>Mr Roy</strong></nobr> <br /><nobr>Father Frederick - Taken 04/54</nobr> <nobr>Mother Doris -  T aken 02/91</nobr> "}],[{"img":"7-0.jpg","cap":"<strong>NORMAN</strong>  <i><nobr>(David* - Yeovil)</nobr></i> <nobr><strong>Dan&Zo�</strong></nobr> <i><nobr>(Andy Brown - Local)</nobr></i> <br /><nobr><strong>Antonia</strong> 12/02<strong>Aldwyn</strong> 11/09<strong>Bryn</strong> 09/01</nobr>"},{"img":"7-1.jpg","cap":"<strong>PAINTER</strong>  <i><nobr>(Tim - Local)</nobr></i> <nobr><strong>Matthew&Becca</strong></nobr> <i><nobr>(Cedric Leflaive - Bristol)</nobr></i> <br /><nobr><strong> Zadok</strong> 10/12</nobr>"}],[{"img":"8-0.jpg","cap":"<strong>PAINTER</strong>   <i><nobr>(David* - Local)</nobr></i> <nobr><strong>Robin&Jacqui</strong></nobr> <i><nobr> (Peter Preston - Local)</nobr></i> <br /><nobr><strong>Jethro</strong> 01/11<strong>Narelle</strong> 09/01<strong>Kinsleigh</strong> 03/03<strong>Adelheid</strong> 12/05<strong>Ornan</strong> 08/12</nobr>"},{"img":"8-1.jpg","cap":"<strong>PAINT ER</strong>  <i><nobr>(David* - Local)</nobr></i> <nobr><strong>Stephen&L ois</strong></nobr> <i><nobr>(John Huntley - Bristol)</nobr></i> "}],[{"img":"9-0.jpg","cap":"<strong>PAINTER</strong>  <i><nobr>(David* - Local)</nobr></i> <nobr><strong>Tim&Rhoda</strong ></nobr>  <i><nobr>(Stephen Simmons - Local)</nobr></i> <br /><nobr>Matthew m</nobr><br /><nobr><strong>Bethany</strong> 03/02<strong>Jonas</strong></nobr>"},{"img":"9-1.jpg","cap":"<strong>PITTOCK</strong>  <i><nobr>(John* - Sutton/Mrs Myra - Aldeburgh)</nob r></i> <nobr><strong>Chris&Esther</strong></nobr> <i><nobr>(David Norman* - Yeovil)</nobr></i> <br /><nobr>Hanna m Derrick Dible (Local)Tim mTom m</nobr>"}],[{"img":"10-0.jpg"  ,"cap":"<strong>PITTOCK</strong>  <i><nobr>(Chris - Local)</nobr></i> <nobr><strong>Tim&Victoria</strong></nobr> <i><nobr>(Michael Dible - Chippenham)</nobr></i> <br /><nobr><strong>Dulcie-Ella</strong> 11/17<strong>Wynslo</strong>  03/15</nobr>"},{"img":"10-1.jpg","cap":"<strong>PITTOCK</strong>  <i><nobr>(Chris - Local)</nobr></i> <nobr><strong>Tom&Georgia</strong></nobr> <i><nobr>(Richard Lynes - Horsham)</nobr></i> "}],[{"img":"11-0.jpg","cap":"<strong>POMEROY</strong>  <i><nobr>(William* - Local)</nobr></i> <nobr><strong>Andrew&Susan</strong></nobr> <i><nobr>(Mrs Hazel Guest* - Southampton)</nobr></i> <br /><nobr>Nicky m Paul Webber (Chippenham)Jo m Gerry Simmonds (Gloucester)Lucy m John Large (Gloucester)Doug mLaurie mAmy m Joseph Glass (Chelmsford)</nobr><br /><nobr><strong>Phoebe</strong></nobr>"},{"img":"11-1.jpg","cap":"<strong>POMEROY</strong>  <i><nobr>(Andrew - Local)</nobr></i> <nobr><strong>Doug&Angela</strong></nobr> <i><nobr>(Peter Jones - Gloucester)</nobr></i> <br /><nobr><strong>Katia</strong> 01/00<strong>Ricard</strong> 03/02<strong>Tiara</strong> 08/04<strong>Lander</strong> 02/13</nobr>"}],[{"img":"12-0.jpg","cap":"<strong>POMEROY</strong>  <i><nobr>(Andrew - Local)</nobr></i> <nobr><strong>Laurie&Elaine</strong></nobr> <i><nobr>(Ray Ponsford* - Gloucester)</nobr></i> <br /><nobr><strong>Romano</strong> 10/03<strong>Montana</strong> 12/04<strong>Indiana</strong> 09/12</nobr>"},{"img":"12-1.jpg","cap":"<strong>PRESTON</strong>  <i><nobr>(Michael* - Local)</nobr></i> <nobr><strong>Andy&Gwynn</strong></nobr> <i><nobr>(Dennis Cook* - Local)</nobr></i> "}],[{"img":"13-0.jpg","cap":"<strong>PRESTON</strong>  <i><nobr>(Peter - Local)</nobr></i> <nobr><strong>Lloyd&Debbie</strong></nobr> <i><nobr>(Melvin Ursell - San Antonio)</nobr></i> <br /><nobr><strong>Kilmeny</strong> 10/14<strong>Onslo</strong> 01/12</nobr>"},{"img":"13-1.jpg","cap":"<strong>PRESTON</strong>  <i><nobr>(Peter - Local)</nobr></i> <nobr><strong>Matthew&Louanna</strong></nobr> <i><nobr>(Phil Dible - Local)</nobr></i> <br /><nobr><strong>Texarkana</strong> 10/04<strong>Alzina</strong> 06/08<strong>Makenna</strong> 06/13</nobr>"}],[{"img":"14-0.jpg","cap":"<strong>PRESTON</strong>  <i><nobr>(Michael* - Local)</nobr></i> <nobr><strong>Peter&Rachel</strong></nobr> <i><nobr>(Eric Shaughnessy - Local)</nobr></i> <br /><nobr>Lynette m Hugh Stedman (Watford)Jacqui m Robin Painter (Local)Matthew mKerri m Carl Griffiths (Stow)Lloyd mAbigail 14/03/88 - Taken 19/03/88Rosalyn m Darren Juby (Gloucester)</nobr>"},{"img":"14-1.jpg","cap":"<strong>SHAUGHNESSY</strong>  <i><nobr>(Leslie* - Swansea)</nobr></i> <nobr><strong>Eric&Cynthia</strong></nobr> <i><nobr>(Redding - Worcester)</nobr></i> <br /><nobr>Rachel m Peter Preston (Local)</nobr>"}],[{"img":"15-0.jpg","cap":"<strong>SIMMONS</strong>  <i><nobr>(Harold* - Local)</nobr></i> <nobr><strong>Stephen&Ruth</strong></nobr> <i><nobr>(Mrs Vera Gillingham* - Local)</nobr></i> <br /><nobr>Rhoda m Tim Painter (Local)Dawn m Chris Joynt (Dublin)Laura m John Davies (Bristol)</nobr>"},{"img":"15-1.jpg","cap":"<strong>TURNER</strong> <nobr><strong>Miss Naomi</strong></nobr><br /><nobr>Father Arthur W. G. - Taken 01/69</nobr> "}],[{"img":"16-0.jpg","cap":"<strong>WHITESIDE</strong> <nobr><strong>Mrs Deb</strong></nobr>  <i><nobr>(Leslie Bellamy* - Enfield/Mrs Jean - Leeds)</nobr></i> <br /><nobr>Husband Tim <i><nobr>(John* - Local)</nobr></i>  - Taken 02/17</nobr><br /><nobr>Heidi m Jim Deans (Norwich)Sam m (Banbury)Joe m (Lisarow)Jennie m Joakim Skinner (Gothenburg, Sweden)Fiona m Doug Parsons (Worcester)Sally m Jens Wilhelmsson (Gothenburg, Sweden)Jerry m</nobr>"},{"img":"16-1.jpg","cap":"<strong>WHITESIDE</strong>  <i><nobr>(Peter - Local)</nobr></i> <nobr><strong>Giles&Cilla</strong></nobr> <i><nobr>(Walter Saltmarsh - Gloucester)</nobr></i> <br /><nobr><strong>Jarvia</strong> 02/06<strong>Ell�</strong> 04/02<strong>Taylor</strong> 09/03</nobr>"}],[{"img":"17-0.jpg","cap":"<strong>WHITESIDE</strong>  <i><nobr>(Peter - Local)</nobr></i> <nobr><strong>Jake&Trish</strong></nobr> <i><nobr>(Gillingham - Local)</nobr></i> <br /><nobr><strong>Annabel</strong> 03/99<strong>William</strong><strong>Alfred</strong><strong>Ernest</strong> 06/02<strong>Polly</strong> 10/00</nobr>"},{"img":"17-1.jpg","cap":"<strong>WHITESIDE</strong>  <i><nobr>(Tim* - Local)</nobr></i> <nobr><strong>Jerry&Becky</strong></nobr> <i><nobr>(Bob Mornan - Westfield)</nobr></i> <br /><nobr><strong>Henry</strong> 08/13<strong>Winston</strong> 10/17<strong>George</strong> 12/15</nobr>"}],[{"img":"18-0.jpg","cap":"<strong>WHITESIDE</strong>  <i><nobr>(Peter - Local)</nobr></i> <nobr><strong>Luke&Linnie</strong></nobr> <i><nobr>(Fran Richardson - Preston)</nobr></i> <br /><nobr><strong>Rexford</strong> 12/05<strong>Daisy</strong> 03/12<strong>Harlan</strong> 06/02</nobr>"},{"img":"18-1.jpg","cap":"<strong>WHITESIDE</strong>  <i><nobr>(David* - Local)</nobr></i> <nobr><strong>Mark&Eunice</strong></nobr> <i><nobr>(Arthur Hearn* - Oxford/Mrs Mary - Didcot)</nobr></i> <br /><nobr><strong>Jack</strong><strong>Hannah</strong><strong>Martha</strong></nobr>"}],[{"img":"19-0.jpg","cap":"<strong>WHITESIDE</strong> <nobr><strong>Miss Mary</strong></nobr><br /><nobr>Father John - Taken 01/06</nobr> <nobr>Mother Ethel - Taken 01/05</nobr> "},{"img":"19-1.jpg","cap":"<strong>WHITESIDE</strong>  <i><nobr>(Richard - Local)</nobr></i> <nobr><strong>Nathan&Kerry</strong></nobr> <i><nobr>(Derek Cook - Local)</nobr></i> <br /><nobr><strong>Lola</strong> 02/11<strong>Bruno</strong> 11/08</nobr>"}],[{"img":"20-0.jpg","cap":"<strong>WHITESIDE</strong>  <i><nobr>(David* - Local)</nobr></i> <nobr><strong>Peter&Deb</strong></nobr> <i><nobr>(Peter Scott* - Guildford)</nobr></i> <br /><nobr>Simon m (Peterhead)Jake mLuke mGiles m</nobr><br /><nobr><strong>Darcie Whiteside</strong> 07/12<strong>Barkley Whiteside</strong> 10/15<strong>Oliver Whiteside</strong> 01/11</nobr>"},{"img":"20-1.jpg","cap":"<strong>WHITESIDE</strong>  <i><nobr>(David* - Local)</nobr></i> <nobr><strong>Richard&Catherine</strong></nobr> <i><nobr>(Hugh Smith* - Aldeburgh)</nobr></i> <br /><nobr>Katrina m Doug Ponsford (Gloucester)Vicky m Mathew Pittock (Aldeburgh)Linda m Tony van As (Chippenham)Beverley m James Van As (Chippenham)Nathan mSarah m Tim Hattingh (Lisarow)</nobr><br /><nobr><strong>Ben</strong></nobr>"}],[{"img":"21-0.jpg","cap":"<strong>WHITESIDE</strong> <nobr><strong>Mrs Ruth</strong></nobr>  <i><nobr>(Roy Woodcock* - Ipswich)</nobr></i> <br /><nobr>Husband David <i><nobr>(John Snr* - Marlborough)</nobr></i>  - Taken 08/98</nobr><br /><nobr>Peter mRichard mSarah m Geoff Mallinson (Doncaster)Rebecca m Roland Oetiker (Z�rich)Mark m</nobr>"},{"img":"21-1.jpg","cap":"<strong>YOUNG</strong>  <i><nobr>(Malcolm* - Local)</nobr></i> <nobr><strong>Graham&Jo</strong></nobr> <i><nobr>(David Smith - Chesterfield)</nobr></i> <br /><nobr><strong>Kayla</strong> 07/03<strong>Jacob</strong><strong>Findlay</strong> 04/01<strong>Tamar</strong> 12/98</nobr>"}],[{"img":"22-0.jpg","cap":"<strong>YOUNG</strong> <nobr><strong>Miss Heather</strong></nobr><br /><nobr>Father Malcolm - Taken 07/03</nobr> <nobr>Mother Joyce - Taken 12/15</nobr> "},{"img":"22-1.jpg","cap":"<strong>YOUNG</strong>  <i><nobr>(Mrs Rosie - Local)</nobr></i> <nobr><strong>Jason&Shannon</strong></nobr> <i><nobr>(Greg Samuels - Winnipeg)</nobr></i> <br /><nobr><strong>Chiquira</strong> 07/15<strong>Elvarado</strong> 07/13</nobr>"}]],"city":"Swindon","tabColor":"ff3fc0","countryID":"UK"}
			Object.assign(res, {countryID: this.country.name, city:this.city})

			// fetch(base + '/'+res.countryID+'/'+res.city.name+'/data.js')
			// 	.then(res=>{
			// 			this.update({data: JSON.stringify(res)})
			// 	})
			this.update({data:res, showSelectors: false, showCarousel:true})
		}

		this.logout = ()=>{
			this.showSelectors = false 
			this.user = false
			this.logged = false 
		}

		this.on('mount',()=>{
			//by some reason touches have a precendency over click handler
			//probably because click = mouse down + mouse up, so touchstart triggered first
			const inputs = document.querySelectorAll('input')
			add(inputs, 'click', e => {
				e.stopPropagation()
			}, false);
			const gestureZone = window.document

			add(gestureZone, 'touchstart', e => {
				let t = e.changedTouches[0]
				x0 = t.screenX;
				y0 = t.screenY
			}, false);

			add(gestureZone, 'touchend', e => {
				let t = e.changedTouches[0]
				x1 = t.screenX;
				y1 = t.screenY

				handleGesture.call(this);
			}, false);

			function handleGesture() {
				let carousel = this.tags.carousel
				if(this.user===false || !carousel)
					return;
				if(Math.abs(y1 - y0) < 70){
					if(x1 + thres < x0){
						carousel.goNext()
					} else{
						carousel.goPrev()
					}
				}else{
					let res = (y1 > y0 + thres)
					this.update({showSelectors:res, showCarousel:!res})
				}
			}	
		}) 
	</script>
	<style>
		:scope { font-size: 9pt; font-family: sans-serif;}
		.input { display: inline-block;}
		i { padding-left: 7px; padding-right: 7px }
		button { border-radius: 5px; cursor: pointer; }
		button:hover { background: #DDD }
		button:focus { outline: 0 }
		.centered {	position: fixed; top: 50%;	left: 50%;	display: block;	transform: translate(-50%, -50%);}
		.btn-warning {position: absolute; right: 0;}   
	</style>
</app>