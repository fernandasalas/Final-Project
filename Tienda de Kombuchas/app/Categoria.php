<?php

namespace tienda;

use Illuminate\Database\Eloquent\Model;

class Categoria extends Model
{
    protected $table='categoria';

    protected $primaryKey='idcategoria';

    public $timestamps=true;

    protected $fillable = [
    	'nombre',
    	'descripcion',
    	'condicion'
    ];

    protected $guarded= [

    ];
}
