<?php
/**
*@package pXP
*@file gen-Publicidad.php
*@author  (admin)
*@date 25-06-2013 21:50:18
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.Publicidad=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.Publicidad.superclass.constructor.call(this,config);
		this.init();
		this.load({params:{start:0, limit:this.tam_pag}});
		
		this.addButton('btnStart', {
				text : '',
				iconCls : 'bsendmail',
				disabled : true,
				handler : onBtnMailStart,
				tooltip : '<b>Iniciar</b><br/>Iniciar Campaña'
			});

			function onBtnMailStart(){
	    var rec=this.sm.getSelected();
     Ext.Ajax.request({
         url:'../../sis_empresas/control/Publicidad/iniciarCampania',
         params:{'id_publicidad':rec.data.id_publicidad},
         success: this.successSave,
         failure: function() {
             console.log("fail");
         },
         timeout: function() {
             console.log("timeout");
         },
         scope:this
     });  
				}
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_publicidad'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'cantidad_publicidad',
				fieldLabel: 'Cantidad',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'camp.cantidad_publicidad',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'tiempo',
				fieldLabel: 'Periodo (en horas)',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'NumberField',
			filters:{pfiltro:'camp.tiempo',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
			config:{
				name: 'hora_envio',
				fieldLabel: 'Hora Envio',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:8
			},
			type:'TextField',
			filters:{pfiltro:'camp.hora_envio',type:'string'},
			id_grupo:1,
			grid:true,
			form:true
		},
		{
  			config:{
  				name:'id_plantilla_correo',
  				fieldLabel:'Plantilla Correo',
  				allowBlank:false,
  				emptyText:'Plantilla Correo...',
  				store: new Ext.data.JsonStore({
								url: '../../sis_empresas/control/PlantillaCorreo/listarPlantillaCorreo',
								id: 'id_plantilla_correo',
								root: 'datos',
								sortInfo:{
									field: 'codigo',
									direction: 'ASC'
								},
								totalProperty: 'total',
								fields: ['id_plantilla_correo','codigo'],
								// turn on remote sorting
								remoteSort: true,
								baseParams:{par_filtro:'codigo'}
						}),
						anchor: '80%',
  				valueField: 'id_plantilla_correo',
  				displayField: 'codigo',
  				gdisplayField: 'plantilla_correo',
  				hiddenName: 'id_plantilla_correo',
  				forceSelection:true,
  				typeAhead: true,
      triggerAction: 'all',
      lazyRender:true,
  				mode:'remote',
  				pageSize:10,
  				queryDelay:1000,
  				width:250,
  				minChars:2,  			
  				renderer:function(value, p, record){return String.format('{0}', record.data['plantilla_correo']);}
  			},
  			type:'ComboBox',
  			id_grupo:0,
  			filters:{   
  				  pfiltro:'plt.codigo',
  						type:'string'
  					},
  			grid:true,
  			form:true
  },
		{
	   config:{
	       name:'lugar',
	       fieldLabel: 'Lugar',
	       emptyText : 'Lugar...',
		   allowBlank: true,
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
  			config:{
  				name:'id_actividad',
  				fieldLabel:'Actividad',
  				allowBlank:false,
  				emptyText:'Actividad...',
  				store: new Ext.data.JsonStore({
								url: '../../sis_empresas/control/Actividad/listarActividad',
								id: 'id_actividad',
								root: 'datos',
								sortInfo:{
									field: 'codigo',
									direction: 'ASC'
								},
								totalProperty: 'total',
								fields: ['id_actividad','codigo','nombre'],
								// turn on remote sorting
								remoteSort: true,
								baseParams:{par_filtro:'codigo#nombre'}
						}),
						anchor: '80%',
  				valueField: 'id_actividad',
  				displayField: 'nombre',
  				gdisplayField: 'actividad',
  				hiddenName: 'id_actividad',
  				forceSelection:true,
  				typeAhead: true,
      triggerAction: 'all',
      lazyRender:true,
  				mode:'remote',
  				pageSize:10,
  				queryDelay:1000,
  				width:250,
  				minChars:2,  			
  				renderer:function(value, p, record){return String.format('{0}', record.data['actividad']);}
  			},
  			type:'ComboBox',
  			id_grupo:0,
  			filters:{   
  				  pfiltro:'act.nombre',
  						type:'string'
  					},
  			grid:true,
  			form:true
  },	
		{
			config:{
				name: 'correos_exitos',
				fieldLabel: 'Correos Exitosos',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'camp.correos_exitos',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'correos_fallidos',
				fieldLabel: 'Correos Fallidos',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
			type:'NumberField',
			filters:{pfiltro:'camp.correos_fallidos',type:'numeric'},
			id_grupo:1,
			grid:true,
			form:false
		},		
		{
			config:{
				name: 'estado',
				fieldLabel: 'Estado',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:-5
			},
			type:'TextField',
			filters:{pfiltro:'camp.estado',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
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
			filters:{pfiltro:'camp.estado_reg',type:'string'},
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
			filters:{pfiltro:'camp.fecha_reg',type:'date'},
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
			filters:{pfiltro:'camp.fecha_mod',type:'date'},
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
	
	title:'Campaña',
	ActSave:'../../sis_empresas/control/Publicidad/insertarPublicidad',
	ActDel:'../../sis_empresas/control/Publicidad/eliminarPublicidad',
	ActList:'../../sis_empresas/control/Publicidad/listarPublicidad',
	id_store:'id_publicidad',
	fields: [
		{name:'id_publicidad', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'tiempo', type: 'numeric'},
		{name:'hora_envio', type: 'string'},
		{name:'id_lugar', type: 'numeric'},
		{name:'lugar', type: 'string'},
		{name:'estado', type: 'string'},
		{name:'id_actividad', type: 'numeric'},
		{name:'actividad', type: 'string'},
		{name:'correos_exitos', type: 'numeric'},
		{name:'correos_fallidos', type: 'numeric'},
		{name:'cantidad_publicidad', type: 'numeric'},
		{name:'id_plantilla_correo', type: 'numeric'},
		{name:'plantilla_correo', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	sortInfo:{
		field: 'id_publicidad',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	preparaMenu : function(tb) {
			Phx.vista.Publicidad.superclass.preparaMenu.call(this, tb)
			var rec =this.sm.getSelected();			
			if(rec.data.estado != 'finalizado')
					this.getBoton('btnStart').enable();
	},
	liberaMenu : function(tb) {
		Phx.vista.Publicidad.superclass.liberaMenu.call(this, tb)
		this.getBoton('btnStart').disable();
	}

}
)
</script>
		
		