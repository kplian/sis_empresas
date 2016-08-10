<?php
/**
*@package pXP
*@file ArchivoAdjunto.php
*@author  Gonzalo Sarmiento 
*@date 25-06-2013 01:10:51
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.ArchivoAdjunto=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.ArchivoAdjunto.superclass.constructor.call(this,config);
		this.init();
	},
	tam_pag:50,
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_archivo_adjunto'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_plantilla_correo'
			},
			type:'Field',
			form:true 
		},
		{
			config:{
				name: 'nombre_archivo',
				fieldLabel: 'Nombre Archivo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:50
			},
			type:'TextField',
			filters:{pfiltro:'arcadj.nombre_archivo',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config:{
				name: 'extension_archivo',
				fieldLabel: 'Extension Archivo',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
			type:'TextField',
			filters:{pfiltro:'arcadj.extension_archivo',type:'string'},
			id_grupo:1,
			grid:true,
			form:false
		},
		{
			config : {
				fieldLabel : 'Archivo Adjunto',
				gwidth : 130,
				inputType : 'file',
				name : 'archivo',
				buttonText : '',
				maxLength : 150,
				anchor : '100%',
				
				renderer : function(value, p, record) {
					if (value != '')
						 return String.format('{0}', "<div style='text-align:center'><a href = '../../../sis_empresas/archivos/" + record.data['nombre_archivo'] +  '.' + record.data['extension_archivo'] + "' align='center' width='70' height='70'>documento</a></div>");
				}
			},
			type : 'Field',
			sortable : false,
			id_grupo : 0,
			grid : true,
			form : false
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
			filters:{pfiltro:'arcadj.estado_reg',type:'string'},
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
			filters:{pfiltro:'arcadj.fecha_reg',type:'date'},
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
			filters:{pfiltro:'arcadj.fecha_mod',type:'date'},
			id_grupo:1,
			grid:true,
			form:false
		}
	],
	
	title:'Archivos Adjuntados',
	ActSave:'../../sis_empresas/control/ArchivoAdjunto/insertarArchivoAdjunto',
	ActDel:'../../sis_empresas/control/ArchivoAdjunto/eliminarArchivoAdjunto',
	ActList:'../../sis_empresas/control/ArchivoAdjunto/listarArchivoAdjunto',
	id_store:'id_archivo_adjunto',
	fields: [
		{name:'id_archivo_adjunto', type: 'numeric'},
		{name:'id_plantilla_correo', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'archivo', type: 'string'},
		{name:'extension_archivo', type: 'string'},
		{name:'nombre_archivo', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		
	],
	
	onReloadPage:function(m){
        this.maestro=m;
        this.Atributos[1].valorInicial=this.maestro.id_plantilla_correo;
       if(m.id != 'id'){
        this.store.baseParams={id_plantilla_correo:this.maestro.id_plantilla_correo};
        this.load({params:{start:0, limit:50}})
       }
       else{
         this.grid.getTopToolbar().disable();
         this.grid.getBottomToolbar().disable(); 
         this.store.removeAll(); 
       }
 },
 
	sortInfo:{
		field: 'id_archivo_adjunto',
		direction: 'ASC'
	},
	bdel:true,
	bsave:false,
	bnew:false,
	bedit:false
	}
)
</script>
		
		