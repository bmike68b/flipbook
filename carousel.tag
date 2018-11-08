<cap>  
  <style> 
    :scope { font-size: 0.9em; height: 60px; }
  </style>    
  <script>     
    this.root.innerHTML = opts.txt 
  </script>
</cap> 
 
<slot>
  <div show={parent.i==0 && opts.j==0}>
    <div class="city" >{parent.city}</div> 
    <div class="divider" style={parent.style}></div>  
  </div>     
  <img src="{parent.rel}{opts.t.img}"> 
  <cap txt={opts.t.cap}></cap>

  <style>  
    img {display: block;} 
    cap { font-size: 0.9em; height: 60px; }   
    .city {font-size: 4em; text-align: center; padding: 40px 0; }
    .divider { height: 10px; width: 500px; margin: 10px auto;}
  </style> 
</slot> 
  
<carousel>  
  <div id="carousel" class="carousel slide" data-ride="carousel"
    data-interval={ interval } data-pause={ pause } data-wrap={ wrap } data-keyboard={ keyboard }>

      <div id="tgt" class="carousel-inner"> 
        <div each={ page,i in pages } class="item {active:i==ix}"> 
          <slot each={t,j in page} t={t} j={j}></slot>
 
           <div class="pagenum {i%2?'l':'r'}p">{i+1}</div> 
          <div class="tab {i%2?'l':'r'}t" style={style}>{city}</ div>
        </div>
      </div> 
 
      <!-- <div class="left carousel-control" href="#carousel" data-slide="prev"></div> -->
      <!-- <div class ="right carousel-control" href="#carousel" data-slide="next"></div> -->
  </div>
     
  <style> 
    .carousel-control {
        display: block; position: fixed; top: 50%; 
        width: 68px; height: 68px;
        margin: -34px 0 0 0; 
        text-align: center;  
        background: url(./assets/images/arrows-slider.svg) no-repeat ! important;  
        outline: 0; border: none; 
        opacity: .7;  
    }  
    .tab {
      position: absolute; top:70px; 
      width: 150px; height: 35px; line-height: 35px; background-color: #f00;  
      font-weight: 600; text-transform: uppercase; letter-spacing: 1px;   
    } 
    .pagenum{  
      position: absolute; top:900px;  
      width: 40px; height : 35px; line-height: 35px; padding-right: 10px; 
      font-weight: 600; background-color: #888; color: #fff; text-align: right;  
    }  
    .right { right:0; transform: scaleX( -1); } 
    .lp { left:0; } 
    .rp { right: 0; }
    .tab.lt {left:-34px; transform: rotateZ(90deg); }
    .tab.rt { right: -34px; transform: rotateZ(-90deg); }

    .carousel-inner > .item {text-align: center; }
    .carousel-inner > .item > img { display: inline; }
    .carousel-control {opacity: 0.05}
    .carousel-control:hover {opacity: 1}
    img { opacity: 0.8; }
  </style>

  <script>

    let {x0, x1, y0, y1} = 0
    let data, curr;

    const PREFETCH_LENGTH = 2
    const AUTO_INTERVAL = 5000

    this.interval = AUTO_INTERVAL
    this.pause    = "hover"
    this.wrap     = false
    this.keyboard = true
    
    this.goNext = (e)=>{
      // e && e.stopPropagation()
      if(curr==data.pages.length-1)
        return

      this.ix++

      for(let i=0; i<PREFETCH_LENGTH; i++){
        curr++
        this.pages.push( data.pages[curr] )

        this.pages[curr].forEach(t =>{
          let img = new Image();
            img.src = this.rel + t.img
        })
        console.log('prefetched page: '+curr)
      }
      this.update()
      if(curr > 2)
        $('.right').click()
    }

    this.goPrev = (e)=> {
      this.ix --
      // e && e.stopPropagation()
      this.update();
      $('.left').click()
    }

    //it works if we don't need in update of its parent.
    //but it the case, data get undefined as we didnt update the tag directly
   // this.shouldUpdate =(data, nextOpts) => {
      //nextOpts are chaned only if a selector has been changed
   //   return (nextOpts.data.city && data!=nextOpts.data)
 //   }
    this.on('update', ()=>{
      if(data==opts.data)
        return
      data = opts.data
      if(!data.city)
        return

      //for each city the data must be reset
      curr = -1
      this.ix = -1
      this.pages = []
      
      this.city = data.city
      this.countryID = data.countryID
      this.rel = `./${this.countryID}/${this.city}/images/`
      this.style = {'background-color':'#'+data.tabColor}

      this.goNext()
    })
   
  </script>
</carousel>