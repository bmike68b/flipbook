<rg-select>
    <input type={opts.select.filter?'search':'text'} ref="selectfield" class="c-field" placeholder={opts.select.placeholder}
            oninput={getFiltered} onfocus={open} __readonly={!opts.select.filter} value={curr}>
    <ul class="c-card c-card--menu u-high" if={opts.select.isvisible}>
        <li each={options} no-reorder onclick={parent.select} class="c-card__item {'c-card__item--active':selected, 'c-card__item--disabled':disabled, 'c-card--menu__item--hover':active}"> {name}
            </li>
    </ul>
	   
	<script>
    var props = opts.select
    var currCountry=''
    this.options = props.options
    var selectfield

    if (!opts.select) opts.select = { options: [] };

    var handleClickOutside = e => {
        if (!this.root.contains(e.target))
            this.close();
        props.options.forEach(i => i.selected = false)
        this.update()
    };

    var applyFieldText = () => {
		props.options.forEach(t =>{
			if (t.selected)
                return (this.curr = t.name);
		})
    };

    function getWindowDimensions() {
        var w = window,
            d = document,
            e = d.documentElement,
            g = d.getElementsByTagName("body")[0],
            x = w.innerWidth || e.clientWidth || g.clientWidth,
            y = w.innerHeight || e.clientHeight || g.clientHeight;
        return {
            width: x,
            height: y
        }
    } ;

    var positionDropdown = ()=> {
        var w = getWindowDimensions();
        var m = this.root.querySelector(".c-card--menu");
        if (!m) return;
        if (!opts.select.isvisible) {
            m.style.marginTop = "";
            m.style.marginLeft = "";
            return
        }

        var pos = m.getBoundingClientRect();
        if (w.width < pos.left + pos.width) {
            m.style.marginLeft = w.width - (pos.left + pos.width) - 20 + "px"
        }
        if (pos.left < 0) 
            m.style.marginLeft = "20px"
        if (w.height < pos.top + pos.height) 
            m.style.marginTop = w.height - (pos.top + pos.height) - 20 + "px"
        
    };

    this.open = (e) => {
        e.stopPropagation()
        props.isvisible = true
        this.getFiltered(e)
        this.trigger('opened', this.options)
    }
    this.close = (e) => {
        e && e.stopPropagation()
        props.isvisible = false
        this.trigger('closed', opts.ref)
    }

    this.getFiltered = (e)=> {
        e.stopPropagation()

        var val = this.refs.selectfield.value.toLowerCase()
        if(opts.select.filter){
            this.options = opts.select.options.filter(option => {
                var attr = option[props.filter];
                return attr && ~attr.toLowerCase().indexOf(val)
            });
        }
	};
	
    this.select = e => {
        props.options.forEach(i => i.selected = (i==e.item))
        applyFieldText()
        this.close()
        
		//instead of resource-greedy parent.update()
		opts.api.trigger('selected', {type:opts.ref, item:e.item})
        this.trigger('selected', props.options)
    }

    this.on('update', () => {
        if (!props.filter)
            applyFieldText()
            
        positionDropdown()

        if(this.parent.user===false)
            for(k in this.refs)
                this.refs[k].value = ''
    })
    this.on('mount', () => {

        document.addEventListener('click', handleClickOutside)
    })
    this.on('unmount', () => {
        document.removeEventListener('click', handleClickOutside)
    })
	</script>

	<style>
		.c-field { display: block; margin-bottom: 3px; min-width: 300px; font-size: 1.1em;
            border: 1px solid #ccc; box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            transition: border-color ease-in-out .15s ,box-shadow ease-in-out .15s;
        }
        .c-field:focus{
            border-color: #66afe9; outline: 0;
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102,175,233,.6);
        }
		ul { position: relative; margin: 0;}
		li{ color: #666}
        li:hover { background: #f9f9f9}
	</style>

</rg-select>
	