<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class FleetServiceType extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
	protected $table='fleet_service_types';

    protected $fillable = [
        'name',
        'provider_name',
        'image',
        'marker',
        'price',
        'fixed',
        'description',
        'status',
        'minute',
        'hour',
        'distance',
        'calculator',
        'capacity',
        'waiting_free_mins',
        'waiting_min_charge',
        'luggage_capacity',
        'fleet_id',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
         'created_at', 'updated_at'
    ];
}
