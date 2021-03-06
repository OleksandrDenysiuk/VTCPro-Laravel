<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Auth;

class UserRequests extends Model
{
    use SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'provider_id',
        'user_id',
        'current_provider_id',
        'user_req_recurrent_id',
        'manual_assigned_at',
        'service_type_id',
        'promocode_id',
        'rental_hours',
        'status',
        'cancelled_by',
        'is_track',
        'otp',
        'travel_time',
        'distance',
        's_latitude',
        'd_latitude',
        's_longitude',
        'd_longitude',
        'track_distance',
        'track_latitude',
        'track_longitude',
        'paid',
        's_address',
        'd_address',
        'assigned_at',
        'schedule_at',
        'is_scheduled',
        'started_at',
        'finished_at',
        'use_wallet',
        'user_rated',
        'provider_rated',
        'surge',
        'traveller_type',
        'passenger_name',
        'passenger_phone',
        'comment',
        'note',
        'timeout',
        'created_by'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        // 'created_at', 'updated_at'
    ];

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = [
        'created_at',
        'updated_at',
        'deleted_at',
        'assigned_at',
        'schedule_at',
        'started_at',
        'schedule_return_at',
        'finished_at',
        'manual_assigned_at',
    ];

    /**
     * ServiceType Model Linked
     */
    public function service_type()
    {
        return $this->belongsTo('App\ServiceType');
    }

    /**
     * UserRequestPayment Model Linked
     */
    public function payment()
    {
        return $this->hasOne('App\UserRequestPayment', 'request_id');
    }

    /**
     * UserRequestRating Model Linked
     */
    public function rating()
    {
        return $this->hasOne('App\UserRequestRating', 'request_id');
    }

    /**
     * UserRequestRating Model Linked
     */
    public function filter()
    {
        return $this->hasMany('App\RequestFilter', 'request_id');
    }

    /**
     * The user who created the request.
     */
    public function user()
    {
        return $this->belongsTo('App\User');
    }

    /**
     * The provider assigned to the request.
     */
    public function provider()
    {
        return $this->belongsTo('App\Provider');
    }

    public function provider_service()
    {
        return $this->belongsTo('App\ProviderService', 'provider_id', 'provider_id');
    }

    public function scopePendingRequest($query, $user_id)
    {
        return $query->where('user_id', $user_id)
            ->whereNotIn('status', ['CANCELLED', 'COMPLETED', 'SCHEDULED']);
    }

    public function scopeRequestHistory($query)
    {
        return $query->orderBy('user_requests.schedule_at', 'desc')
            ->with('user', 'payment', 'provider');
    }

    public function scopeDispatcherRequestHistory($query)
    {
        return $query->where('created_id', Auth::user()->id)
            ->orderBy('user_requests.created_at', 'desc')
            ->with('user', 'payment', 'provider');
    }

    public function scopeCompanyTrips($query, $user_id)
    {
        return $query->whereIn('user_requests.user_id', $user_id)
            ->where('user_requests.status', 'COMPLETED')
            ->orderBy('user_requests.created_at', 'desc')
            ->select('user_requests.*')
            ->with('payment', 'service_type');
    }

    public function scopeUserTrips($query, $user_id)
    {
        return $query->where('user_requests.user_id', $user_id)
            ->where('user_requests.status', 'COMPLETED')
            ->orderBy('user_requests.created_at', 'desc')
            ->select('user_requests.*')
            ->with('payment', 'service_type');
    }

    public function scopeUserUpcomingTrips($query, $user_id)
    {
        return $query->where('user_requests.user_id', $user_id)
            ->where('user_requests.status', 'SCHEDULED')
            ->orderBy('user_requests.created_at', 'desc')
            ->select('user_requests.*')
            ->with('service_type', 'provider');
    }

    public function scopeProviderUpcomingRequest($query, $user_id)
    {
        return $query->where('user_requests.provider_id', $user_id)
            ->where('user_requests.status', 'SCHEDULED')
            ->leftJoin('user_request_recurrents', 'user_requests.user_req_recurrent_id', '=', 'user_request_recurrents.id')
            ->select(['user_requests.*', 'user_request_recurrents.repeated as repeated'])
            ->with('service_type', 'user', 'provider');
    }

    public function scopeUserTripDetails($query, $user_id, $request_id)
    {
        return $query->where('user_requests.user_id', $user_id)
            ->where('user_requests.id', $request_id)
            ->where('user_requests.status', 'COMPLETED')
            ->select('user_requests.*')
            ->with('payment', 'service_type', 'user', 'provider', 'rating');
    }

    public function scopeUserUpcomingTripDetails($query, $user_id, $request_id)
    {
        return $query->where('user_requests.user_id', $user_id)
            ->where('user_requests.id', $request_id)
            ->where('user_requests.status', 'SCHEDULED')
            ->select('user_requests.*')
            ->with('service_type', 'user', 'provider');
    }

    public function scopeUserRequestStatusCheck($query, $user_id, $check_status)
    {
        return $query->where('user_requests.user_id', $user_id)
            ->where('user_requests.user_rated', 0)
            ->whereNotIn('user_requests.status', $check_status)
            ->select('user_requests.*')
            ->with('user', 'provider', 'service_type', 'provider_service', 'rating', 'payment');
    }

    public function scopeUserRequestAssignProvider($query, $user_id, $check_status)
    {
        return $query->where('user_requests.user_id', $user_id)
            ->where('user_requests.user_rated', 0)
            ->where('user_requests.provider_id', 0)
            ->whereIn('user_requests.status', $check_status)
            ->select('user_requests.*')
            ->with('filter');
    }

    public static function getWayPointAddress($addr)
    {
        $result = '';
        foreach (json_decode($addr) as $key => $val) {
            $result .= $val->address . " - ";
        }
        return rtrim($result, " - ");
    }

    public static function getWayPointCoordinate($addr)
    {
        $result = array();
        foreach (json_decode($addr) as $key => $val) {
            $result[$key] = [$key, $val->lat, $val->lng];
        }
        return $result;

    }

    public function getAssignedAtAttribute($date)
    {
        return \Carbon\Carbon::parse($date)->timezone('Europe/Paris')->toDateTimeString();
    }

//    public function getScheduleAtAttribute($date)
//    {
//        return \Carbon\Carbon::parse($date)->timezone('Europe/Paris')->toDateTimeString();
//    }

//    public function setScheduleAtAttribute($date)
//    {
//        $this->attributes['schedule_at'] = \Carbon\Carbon::parse($date)->timezone('Europe/Paris');;
//    }


    public function getStartedAtAttribute($date)
    {
        return \Carbon\Carbon::parse($date)->timezone('Europe/Paris')->toDateTimeString();
    }

//    public function getScheduleReturnAtAttribute($date)
//    {
//        return \Carbon\Carbon::parse($date)->timezone('Europe/Paris')->toDateTimeString();
//    }

    public function getFinishedAtAttribute($date)
    {
        return \Carbon\Carbon::parse($date)->timezone('Europe/Paris')->toDateTimeString();
    }

    public function getManualAssignedAtAttribute($date)
    {
        if ($date == null) return null;
        return \Carbon\Carbon::parse($date)->timezone('Europe/Paris')->toDateTimeString();
    }


    public function getCreatedAtAttribute($date)
    {
        return \Carbon\Carbon::parse($date)->timezone('Europe/Paris')->toDateTimeString();
    }
    public function getUpdatedAtAttribute($date)
    {
        return \Carbon\Carbon::parse($date)->timezone('Europe/Paris')->toDateTimeString();
    }
}
