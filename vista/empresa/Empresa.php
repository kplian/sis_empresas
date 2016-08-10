<?php
/**
*@package pXP
*@file gen-Empresa.php
*@author  (admin)
*@date 20-06-2013 13:33:33
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Empresa=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Empresa.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}});		
		this.getComponente('id_actividad_gral').on('select', this.onActividadGralSelect, this);
		this.getComponente('id_actividad_prim').on('select', this.onActividadPrimSelect, this);
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_empresa'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nombre',
				fieldLabel: 'Nombre',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'empr.nombre',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'matricula',
				fieldLabel: 'Matricula',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:8
			},
			type:'TextField',
			filters:{pfiltro:'empr.matricula',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
	   config:{
	       name:'lugar',
	       fieldLabel: 'Lugar',
	       emptyText : 'Lugar...',
				    allowBlank: false,
							 typeAhead: true,
	       triggerAction: 'all',
	       anchor: '80%',
  		    lazyRender:true,
  		    mode: 'local',
  		    store:['Beni', 'Chuquisaca', 'Cochabamba', 'La Paz', 'Oruro', 
  		    							'Pando', 'Potosi', 'Santa Cruz', 'Tarija']
  		},
  		type:'ComboBox',
  		id_grupo:0,
  		filters : {
          pfiltro : 'lug.nombre',
          type : 'string'
    },
  		grid:true,
    form:true
	 },
		{
      config : {
          name : 'id_actividad_gral',
          fieldLabel : 'Actividad General',
          allowBlank : false,
          emptyText : 'Actividad Gral...',
          store : new Ext.data.JsonStore({
              url : '../../sis_empresas/control/Actividad/listarActividadGral',
              id : 'id_actividad',
              root : 'datos',
              sortInfo : {
                  field : 'nombre',
                  direction : 'ASC'
              },
              totalProperty : 'total',
              fields : ['id_actividad', 'nombre'],
              remoteSort : true,
              baseParams : {
                  par_filtro : 'act.nombre'
              }
          }),
          valueField : 'id_actividad',
          displayField : 'nombre',
          gdisplayField : 'actividad_gral',
          hiddenName : 'id_actividad_gral',
          forceSelection : true,
          typeAhead : false,
          triggerAction : 'all',
          lazyRender : true,
          mode : 'remote',
          pageSize : 10,
          queryDelay : 1000,
          anchor : '80%',
          gwidth : 150,
          minChars : 2,
          renderer : function(value, p, record) {
              return String.format('{0}', record.data['actividad_gral']);
          }
      },
      type : 'ComboBox',
      id_grupo : 0,
      filters : {
          pfiltro : 'gral.nombre',
          type : 'string'
      },
      grid : true,
      form : true
  },
		{
      config : {
          name : 'id_actividad_prim',
          fieldLabel : 'Actividad primaria',
          allowBlank : false,
          emptyText : 'Actividad Primaria...',
          store : new Ext.data.JsonStore({
              url : '../../sis_empresas/control/Actividad/listarActividadPrim',
              id : 'id_actividad',
              root : 'datos',
              sortInfo : {
                  field : 'nombre',
                  direction : 'ASC'
              },
              totalProperty : 'total',
              fields : ['id_actividad', 'nombre'],
              remoteSort : true,
              baseParams : {
                  par_filtro : 'act.nombre'
              }
          }),
          //tpl : '<tpl for="."><div class="x-combo-list-item"><p>Cuenta: {cuenta}</p><p>Nombre: {desc_person}</p></div></tpl>',
          valueField : 'id_actividad',
          displayField : 'nombre',
          gdisplayField : 'actividad_prim',
          hiddenName : 'id_actividad_prim',
          forceSelection : true,
          typeAhead : true,
          triggerAction : 'all',
          lazyRender : true,
          mode : 'remote',
          pageSize : 10,
          queryDelay : 1000,
          anchor : '80%',
          minChars : 2,
          renderer : function(value, p, record) {
              return String.format('{0}', record.data['actividad_prim']);
          },
      },
      type : 'ComboBox',
      id_grupo : 0,
      filters : {
          pfiltro : 'prim.nombre',
          type : 'string'
      },
      grid : true,
      form : true
  },
		{
      config : {
          name : 'id_actividad_esp',
          fieldLabel : 'Actividad especifica',
          allowBlank : false,
          emptyText : 'Actividad Especifica...',
          store : new Ext.data.JsonStore({
              url : '../../sis_empresas/control/Actividad/listarActividadEsp',
              id : 'id_actividad',
              root : 'datos',
              sortInfo : {
                  field : 'nombre',
                  direction : 'ASC'
              },
              totalProperty : 'total',
              fields : ['id_actividad', 'nombre'],
              remoteSort : true,
              baseParams : {
                  par_filtro : 'act.nombre'
              }
          }),
          //tpl : '<tpl for="."><div class="x-combo-list-item"><p>Cuenta: {cuenta}</p><p>Nombre: {desc_person}</p></div></tpl>',
          valueField : 'id_actividad',
          displayField : 'nombre',
          gdisplayField : 'actividad_esp',
          hiddenName : 'id_actividad_esp',
          forceSelection : true,
          typeAhead : true,
          triggerAction : 'all',
          lazyRender : true,
          mode : 'remote',
          pageSize : 10,
          queryDelay : 1000,
          anchor : '80%',
          minChars : 2,
          renderer : function(value, p, record) {
              return String.format('{0}', record.data['actividad_esp']);
          },
      },
      type : 'ComboBox',
      id_grupo : 0,
      filters : {
          pfiltro : 'esp.nombre',
          type : 'string'
      },
      grid : true,
      form : true
  },		
		{
			config:{
				name: 'actividad',
				fieldLabel: 'Actividad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'empr.actividad',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},		
		{
			config:{
				name: 'nit',
				fieldLabel: 'Nit',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'empr.nit',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'email',
				fieldLabel: 'Email',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'empr.email',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},		
		{
			config:{
				name: 'domicilio',
				fieldLabel: 'Domicilio',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:200
			},
			type:'TextField',
			filters:{pfiltro:'empr.domicilio',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'telefono',
				fieldLabel: 'Telefono',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:500
			},
			type:'TextField',
			filters:{pfiltro:'empr.telefono',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'empr.estado_reg',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'empr.fecha_reg',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu1.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
						format: 'd/m/Y', 
						renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
			type:'DateField',
			filters:{pfiltro:'empr.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'usu2.cuenta',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Empresas',
	ActSave:'../../sis_empresas/control/Empresa/insertarEmpresa',
	ActDel:'../../sis_empresas/control/Empresa/eliminarEmpresa',
	ActList:'../../sis_empresas/control/Empresa/listarEmpresa',
	id_store:'id_empresa',
	fields: [
		{name:'id_empresa', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'domicilio', type: 'string'},
		{name:'lugar', type: 'string'},
		{name:'actividad', type: 'string'},
		{name:'actividad_gral', type: 'string'},
		{name:'actividad_prim', type: 'string'},
		{name:'actividad_esp', type: 'string'},
		{name:'nit', type: 'string'},
		{name:'email', type: 'string'},
		{name:'matricula', type: 'string'},
		{name:'telefono', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_empresa',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	onActividadGralSelect : function(e,b,c){
            this.getComponente('id_actividad_prim').enable();           
            this.getComponente('id_actividad_prim').reset();            
            this.getComponente('id_actividad_esp').disable();
            this.getComponente('id_actividad_esp').reset();
            this.getComponente('id_actividad_prim').lastQuery = null;
            this.getComponente('id_actividad_prim').store.baseParams.id_actividad_gral = e.value;
 },
 
 onActividadPrimSelect : function(e,b,c){
            this.getComponente('id_actividad_esp').enable();
            this.getComponente('id_actividad_esp').reset();
            this.getComponente('id_actividad_esp').lastQuery = null;
            this.getComponente('id_actividad_esp').store.baseParams.id_actividad_prim = e.value;
 },
 
 onButtonNew : function() {
 	 Phx.vista.Empresa.superclass.onButtonNew.call(this);
			this.getComponente('id_actividad_prim').disable();
			this.getComponente('id_actividad_esp').disable();
		}
        
}
)
</script>
		
		