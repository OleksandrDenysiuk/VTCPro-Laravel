<?php


namespace App\Exports;
use App\User;
use App\UserRequestPayment;
use App\UserRequests;
use Carbon\Carbon;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithCustomCsvSettings;
use Illuminate\Support\Facades\Session;

class StatementExport implements FromView,WithCustomCsvSettings
{

	private $headers = [
		'Content-Type' => 'text/csv',
	];

	public function getCsvSettings(): array
	{
		return [
			'delimiter' => ';'
		];
	}

	public function view(): View {
		// TODO: Implement view() method.

		$rides = \Illuminate\Support\Facades\DB::table( 'user_requests' )
		->leftjoin( 'user_request_payments',
			'user_requests.id',
			'=',
			'user_request_payments.request_id' )
		->select( 'user_requests.id',
			'user_requests.booking_id',
			'user_requests.created_at',
			'user_request_payments.commision',
			'user_request_payments.fleet',
			'user_request_payments.discount',
			'user_request_payments.peak_amount',
			'user_request_payments.peak_comm_amount',
			'user_request_payments.waiting_amount',
			'user_request_payments.waiting_comm_amount',
			'user_request_payments.tax',
			'user_request_payments.tips',
			'user_request_payments.round_of',
			'user_request_payments.total',
			'user_request_payments.wallet',
			'user_request_payments.payable',
			'user_requests.payment_mode',
			'user_request_payments.payable',
			'user_request_payments.cash',
			'user_request_payments.card',
			'user_request_payments.provider_pay',
			'user_requests.status'
		)
		->orderBy( 'user_requests.id', 'desc' );

		$revenue      = \Illuminate\Support\Facades\DB::table( 'user_requests' )
			->leftjoin( 'user_request_payments',
				'user_requests.id',
				'=',
				'user_request_payments.request_id' )
			->select( DB::raw(
			'SUM(commision) as commision, 
			SUM(fleet) as fleet,
			SUM(discount) as discount,
			SUM(peak_amount) as peak_amount,
			SUM(peak_comm_amount) as peak_comm_amount,
			SUM(waiting_amount) as waiting_amount,
			SUM(waiting_comm_amount) as waiting_comm_amount,
			SUM(tax) as tax,
			SUM(tips) as tips,
			SUM(round_of) as round_of,
			SUM(total + tips) as total,
			SUM(wallet) as wallet,
			SUM(cash) as cash,
			SUM(card) as card,
			SUM(payable) as payable,
			SUM(provider_pay) as provider_pay
			'
		) );

		if( Session::has( 'from_date' ) && Session::has( 'to_date' ))
		{
			$from_date = Session::get( 'from_date' );
			$to_date   = Session::get( 'to_date' );
			$rides->whereBetween( 'user_requests.created_at',
				[
					Carbon::createFromFormat( 'Y-m-d', $from_date ),
					Carbon::createFromFormat( 'Y-m-d', $to_date ),
				] );

			$revenue->whereBetween( 'user_requests.created_at',
				[
					Carbon::createFromFormat( 'Y-m-d', $from_date ),
					Carbon::createFromFormat( 'Y-m-d', $to_date ),
				] );
		}
		if(Session::has( 'searchval' )){
			$search_val = Session::get( 'searchval' );

			$rides->where('user_requests.status','like','%'.$search_val.'%');

			$request_id =  DB::table('user_requests')->where('status','like','%'.$search_val.'%')->pluck('id');
			$revenue->whereIn('user_request_payments.request_id',$request_id);
		}

		if(Session::has( 'searchval' ) && Session::has( 'from_date' ) && Session::has( 'to_date' ))
		{
			$search_val = Session::get( 'searchval' );
			$rides->where('user_requests.status','like','%'.$search_val.'%');

			$request_id =  DB::table('user_requests')->where('status','like','%'.$search_val.'%')
				->whereBetween( 'created_at',
					[
						Carbon::createFromFormat( 'Y-m-d', $from_date ),
						Carbon::createFromFormat( 'Y-m-d', $to_date ),
					] )
				->pluck('id');
			$revenue->whereIn('request_id',$request_id);
		}

		$rides = $rides->get();
		$revenue = $revenue->get();
		return view('admin.providers.pdfs.export',[
			'ride'=>$rides, 'revenue' => $revenue
		]);
	}
}
