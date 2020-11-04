<?php

namespace App\Http\Controllers;

use App\Admin;
use App\AdminWallet;
use App\CustomPush;
use App\Exports\StatementExport;
use App\Exports\TripExport;
use App\Fleet;
use App\Helpers\Helper;
use App\Http\Controllers\ProviderResources\TripController;
use App\Provider;
use App\ProviderDocument;
use App\ProviderService;
use App\Services\ServiceTypes;
use App\ServiceType;
use App\User;
use App\UserPayment;
use App\UserRequestPayment;
use App\UserRequestRating;
use App\UserRequests;
use App\UserWallet;
use App\UserWalletRequest;
use App\WalletRequests;
use Auth;
use Carbon\Carbon;
use DateTime;
use DB;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Route;
use Log;
use Maatwebsite\Excel\Facades\Excel;
use PDF;
use PDF2;
use PushNotification;
use Session;
use Setting;
use ZipArchive;


class AdminController extends Controller {
	/**
	 * Create a new controller instance.
	 *
	 * @return void
	 */
	public function __construct() {
		$this->middleware( 'admin' );
		$this->middleware( 'demo',
			[
				'only' => [
					'settings_store',
					'settings_payment_store',
					'profile_update',
					'password_update',
					'send_push',
				],
			] );
		$this->middleware( 'permission:heat-map', [ 'only' => [ 'heatmap' ] ] );
		$this->middleware( 'permission:god-eye', [ 'only' => [ 'godseye' ] ] );
		$this->middleware( 'permission:ratings',
			[ 'only' => [ 'user_review', 'provider_review' ] ] );
		$this->middleware( 'permission:site-settings',
			[ 'only' => [ 'settings', 'settings_store' ] ] );
		$this->middleware( 'permission:db-backup',
			[ 'only' => [ 'DBbackUp' ] ] );
		$this->middleware( 'permission:payment-history',
			[ 'only' => [ 'payment' ] ] );
		$this->middleware( 'permission:payment-settings',
			[ 'only' => [ 'settings_payment', 'settings_payment_store' ] ] );
		$this->middleware( 'permission:cms-pages',
			[ 'only' => [ 'cmspages', 'pages', 'pagesearch' ] ] );
		$this->middleware( 'permission:custom-push',
			[ 'only' => [ 'push', 'send_push' ] ] );
		$this->middleware( 'permission:help', [ 'only' => [ 'help' ] ] );
		$this->middleware( 'permission:transalations',
			[ 'only' => [ 'translation' ] ] );
		$this->middleware( 'permission:account-settings',
			[ 'only' => [ 'profile', 'profile_update' ] ] );
		$this->middleware( 'permission:change-password',
			[ 'only' => [ 'password', 'password_update' ] ] );
		$this->middleware( 'permission:statements',
			[
				'only' => [
					'statement',
					'statement_provider',
					'statement_range',
					'statement_today',
					'statement_monthly',
					'statement_yearly',
				],
			] );
		$this->middleware( 'permission:settlements',
			[ 'only' => [ 'transactions', 'transferlist' ] ] );
		$this->perpage = config( 'constants.per_page', '10' );
	}


	/**
	 * Dashboard.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function dashboard() {

		try {

			Session::put( 'user', Auth::User() );
			$role = \Illuminate\Support\Facades\Auth::guard('admin')->user()->getRoleNames()->toArray();
			if($role[0]=="DISPATCHER"){
				return redirect('admin/dispatcher');
			}
			/*$UserRequest = UserRequests::with('service_type')->with('provider')->with('payment')->findOrFail(83);

			echo "<pre>";
			print_r($UserRequest->toArray());exit;

			return view('emails.invoice',['Email' => $UserRequest]);*/

//			$admin_user_type[] = array('normal','company');

			$rides     = DB::table( 'user_requests' )->leftjoin( 'users',
				'user_requests.user_id' , '=' , 'users.id' )
				->select( 'user_requests.id',
					'users.first_name',
					'users.last_name',
					'users.user_type',
					'users.company_name',
					'user_requests.status',
					'user_requests.schedule_at',
					'user_requests.created_at' )
//				->where( 'users.user_type', $admin_user_type )
				->orderBy( 'user_requests.id', 'desc' )->get();

			$cancel_rides       = UserRequests::where( 'status',
				'CANCELLED' );
			$scheduled_rides    = UserRequests::where( 'status',
				'SCHEDULED' )->count();
			$user_cancelled     = UserRequests::where( 'status',
				'CANCELLED' )->where( 'cancelled_by', 'USER' )->count();
			$provider_cancelled = UserRequests::where( 'status',
				'CANCELLED' )->where( 'cancelled_by', 'PROVIDER' )->count();
			$cancel_rides       = $cancel_rides->count();
			$service            = ServiceType::count();
			$fleet              = Fleet::count();
			$provider           = Provider::count();
			$user_count         = User::count();
			$revenue            = UserRequestPayment::sum( 'cash' ) + UserRequestPayment::sum( 'card' ) +  UserRequestPayment::sum( 'wallet' );
			$wallet['tips']     = UserRequestPayment::sum( 'tips' );
			$providers          = Provider::take( 10 )
				->orderBy( 'rating', 'desc' )->get();
			$wallet['admin']    = AdminWallet::sum( 'amount' );
			$wallet['provider_debit']
			                    =
				Provider::select( DB::raw( 'SUM(CASE WHEN wallet_balance<0 THEN wallet_balance ELSE 0 END) as total_debit' ) )
					->get()->toArray();
			$wallet['provider_credit']
			                    =
				Provider::select( DB::raw( 'SUM(CASE WHEN wallet_balance>=0 THEN wallet_balance ELSE 0 END) as total_credit' ) )
					->get()->toArray();
			$wallet['fleet_debit']
			                    =
				Fleet::select( DB::raw( 'SUM(CASE WHEN wallet_balance<0 THEN wallet_balance ELSE 0 END) as total_debit' ) )
					->get()->toArray();
			$wallet['fleet_credit']
			                    =
				Fleet::select( DB::raw( 'SUM(CASE WHEN wallet_balance>=0 THEN wallet_balance ELSE 0 END) as total_credit' ) )
					->get()->toArray();

			$wallet['admin_tax'] = AdminWallet::where( 'transaction_type',
				9 )->sum( 'amount' );
			$wallet['admin_commission']
			                     = AdminWallet::where( 'transaction_type',
				1 )->sum( 'amount' );
			$wallet['admin_discount']
			                     = AdminWallet::where( 'transaction_type',
				10 )->sum( 'amount' );
			$wallet['admin_referral']
			                     = AdminWallet::where( 'transaction_type',
				12 )->orWhere( 'transaction_type', 13 )->sum( 'amount' );
			$wallet['admin_dispute']
			                     = AdminWallet::where( 'transaction_type',
				16 )->orWhere( 'transaction_type', 17 )->sum( 'amount' );
			$wallet['peak_commission']
			                     = AdminWallet::where( 'transaction_type',
				14 )->sum( 'amount' );
			$wallet['waiting_commission']
			                     = AdminWallet::where( 'transaction_type',
				15 )->sum( 'amount' );

			$companies_debit  = 0;
			$companies_credit = 0;
			$user             = User::where( 'user_type', 'COMPANY' )->get();
			$companies_debit  = User::where( 'user_type', 'COMPANY' )->where('wallet_balance','<',0)->sum('wallet_balance');
			$companies_credit = User::where( 'user_type', 'COMPANY' )->where('wallet_balance','>',0)->sum('wallet_balance');

			$pendingReqCount = UserWalletRequest::where( 'status', 'PENDING' )
				->count();

			$commission = UserRequestPayment::select( DB::raw(
				'SUM((fixed) + (distance)) as overall, SUM(commision + peak_comm_amount + waiting_comm_amount) as commission'
			) )->first();

			// echo json_encode($revenue); exit;
			return view( 'admin.dashboard',
				compact( 'providers',
					'fleet',
					'provider',
					'scheduled_rides',
					'service',
					'rides',
					'user_cancelled',
					'provider_cancelled',
					'cancel_rides',
					'revenue',
					'wallet',
					'user_count',
					'companies_debit',
					'companies_credit',
					'pendingReqCount',
					'commission' ) );
		} catch ( Exception $e ) {
			return redirect()->route( 'admin.user.index' )
				->with( 'flash_error', 'Something Went Wrong with Dashboard!' );
		}
	}

	public function revenue_monthly( Request $request ) {
		$month = $request->month;
		if ( empty( $month ) ) {
			$month = 0;
		}
		if ( $month == 0 ) {
			$commission = UserRequestPayment::select( DB::raw(
				'SUM((fixed) + (distance)) as overall, SUM((commision)) as commission'
			) );
		} else {
			$commission = UserRequestPayment::select( DB::raw(
				'SUM((fixed) + (distance)) as overall, SUM((commision)) as commission'
			) );
			$year       = Carbon::now()->format( "Y" );
			$commission = $commission->whereRaw( 'MONTH(created_at) = "'
			                                     . $month . '"' )
				->whereRaw( 'YEAR(created_at) = "' . $year . '"' );
		}

		// DB::enableQueryLog();
		$commission = $commission->first();
		// $laQuery = DB::getQueryLog();
			// dd($laQuery);
		// DB::disableQueryLog();
		echo currency( ! $commission ? 0 : $commission->commission );
	}

	/**
	 * Heat Map.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */

	public function get_heatmap() {
		$rides = UserRequests::has( 'user' )->orderBy( 'id', 'desc' )->get();

		$data = [];

		foreach ( $rides as $ride ) {
			$data[] = [
				'lat' => $ride->s_latitude,
				'lng' => $ride->s_longitude,
			];
		}

		return $data;
	}

	public function heatmap() {
		return view( 'admin.heatmap' );
	}

	public function godseye() {
		$providers = Provider::whereHas( 'trips',
			function ( $query ) {
				$query->where( 'status', 'STARTED' );
			} )
			->select( 'id', 'first_name', 'last_name', 'latitude', 'longitude' )
			->get();

		return view( 'admin.godseye' );
	}

	public function godseye_list( Request $request ) {
		try {

			if ( $request->status == 'STARTED' || $request->status == 'ARRIVED'
			     || $request->status == 'PICKEDUP'
			) {

				$status = $request->status;

				$providers = Provider::with( [
					'service.service_type',
					'trips',
				] )->whereHas( 'trips',
					function ( $query ) use ( $status ) {
						$query->where( 'status', $status );
					} )->select( 'id',
					'first_name',
					'last_name',
					'mobile',
					'email',
					'latitude',
					'longitude' )->get();
			} elseif ( $request->status == 'ACTIVE' ) {

				$providers = Provider::with( [
					'service.service_type',
					'trips',
				] )->whereHas( 'service',
					function ( $query ) {
						$query->where( 'status', 'active' );
					} )->select( 'id',
					'first_name',
					'last_name',
					'mobile',
					'email',
					'latitude',
					'longitude' )->get();
			} else {

				$providers = Provider::with( [
					'service.service_type',
					'trips',
				] )->whereHas( 'service',
					function ( $query ) {
						$query->whereIn( 'status', [ 'active', 'riding' ] );
					} )->select( 'id',
					'first_name',
					'last_name',
					'mobile',
					'email',
					'avatar',
					'status',
					'latitude',
					'longitude' )->get();
			}

			$locations = [];

			foreach ( $providers as $provider ) {
				$locations[] = [
					'name'      => $provider->first_name . " "
					               . $provider->last_name,
					'lat'       => $provider->latitude,
					'lng'       => $provider->longitude,
					'car_image' => asset( 'asset/img/cars/car.png' ),
				];
			}

			return response()->json( [
				'providers' => $providers,
				'locations' => $locations,
			] );
		} catch ( Exception $e ) {
			return response()->json( [ 'error' => 'Something Went Wrong!' ] );
		}
	}

	/**
	 * Map of all Users and Drivers.
	 *
	 * @return Response
	 */
	public function map_index() {
		return view( 'admin.map.index' );
	}

	/**
	 * Map of all Users and Drivers.
	 *
	 * @return Response
	 */
	public function map_ajax() {
		try {

			$Providers = Provider::where( 'latitude', '!=', 0 )
				->where( 'longitude', '!=', 0 )
				->with( 'service' )
				->get();

			$Users = User::where( 'latitude', '!=', 0 )
				->where( 'longitude', '!=', 0 )
				->get();

			for ( $i = 0; $i < sizeof( $Users ); $i ++ ) {
				$Users[ $i ]->status = 'user';
			}

			$All = $Users->merge( $Providers );

			return $All;
		} catch ( Exception $e ) {
			return [];
		}
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function settings() {

		return view( 'admin.settings.application' );
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function settings_store( Request $request ) {
		/*$this->validate($request,[
			'user_pem' => 'mimes:pem',
			'provider_pem' => 'mimes:pem',
		);*/

		$config = base_path() . '/config/constants.php';

		if ( ! file_exists( $config ) ) {
			$constantFile = fopen( $config, "w" );

			$data = "<?php 
				
				return array(
					'site_title' => 'Tranxit',
					'site_logo' => '',
					'site_email_logo' => '',
					'site_icon' => '',
					'site_copyright' => '&copy; 2019 Appoets',
					'terms_conditions' => 'https://memohi.fr/terms',
					'provider_select_timeout' => '60',
					'provider_search_radius' => '100',
					'base_price' => '50',
					'price_per_minute' => '50',
					'tax_percentage' => '0',
					'manual_request' => '0',
					'broadcast_request' => '0',
					'default_lang' => 'en',
					'currency' => '$',
					'distance' => 'Kms',
					'scheduled_cancel_time_exceed' => '10',
					'price_per_kilometer' => '10',
					'commission_percentage' => '0',
					'store_link_android_provider' => '',
					'store_link_ios_user' => '',
					'store_link_ios_provider' => '',
					'version_ios_user' => '',
					'version_android_user' => '',
					'version_ios_provider' => '',
					'version_android_provider' => '',
					'store_facebook_link' => '',
					'store_twitter_link' => '',
					'daily_target' => '0',
					'surge_percentage' => '0',
					'waiting_percentage' => '0',
					'peak_percentage' => '0',
					'surge_trigger' => '0',
					'demo_mode' => '0',
					'booking_prefix' => 'TRNX',
					'sos_number' => '911',
					'contact_number' => '',
					'contact_email' => 'admin@tranxit.com',
					'environment' => '',
					'ios_push_password' => '',
					'android_push_key' => '',
					'timezone' => 'Asia/Kolkata',
					'map_key' => '',
					'social_login' => '0',
					'facebook_app_id' => '',
					'facebook_app_secret' => '',
					'facebook_app_version' => '',
					'facebook_redirect' => '',
					'facebook_client_id' => '',
					'facebook_client_secret' => '',
					'google_redirect' => '',
					'google_client_id' => '',
					'google_client_secret' => '',
					'cash' => '1',
					'card' => '0',
					'stripe_secret_key' => '',
					'stripe_publishable_key' => '',
                    'stripe_currency' => 'USD',
					'payumoney' => '0',
					'payumoney_environment' => 'test',
                    'payumoney_merchant_id' => '',
                    'payumoney_key' => '',
				    'payumoney_salt' => '',
				    'payumoney_auth' => '',
				    'paypal' => '0',
				    'paypal_environment' => 'sandbox',
                    'paypal_currency' => 'USD',
				    'paypal_client_id' => '',
				    'paypal_client_secret' => '',
				    'paypal_adaptive' => '0',
				    'paypal_adaptive_environment' => 'sandbox',
				    'paypal_username' => '',
				    'paypal_password' => '',
				    'paypal_secret' => '',
				    'paypal_certificate' => '',
				    'paypal_app_id' => '',
				    'paypal_adaptive_currency' => 'USD',
				    'paypal_email' => '',
				    'braintree' => '0',
				    'braintree_environment' => 'sandbox',
				    'braintree_merchant_id' => '',
				    'braintree_public_key' => '',
				    'braintree_private_key' => '',
				    'paytm' => '0',
                    'paytm_environment' => 'local',
                    'paytm_merchant_id' => '',
                    'paytm_merchant_key' => '',
                    'paytm_channel' => 'WEB',
                    'paytm_website' => 'WEBSTAGING',
                    'paytm_industry_type' => 'Retail',
                    'minimum_negative_balance' => '-10',
					'ride_otp' => '0',
					'fleet_commission_percentage' => '0',
					'provider_commission_percentage' => '0',
					'per_page' => '10',
					'send_email' => '0',
					'referral' => '0',
					'referral_count' => '0',
					'referral_amount' => '0',
					'track_distance' => '1',
					'mail_driver' => '',
					'mail_host' => '',
					'mail_port' => '',
					'mail_from_address' => '',
					'mail_from_name' => '',
					'mail_encryption' => '',
					'mail_username' => '',
					'mail_password' => '',
					'mail_domain' => '',
					'mail_secret' => '',
					'twilio_sid' => '',
					'twilio_token' => '',
					'twilio_from' => '',
					'sms_to_user' => '0',
					'sms_to_fleet' => '0',
				);";

			fwrite( $constantFile, $data );
			fclose( $constantFile );
			chmod( $config, 0777 );
		}
		chmod( $config, 0777 );
		$file           = file_get_contents( $config );
		$change_content = $file;


		if ( ! $request->has( 'ride_otp' ) ) {
			$search_text    = "'ride_otp' => '1'";
			$value_text     = "'ride_otp' => '0'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		} else {
			$search_text    = "'ride_otp' => '0'";
			$value_text     = "'ride_otp' => '1'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		}

		if ( ! $request->has( 'send_email' ) ) {
			$search_text    = "'send_email' => '1'";
			$value_text     = "'send_email' => '0'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		} else {
			$search_text    = "'send_email' => '0'";
			$value_text     = "'send_email' => '1'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		}

		if ( ! $request->has( 'referral' ) ) {
			$search_text    = "'referral' => '1'";
			$value_text     = "'referral' => '0'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		} else {
			$search_text    = "'referral' => '0'";
			$value_text     = "'referral' => '1'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		}

		if ( ! $request->has( 'manual_request' ) ) {
			$search_text    = "'manual_request' => '1'";
			$value_text     = "'manual_request' => '0'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		} else {
			$search_text    = "'manual_request' => '0'";
			$value_text     = "'manual_request' => '1'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		}

		if ( ! $request->has( 'broadcast_request' ) ) {
			$search_text    = "'broadcast_request' => '1'";
			$value_text     = "'broadcast_request' => '0'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		} else {
			$search_text    = "'broadcast_request' => '0'";
			$value_text     = "'broadcast_request' => '1'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		}

		if ( $request->hasFile( 'user_pem' ) ) {
			$request->file( 'user_pem' )->storeAs(
				"apns/",
				'user.pem'
			);
		}

		if ( $request->hasFile( 'provider_pem' ) ) {
			$request->file( 'provider_pem' )->storeAs(
				"apns/",
				'provider.pem'
			);
		}

		file_put_contents( $config, $change_content );

		foreach (
			$request->except( [
				'_token',
				'site_logo',
				'site_icon',
				'site_email_logo',
				'user_pem',
				'provider_pem',
				'paypal_certificate',
			] ) as $key => $value
		) {
			$value     = ( trim( $value ) == 'on' ) ? '1' : trim( $value );
			$searchfor = config( 'constants.' . $key );
			if ( $value != $searchfor ) {
				$search_text    = "'" . $key . "' => '" . $searchfor . "'";
				$value_text     = "'" . $key . "' => '" . $value . "'";
//				Session::put( "'" .$key. "'", $value );

				$change_content = str_replace( $search_text,
					$value_text,
					$change_content );
			}

            config()->set( 'constants.' . $key,$value );
			file_put_contents( $config, $change_content );

		}

		if ( $request->hasFile( 'site_icon' ) ) {
			$site_icon
				            =
				Helper::upload_picture( $request->file( 'site_icon' ) );
			$search_text    = "'site_icon' => '"
			                  . config( 'constants.site_icon' ) . "'";
			$value_text     = "'site_icon' => '" . $site_icon . "'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		}

		if ( $request->hasFile( 'site_logo' ) ) {
			$site_logo = Helper::upload_picture( $request->file( 'site_logo' ) );
//            config()->set('constants.site_logo',$site_logo);
			$search_text    = "'site_logo' => '"
			                  . config( 'constants.site_logo' ) . "'";
			$value_text     = "'site_logo' => '" . $site_logo . "'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		}

		if ( $request->hasFile( 'site_email_logo' ) ) {
			$site_email_logo
				            =
				Helper::upload_picture( $request->file( 'site_email_logo' ) );
			$search_text    = "'site_email_logo' => '"
			                  . config( 'constants.site_email_logo' ) . "'";
			$value_text     = "'site_email_logo' => '" . $site_email_logo . "'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		}

		file_put_contents( $config, $change_content );
//		Artisan::call( 'config:clear' );
//		Artisan::call( 'cache:clear' );
//		Artisan::call( 'view:clear' );
//		Artisan::call( 'view:cache' );
//		system('composer dump-autoload');
//        dd($value,config()->get( 'constants.site_title'  ));
		return response()->json( ['status'=>true,'message'=>'Settings Updated Successfully'] );

	}


	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function settings_payment() {
		return view( 'admin.payment.settings' );
	}

	/**
	 * Save payment related settings.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function settings_payment_store( Request $request ) {
		if ( $request->has( 'card' ) ) {
			$this->validate( $request,
				[
					'card'                   => 'in:on',
					'cash'                   => 'in:on',
					'payumoney'              => 'in:on',
					'paypal'                 => 'in:on',
					'paypal_adaptive'        => 'in:on',
					'braintree'              => 'in:on',
					'stripe_secret_key'      => 'required_if:card,on|max:255',
					'stripe_publishable_key' => 'required_if:card,on|max:255',
				] );
		}
		if ( $request->has( 'daily_target' ) ) {
			$this->validate( $request,
				[
					'card'                   => 'in:on',
					'cash'                   => 'in:on',
					'payumoney'              => 'in:on',
					'paypal'                 => 'in:on',
					'paypal_adaptive'        => 'in:on',
					'braintree'              => 'in:on',
					'stripe_secret_key'      => 'required_if:card,on|max:255',
					'stripe_publishable_key' => 'required_if:card,on|max:255',
				] );
		}

		$config = base_path() . '/config/constants.php';

		$file           = file_get_contents( $config );
		$change_content = $file;

		if ( ! $request->has( 'daily_target' ) ) {
			if ( ! $request->has( 'cash' ) ) {
				$search_text    = "'cash' => '1'";
				$value_text     = "'cash' => '0'";
				$change_content = str_replace( $search_text,
					$value_text,
					$change_content );
			}

			if ( ! $request->has( 'card' ) ) {
				$search_text    = "'card' => '1'";
				$value_text     = "'card' => '0'";
				$change_content = str_replace( $search_text,
					$value_text,
					$change_content );
			}

			if ( ! $request->has( 'payumoney' ) ) {
				$search_text    = "'payumoney' => '1'";
				$value_text     = "'payumoney' => '0'";
				$change_content = str_replace( $search_text,
					$value_text,
					$change_content );
			}

			if ( ! $request->has( 'paypal' ) ) {
				$search_text    = "'paypal' => '1'";
				$value_text     = "'paypal' => '0'";
				$change_content = str_replace( $search_text,
					$value_text,
					$change_content );
			}

			if ( ! $request->has( 'paypal_adaptive' ) ) {
				$search_text    = "'paypal_adaptive' => '1'";
				$value_text     = "'paypal_adaptive' => '0'";
				$change_content = str_replace( $search_text,
					$value_text,
					$change_content );
			}

			if ( ! $request->has( 'braintree' ) ) {
				$search_text    = "'braintree' => '1'";
				$value_text     = "'braintree' => '0'";
				$change_content = str_replace( $search_text,
					$value_text,
					$change_content );
			}

			if ( ! $request->has( 'paytm' ) ) {
				$search_text    = "'paytm' => '1'";
				$value_text     = "'paytm' => '0'";
				$change_content = str_replace( $search_text,
					$value_text,
					$change_content );
			}

			if ( ( $request->has( 'cash' ) == 0
			       && $request->has( 'card' ) == 0 )
			     && $request->has( 'payumoney' ) == 0
			     && $request->has( 'paypal' ) == 0
			     && $request->has( 'paypal_adaptive' ) == 0
			     && $request->has( 'braintree' ) == 0
			     && $request->has( 'paytm' ) == 0
			) {

				return back()->with( 'flash_error',
					'Atleast one payment mode must be enable.' );
			}
		}


		if ( $request->hasFile( 'paypal_certificate' ) ) {
			$request->file( 'paypal_certificate' )->storeAs(
				"certs/",
				'cert_key.pem'
			);

			$search_text    = "'paypal_certificate' => ''";
			$value_text     = "'paypal_certificate' => '" . base_path()
			                  . "/app/public/certs/cert_key.pem'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );

			$search_text    = "'paypal_certificate' => '" . base_path()
			                  . "/app/public/certs/cert_key.pem'";
			$value_text     = "'paypal_certificate' => '" . base_path()
			                  . "/app/public/certs/cert_key.pem'";
			$change_content = str_replace( $search_text,
				$value_text,
				$change_content );
		}

		foreach (
			$request->except( [
				'_token',
				'site_logo',
				'site_icon',
				'site_email_logo',
				'user_pem',
				'provider_pem',
				'paypal_certificate',
			] ) as $key => $value
		) {
			$value     = ( trim( $value ) == 'on' ) ? '1' : trim( $value );
			$searchfor = config( 'constants.' . $key );
			if ( $value != $searchfor ) {
				$search_text    = "'" . $key . "' => '" . $searchfor . "'";
				$value_text     = "'" . $key . "' => '" . $value . "'";
				$change_content = str_replace( $search_text,
					$value_text,
					$change_content );
			}
		}

		file_put_contents( $config, $change_content );
		Artisan::call( 'config:clear' );
		Artisan::call( 'cache:clear' );
		Artisan::call( 'view:clear' );
		Artisan::call( 'view:cache' );
		system('composer dump-autoload');

		return redirect( '/admin/settings/payment' )->with( 'flash_success',
			'Settings Updated Successfully' );
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function profile()
	{
		$role = \Illuminate\Support\Facades\Auth::guard('admin')->user()->getRoleNames()->toArray();

		if($role[0] === "DISPATCHER")
		{
			return view('dispatcher.account.profile');
		}else{
			return view( 'admin.account.profile' );
		}

	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function profile_update( Request $request ) {

		$this->validate( $request,
			[
				'name'     => 'required|max:255',
				'email'    => 'required|max:255|email|unique:admins,email,'
				              . Auth::guard( 'admin' )->user()->id . ',id',
				'picture'  => 'mimes:jpeg,jpg,bmp,png|max:5242880',
				'country'  => 'max:255',
				'zip_code' => 'max:255',
				'city'     => 'max:255',
				'address'  => 'max:255',
				'note'     => 'max:255',
			] );

		try {
			$admin           = Auth::guard( 'admin' )->user();
			$admin->name     = $request->name;
			$admin->email    = $request->email;
			$admin->language = $request->language;
			$admin->country  = $request->country;
			$admin->zip_code = $request->zip_code;
			$admin->city     = $request->city;
			$admin->address  = $request->address;
			$admin->note     = $request->note;

			if ( $request->hasFile( 'picture' ) ) {
				$admin->picture = $request->picture->store( 'admin/profile' );
			}
			$admin->save();

			Session::put( 'user', Auth::User() );

			return redirect()->back()
				->with( 'flash_success', 'Profile Updated' );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function password()
	{
		$role = \Illuminate\Support\Facades\Auth::guard('admin')->user()->getRoleNames()->toArray();
		if($role[0] === "DISPATCHER")
		{
			return view('dispatcher.account.change-password');
		}else{
			return view( 'admin.account.change-password' );
		}


	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function password_update( Request $request ) {

		$this->validate( $request,
			[
				'old_password' => 'required',
				'password'     => 'required|min:6|confirmed',
			] );

		try {

			$Admin = Admin::find( Auth::guard( 'admin' )->user()->id );

			if ( password_verify( $request->old_password, $Admin->password ) ) {
				$Admin->password = bcrypt( $request->password );
				$Admin->save();

				return redirect()->back()
					->with( 'flash_success', 'Password Updated' );
			}
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function payment( Request $request ) {
		try {

			$payments = UserRequests::where( 'paid', 1 )
				->has( 'user' )
				->has( 'provider' )
				->has( 'payment' )
				->orderBy( 'user_requests.created_at', 'desc' );

			// $pagination = (new Helper)->formatPagination($payments);

			$from_date = $request->input( 'from_date' );
			$to_date   = $request->input( 'to_date' );
			$type      = $request->input( 'date_filter' );

			if ( $from_date && $to_date && $type ) {
				switch ( $type ) {
					case 'tday':
					case 'yday':
						$payments = $payments->whereDate( 'created_at',
							date( 'Y-m-d', strtotime( $from_date ) ) );
						break;
					default:
						$payments = $payments->whereBetween( 'created_at',
							[
								Carbon::createFromFormat( 'Y-m-d', $from_date ),
								Carbon::createFromFormat( 'Y-m-d', $to_date ),
							] );
						break;
				}
			}

			$payments = $payments->get();

			$dates['yesterday']      = Carbon::yesterday()->format( 'Y-m-d' );
			$dates['today']          = Carbon::today()->format( 'Y-m-d' );
			$dates['pre_week_start'] = date( "Y-m-d",
				strtotime( "last week monday" ) );
			$dates['pre_week_end']   = date( "Y-m-d",
				strtotime( "last week sunday" ) );
			$dates['cur_week_start'] = Carbon::today()->startOfWeek()
				->format( 'Y-m-d' );
			$dates['cur_week_end']   = Carbon::today()->endOfWeek()
				->format( 'Y-m-d' );
			$dates['pre_month_start']
			                         =
				Carbon::parse( 'first day of last month' )
					->format( 'Y-m-d' );
			$dates['pre_month_end']
			                         = Carbon::parse( 'last day of last month' )
				->format( 'Y-m-d' );
			$dates['cur_month_start']
			                         =
				Carbon::parse( 'first day of this month' )
					->format( 'Y-m-d' );
			$dates['cur_month_end']
			                         = Carbon::parse( 'last day of this month' )
				->format( 'Y-m-d' );
			$dates['pre_year_start'] = date( "Y-m-d",
				strtotime( "last year January 1st" ) );
			$dates['pre_year_end']   = date( "Y-m-d",
				strtotime( "last year December 31st" ) );
			$dates['cur_year_start'] = Carbon::parse( 'first day of January' )
				->format( 'Y-m-d' );
			$dates['cur_year_end']   = Carbon::parse( 'last day of December' )
				->format( 'Y-m-d' );
			$dates['nextWeek']       = Carbon::today()->addWeek()
				->format( 'Y-m-d' );

			return view( 'admin.payment.payment-history',
				compact( 'payments',
					'dates',
					'from_date',
					'to_date',
					'type' ) );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function help() {
		try {
			$str
				  =
				'{"content":"<p>We&#39;d like to thank you for deciding to use our script. We enjoyed creating it and hope you enjoy using it to achieve your goals :)&nbsp;If you want something changed to suit&nbsp;your venture&#39;s needs better, drop us a line: info@tranxit.com<\/p>\r\n"}';
			$Data = json_decode( $str, true );

			return view( 'admin.help', compact( 'Data' ) );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	/**
	 * User Rating.
	 *
	 * @return Response
	 */
	public function user_review() {
		try {
			$Reviews    = UserRequestRating::where( 'user_id', '!=', 0 )
				->with( 'user', 'provider' )->paginate( $this->perpage );
			$pagination = ( new Helper )->formatPagination( $Reviews );

			return view( 'admin.review.user_review',
				compact( 'Reviews', 'pagination' ) );
		} catch ( Exception $e ) {
			return redirect()->route( 'admin.setting' )
				->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	/**
	 * Provider Rating.
	 *
	 * @return Response
	 */
	public function provider_review() {
		try {
			$Reviews    = UserRequestRating::where( 'provider_id', '!=', 0 )
				->with( 'user', 'provider' )->paginate( $this->perpage );
			$pagination = ( new Helper )->formatPagination( $Reviews );

			return view( 'admin.review.provider_review',
				compact( 'Reviews', 'pagination' ) );
		} catch ( Exception $e ) {
			return redirect()->route( 'admin.setting' )
				->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	/**
	 * Remove the specified resource from storage.
	 *
	 * @param ProviderService
	 *
	 * @return Response
	 */
	public function destory_provider_service( $id ) {
		try {
			ProviderService::find( $id )->delete();

			return back()->with( 'message', 'Service deleted successfully' );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	/**
	 * Testing page for push notifications.
	 *
	 * @return Response
	 */
	public function push_index() {

		$data = PushNotification::app( 'IOSUser' )
			->to( '3911e9870e7c42566b032266916db1f6af3af1d78da0b52ab230e81d38541afa' )
			->send( 'Hello World, i`m a push message' );
//		dd( $data );
	}

	/**
	 * Testing page for push notifications.
	 *
	 * @return Response
	 */
	public function push_store( Request $request ) {
		// try {
		// 	ProviderService::find($id)->delete();
		// 	return back()->with('message', 'Service deleted successfully');
		// } catch (Exception $e) {
		return back()->with( 'flash_error', 'Something Went Wrong!' );
		// }
	}

	/**
	 * privacy.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */

	public function cmspages() {
		return view( 'admin.pages.static' );
	}

	/**
	 * pages.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function pages( Request $request ) {
		$this->validate( $request,
			[
				'types' => 'required|not_in:select',
			] );

		Setting::set( $request->types, $request->contents );
		Setting::save();

		return back()->with( 'flash_success', 'Content Updated!' );
	}

	public function pagesearch( $request ) {
		$value = Setting::get( $request );

		return $value;
	}

	/**
	 * account statements today.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function statement_today() {
		return $this->statement( 'today' );
	}

	/**
	 * account statements.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function statement( $type = '', $request = null )
	{
		try {

			if ( ( isset( $request->provider_id )
			       && $request->provider_id != null )
			     || ( isset( $request->user_id ) && $request->user_id != null )
			     || ( isset( $request->fleet_id )
			          && $request->fleet_id != null ))
			{

				$pages    = trans( 'admin.include.overall_ride_statments' );
				$listname = trans( 'admin.include.overall_ride_earnings' );
				if ( $type == 'individual' ) {
					$pages    = trans( 'admin.include.provider_statement' );
					$listname = trans( 'admin.include.provider_earnings' );
				} elseif ( $type == 'today' ) {
					$pages    = trans( 'admin.include.today_statement' ) . ' - '
					            . date( 'd M Y' );
					$listname = trans( 'admin.include.today_earnings' );
				} elseif ( $type == 'monthly' ) {
					$pages    = trans( 'admin.include.monthly_statement' )
					            . ' - ' . date( 'F' );
					$listname = trans( 'admin.include.monthly_earnings' );
				} elseif ( $type == 'yearly' ) {
					$pages    = trans( 'admin.include.yearly_statement' )
					            . ' - ' . date( 'Y' );
					$listname = trans( 'admin.include.yearly_earnings' );
				} elseif ( $type == 'range' ) {
					$pages = trans( 'admin.include.statement_from' ) . ' '
					         . Carbon::createFromFormat( 'Y-m-d',
							$request->from_date )->format( 'd M Y' ) . '  '
					         . trans( 'admin.include.statement_to' ) . ' '
					         . Carbon::createFromFormat( 'Y-m-d',
							$request->to_date )->format( 'd M Y' );
				}

				if ( isset( $request->provider_id ) && $request->provider_id != null)
				{

					$id            = $request->provider_id;
					$statement_for = "provider";
					$rides         = UserRequests::where( 'provider_id', $id )
						->with( 'payment' )->orderBy( 'id', 'desc' );
					$cancel_rides  = UserRequests::where( 'status',
						'CANCELLED' )->where( 'provider_id', $id );
					$Provider      = Provider::find( $id );
					$revenue       = UserRequestPayment::whereHas( 'request',
						function ( $query ) use ( $id ) {
							$query->where( 'provider_id', $id );
						} )->select( DB::raw(
						'SUM(provider_pay) as overall, SUM(commision + peak_comm_amount + waiting_comm_amount) as commission'
					) );
					$page          = $Provider->first_name . "'s " . $pages;
				} elseif ( isset( $request->user_id )  && $request->user_id != null )
				{
					$id            = $request->user_id;
					$statement_for = "user";
					$rides         = UserRequests::where( 'user_id', $id )
						->with( 'payment' )->orderBy( 'id', 'desc' );
					$cancel_rides  = UserRequests::where( 'status',
						'CANCELLED' )->where( 'user_id', $id );
					$user          = User::find( $id );
					$revenue       = UserRequestPayment::whereHas( 'request',
						function ( $query ) use ( $id ) {
							$query->where( 'user_id', $id );
						} )->select( DB::raw(
						'SUM(total) as overall'
					) );
					$page          = $user->first_name . "'s " . $pages;
				}
				else
				{

					//admin/statement_fleet/1/statement_fleet
					$id            = $request->fleet_id;
					$statement_for = "fleet";
					$user_ID_Of_Fleet = User::where( 'fleet_id', $id )->pluck( 'id' );

					$rides         = UserRequests::whereIn( 'user_requests.user_id', $user_ID_Of_Fleet )
						->with( 'payment' )->orderBy( 'id', 'desc' );

					$cancel_rides =
						UserRequests::whereIn( 'user_id', $user_ID_Of_Fleet )
							->where( 'status', 'CANCELLED' );
					$fleet   = Fleet::find( $id );
					$revenue =
						UserRequestPayment::whereIn( 'user_id', $user_ID_Of_Fleet )
							->select( DB::raw(
								'SUM(provider_pay) as overall'
							) );
					$page          = $fleet->name . "'s " . $pages;
				}
			} else {

				Session::forget('from_date');
				Session::forget('to_date');
				$id            = '';
				$statement_for = "";
				$page
				               =
					trans( 'admin.include.overall_ride_statments' );
				$listname      = trans( 'admin.include.overall_ride_earnings' );
				if ( $type == 'individual' ) {
					$page     = trans( 'admin.include.provider_statement' );
					$listname = trans( 'admin.include.provider_earnings' );
				} elseif ( $type == 'today' ) {
					$page     = trans( 'admin.include.today_statement' ) . ' - '
					            . date( 'd M Y' );
					$listname = trans( 'admin.include.today_earnings' );
				} elseif ( $type == 'monthly' ) {
					$page     = trans( 'admin.include.monthly_statement' )
					            . ' - ' . date( 'F' );
					$listname = trans( 'admin.include.monthly_earnings' );
				} elseif ( $type == 'yearly' ) {
					$page     = trans( 'admin.include.yearly_statement' )
					            . ' - ' . date( 'Y' );
					$listname = trans( 'admin.include.yearly_earnings' );
				} elseif ( $type == 'range' ) {
					$page = trans( 'admin.include.statement_from' ) . ' '
					        . Carbon::createFromFormat( 'Y-m-d',
							$request->from_date )->format( 'd M Y' ) . '  '
					        . trans( 'admin.include.statement_to' ) . ' '
					        . Carbon::createFromFormat( 'Y-m-d',
							$request->to_date )->format( 'd M Y' );
				}

				$rides = UserRequests::with( 'payment' )
					->orderBy( 'id', 'desc' );

				$cancel_rides = UserRequests::where( 'status', 'CANCELLED' );
				$revenue      = UserRequestPayment::select( DB::raw(
//					'SUM((fixed) + (distance)) as overall, SUM((commision)) as commission'
					'SUM(total) as overall,  SUM(commision + peak_comm_amount + waiting_comm_amount) as commission'
				) );
			}


			if ( $type == 'today' ) {

				$rides->where( 'user_requests.created_at', '>=', Carbon::today() );
				$cancel_rides->where( 'user_requests.created_at', '>=', Carbon::today() );
				$revenue->where( 'user_requests.created_at', '>=', Carbon::today() );
			} elseif ( $type == 'monthly' ) {

				$rides->where( 'user_requests.created_at', '>=', Carbon::now()->month );
				$cancel_rides->where( 'user_requests.created_at',
					'>=',
					Carbon::now()->month );
				$revenue->where( 'user_requests.created_at', '>=', Carbon::now()->month );
			} elseif ( $type == 'yearly' ) {

				$rides->where( 'user_requests.created_at', '>=', Carbon::now()->year );
				$cancel_rides->where( 'user_requests.created_at', '>=', Carbon::now()->year );
				$revenue->where( 'user_requests.created_at', '>=', Carbon::now()->year );
			} elseif ( $type == 'range' ) {
				Session::put('from_date',date( 'Y-m-d', strtotime( $request->from_date ) ));
				Session::put('to_date',date( 'Y-m-d', strtotime( $request->to_date ) ));
				if ( $request->from_date == $request->to_date ) {
					$rides->whereDate( 'user_requests.created_at',
						date( 'Y-m-d', strtotime( $request->from_date ) ) );
					$cancel_rides->whereDate( 'user_requests.created_at',
						date( 'Y-m-d', strtotime( $request->from_date ) ) );
					$revenue->whereDate( 'user_request_payments.created_at',
						date( 'Y-m-d', strtotime( $request->from_date ) ) );
				} else {
					$rides->whereBetween( 'user_requests.created_at',
						[
							Carbon::createFromFormat( 'Y-m-d',
								$request->from_date ),
							Carbon::createFromFormat( 'Y-m-d',
								$request->to_date ),
						] );
					$cancel_rides->whereBetween( 'user_requests.created_at',
						[
							Carbon::createFromFormat( 'Y-m-d',
								$request->from_date ),
							Carbon::createFromFormat( 'Y-m-d',
								$request->to_date ),
						] );
					$revenue->whereBetween( 'user_request_payments.created_at',
						[
							Carbon::createFromFormat( 'Y-m-d',
								$request->from_date ),
							Carbon::createFromFormat( 'Y-m-d',
								$request->to_date ),
						] );
				}
			}

			$rides = $rides->get();
//			dd($rides);
			// $rides = $rides->paginate($this->perpage);
			// if ($type == 'range') {
			// 	$path = 'range?from_date=' . $request->from_date . '&to_date=' . $request->to_date;
			// 	$rides->setPath($path);
			// }
			// $pagination = (new Helper)->formatPagination($rides);
			$cancel_rides = $cancel_rides->count();
			$revenue      = $revenue->get();

			$dates['yesterday']      = Carbon::yesterday()->format( 'Y-m-d' );
			$dates['today']          = Carbon::today()->format( 'Y-m-d' );
			$dates['pre_week_start'] = date( "Y-m-d",
				strtotime( "last week monday" ) );
			$dates['pre_week_end']   = date( "Y-m-d",
				strtotime( "last week sunday" ) );
			$dates['cur_week_start'] = Carbon::today()->startOfWeek()
				->format( 'Y-m-d' );
			$dates['cur_week_end']   = Carbon::today()->endOfWeek()
				->format( 'Y-m-d' );
			$dates['pre_month_start']
			                         =
				Carbon::parse( 'first day of last month' )
					->format( 'Y-m-d' );
			$dates['pre_month_end']
			                         = Carbon::parse( 'last day of last month' )
				->format( 'Y-m-d' );
			$dates['cur_month_start']
			                         =
				Carbon::parse( 'first day of this month' )
					->format( 'Y-m-d' );
			$dates['cur_month_end']
			                         = Carbon::parse( 'last day of this month' )
				->format( 'Y-m-d' );
			$dates['pre_year_start'] = date( "Y-m-d",
				strtotime( "last year January 1st" ) );
			$dates['pre_year_end']   = date( "Y-m-d",
				strtotime( "last year December 31st" ) );
			$dates['cur_year_start'] = Carbon::parse( 'first day of January' )
				->format( 'Y-m-d' );
			$dates['cur_year_end']   = Carbon::parse( 'last day of December' )
				->format( 'Y-m-d' );
			$dates['nextWeek']       = Carbon::today()->addWeek()
				->format( 'Y-m-d' );

			$from_date = $request ? $request->from_date : "";
			$to_date   = $request ? $request->to_date : "";

			return view( 'admin.providers.statement',
				compact( 'rides',
					'cancel_rides',
					'revenue',
					'dates',
					'id',
					'statement_for',
					'from_date',
					'to_date',
					'type' ) )
				->with( 'page', $page )->with( 'listname', $listname );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	/**
	 * account statements monthly.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function statement_monthly() {
		return $this->statement( 'monthly' );
	}

	/**
	 * account statements monthly.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function statement_yearly() {
		return $this->statement( 'yearly' );
	}


	/**
	 * account statements range.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function statement_range( Request $request ) {
		return $this->statement( 'range', $request );
	}

	/**
	 * account statements.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function statement_provider() {

		try {

			$Providers = Provider::paginate( $this->perpage );

			$pagination = ( new Helper )->formatPagination( $Providers );

			foreach ( $Providers as $index => $Provider ) {

				$Rides = UserRequests::where( 'provider_id', $Provider->id )
					->where( 'status', '<>', 'CANCELLED' )
					->get()->pluck( 'id' );

				$Providers[ $index ]->rides_count = $Rides->count();

				$Providers[ $index ]->payment
					= UserRequestPayment::whereIn( 'request_id', $Rides )
					->select( DB::raw(
						'SUM((provider_pay)) as overall,  SUM(commision + peak_comm_amount + waiting_comm_amount) as commission'
					) )->get();
			}

			return view( 'admin.providers.provider-statement',
				compact( 'Providers', 'pagination' ) )->with( 'page',
				'Providers Statement' );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	public function statement_user() {

		try {

			$Users = User::paginate( $this->perpage );

			$pagination = ( new Helper )->formatPagination( $Users );

			foreach ( $Users as $index => $User ) {

				$Rides = UserRequests::where( 'user_id', $User->id )
					->where( 'status', '<>', 'CANCELLED' )
					->get()->pluck( 'id' );

				$Users[ $index ]->rides_count = $Rides->count();

				$Users[ $index ]->payment
					= UserRequestPayment::whereIn( 'request_id', $Rides )
					->select( DB::raw(
						'SUM((total)) as overall'
					) )->get();
			}

			return view( 'admin.providers.user-statement',
				compact( 'Users', 'pagination' ) )->with( 'page',
				'Users Statement' );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}

	public function statement_fleet() {

		try {

			$Fleets = Fleet::paginate( $this->perpage );

			$pagination = ( new Helper )->formatPagination( $Fleets );

			foreach ( $Fleets as $index => $Fleet ) {

				$user_ids_fleet = User::where('fleet_id',$Fleet->id)->pluck('id');
				$Rides = UserRequestPayment::whereIn( 'user_id', $user_ids_fleet )
					->get()->pluck( 'id' );

				$Fleets[ $index ]->rides_count = $Rides->count();

				$Fleets[ $index ]->payment
					= UserRequestPayment::whereIn( 'user_id',  $user_ids_fleet)
					->select( DB::raw(
						'SUM((provider_pay)) as overall'
					) )->get();
			}

			return view( 'admin.providers.fleet-statement',
				compact( 'Fleets', 'pagination' ) )->with( 'page',
				'Fleets Statement' );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}


	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function translation() {

		try {
			return view( 'admin.translation' );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}


	/**
	 * Remove the specified resource from storage.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function push() {

		try {
			$Pushes = CustomPush::orderBy( 'id', 'desc' )->get();

			return view( 'admin.push', compact( 'Pushes' ) );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}


	/**
	 * pages.
	 *
	 * @param Provider $provider
	 *
	 * @return Response
	 */
	public function send_push( Request $request )
	{
		$this->validate( $request,
			[
				'send_to'            => 'required|in:ALL,USERS,PROVIDERS',
				'user_condition'     => [
					'required_if:send_to,USERS',
					'in:ACTIVE,LOCATION,RIDES,AMOUNT',
				],
				'provider_condition' => [
					'required_if:send_to,PROVIDERS',
					'in:ACTIVE,LOCATION,RIDES,AMOUNT',
				],
				'user_active'        => [
					'required_if:user_condition,ACTIVE',
					'in:HOUR,WEEK,MONTH',
				],
				'user_rides'         => 'required_if:user_condition,RIDES',
				'user_location'      => 'required_if:user_condition,LOCATION',
				'user_amount'        => 'required_if:user_condition,AMOUNT',
				'provider_active'    => [
					'required_if:provider_condition,ACTIVE',
					'in:HOUR,WEEK,MONTH',
				],
				'provider_rides'     => 'required_if:provider_condition,RIDES',
				'provider_location'  => 'required_if:provider_condition,LOCATION',
				'provider_amount'    => 'required_if:provider_condition,AMOUNT',
				'message'            => 'required|max:100',
			] );

		try {

			$CustomPush          = new CustomPush;
			$CustomPush->send_to = $request->send_to;
			$CustomPush->message = $request->message;

			if ( $request->send_to == 'USERS' ) {

				$CustomPush->condition = $request->user_condition;

				if ( $request->user_condition == 'ACTIVE' ) {
					$CustomPush->condition_data = $request->user_active;
				} elseif ( $request->user_condition == 'LOCATION' ) {
					$CustomPush->condition_data = $request->user_location;
				} elseif ( $request->user_condition == 'RIDES' ) {
					$CustomPush->condition_data = $request->user_rides;
				}
//				elseif ( $request->user_condition == 'AMOUNT' ) {
//					$CustomPush->condition_data = $request->user_amount;
//				}
			} elseif ( $request->send_to == 'PROVIDERS' ) {

				$CustomPush->condition = $request->provider_condition;

				if ( $request->provider_condition == 'ACTIVE' ) {
					$CustomPush->condition_data = $request->provider_active;
				} elseif ( $request->provider_condition == 'LOCATION' ) {
					$CustomPush->condition_data = $request->provider_location;
				} elseif ( $request->provider_condition == 'RIDES' ) {
					$CustomPush->condition_data = $request->provider_rides;
				} elseif ( $request->provider_condition == 'AMOUNT' ) {
					$CustomPush->condition_data = $request->provider_amount;
				}
			}

			if ( $request->has( 'schedule_date' )
			     && $request->has( 'schedule_time' )
			) {
				$CustomPush->schedule_at = date( "Y-m-d H:i:s",
					strtotime( "$request->schedule_date $request->schedule_time" ) );
			}
			$CustomPush->fleet_id = 0;
			$CustomPush->save();

			if ( $CustomPush->schedule_at == '' ) {
				$this->SendCustomPush( $CustomPush->id );
			}

			return back()->with( 'flash_success',
				'Message Sent to all ' . $request->segment );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}


	public function SendCustomPush( $CustomPush ) {

		try {

			\Illuminate\Support\Facades\Log::notice( "Starting Custom Push" );

			$Push = CustomPush::findOrFail( $CustomPush );
			$fleet_id = $Push->fleet_id;

			if ( $Push->send_to == 'USERS' ) {

				$Users = [];

				if ( $Push->condition == 'ACTIVE' ) {

					if ( $Push->condition_data == 'HOUR' ) {

						$Users = User::where('fleet_id',$fleet_id)->whereHas( 'trips',
							function ( $query ) {
								$query->where( 'created_at',
									'>=',
									Carbon::now()->subHour() );
							} )->get();
					} elseif ( $Push->condition_data == 'WEEK' ) {

						$Users = User::where('fleet_id',$fleet_id)->whereHas( 'trips',
							function ( $query ) {
								$query->where( 'created_at',
									'>=',
									Carbon::now()->subWeek() );
							} )->get();

					} elseif ( $Push->condition_data == 'MONTH' ) {

						$Users = User::where('fleet_id',$fleet_id)->whereHas( 'trips',
							function ( $query ) {
								$query->where( 'created_at',
									'>=',
									Carbon::now()->subMonth() );
							} )->get();
					}
				} elseif ( $Push->condition == 'RIDES' ) {

					$Users = User::where('fleet_id',$fleet_id)->whereHas( 'trips',
						function ( $query ) use ( $Push ) {
							$query->where( 'status', 'COMPLETED' );
							$query->groupBy( 'id' );
							$query->havingRaw( 'COUNT(*) >= '
							                   . $Push->condition_data );
						} )->get();
				} elseif ( $Push->condition == 'LOCATION' ) {

					$Location = explode( ',', $Push->condition_data );

					$distance  = config( 'constants.provider_search_radius',
						'10' );
					$latitude  = $Location[0];
					$longitude = $Location[1];

					$Users
						=
						User::where('fleet_id',$fleet_id)->whereRaw( "(1.609344 * 3956 * acos( cos( radians('$latitude') ) * cos( radians(latitude) ) * cos( radians(longitude) - radians('$longitude') ) + sin( radians('$latitude') ) * sin( radians(latitude) ) ) ) <= $distance" )
							->get();
				}


				foreach ( $Users as $key => $user ) {
					( new SendPushNotification )->sendPushToUser( $user->id,
						$Push->message );
				}
			} elseif ( $Push->send_to == 'PROVIDERS' ) {
				$Providers = [];

				if ( $Push->condition == 'ACTIVE' ) {

					if ( $Push->condition_data == 'HOUR' ) {

						$Providers = Provider::where('fleet',$fleet_id)->whereHas( 'trips',
							function ( $query ) {
								$query->where( 'created_at',
									'>=',
									Carbon::now()->subHour() );
							} )->get();
					} elseif ( $Push->condition_data == 'WEEK' ) {

						$Providers = Provider::where('fleet',$fleet_id)->whereHas( 'trips',
							function ( $query ) {
								$query->where( 'created_at',
									'>=',
									Carbon::now()->subWeek() );
							} )->get();
					} elseif ( $Push->condition_data == 'MONTH' ) {

						$Providers = Provider::where('fleet',$fleet_id)->whereHas( 'trips',
							function ( $query ) {
								$query->where( 'created_at',
									'>=',
									Carbon::now()->subMonth() );
							} )->get();
					}
				} elseif ( $Push->condition == 'RIDES' ) {

					$Providers = Provider::where('fleet',$fleet_id)->whereHas( 'trips',
						function ( $query ) use ( $Push ) {
							$query->where( 'status', 'COMPLETED' );
							$query->groupBy( 'id' );
							$query->havingRaw( 'COUNT(*) >= '
							                   . $Push->condition_data );
						} )->get();
				} elseif ( $Push->condition == 'LOCATION' ) {

					$Location = explode( ',', $Push->condition_data );

					$distance  = config( 'constants.provider_search_radius',
						'10' );
					$latitude  = $Location[0];
					$longitude = $Location[1];

					$Providers
						=
						Provider::where('fleet',$fleet_id)->whereRaw( "(1.609344 * 3956 * acos( cos( radians('$latitude') ) * cos( radians(latitude) ) * cos( radians(longitude) - radians('$longitude') ) + sin( radians('$latitude') ) * sin( radians(latitude) ) ) ) <= $distance" )
							->get();
				}


				foreach ( $Providers as $key => $provider ) {
					( new SendPushNotification )->sendPushToProvider( $provider->id,
						$Push->message );
				}
			} elseif ( $Push->send_to == 'ALL' ) {

				$Users = User::all()->where('fleet_id',$fleet_id);
				foreach ( $Users as $key => $user ) {
					( new SendPushNotification )->sendPushToUser( $user->id,
						$Push->message );
				}

				$Providers = Provider::all()->where('fleet_id',$fleet_id);
				foreach ( $Providers as $key => $provider ) {
					( new SendPushNotification )->sendPushToProvider( $provider->id,
						$Push->message );
				}
			}
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something Went Wrong!' );
		}
	}


	public function transactions( Request $request ) {
		try {
			$wallet_transation = AdminWallet::orderBy( 'id', 'desc' );
			// ->paginate(config('constants.per_page', '10'));

			// $pagination = (new Helper)->formatPagination($wallet_transation);

			$from_date = $request->input( 'from_date' );
			$to_date   = $request->input( 'to_date' );
			$type      = $request->input( 'date_filter' );

			if ( $from_date && $to_date && $type ) {
				switch ( $type ) {
					case 'tday':
					case 'yday':
						$wallet_transation
							= $wallet_transation->whereDate( 'created_at',
							date( 'Y-m-d', strtotime( $from_date ) ) );
						break;
					default:
						$wallet_transation
							= $wallet_transation->whereBetween( 'created_at',
							[
								Carbon::createFromFormat( 'Y-m-d', $from_date ),
								Carbon::createFromFormat( 'Y-m-d', $to_date ),
							] );
						break;
				}
			}

			$wallet_transation = $wallet_transation->get();

			$dates['yesterday']      = Carbon::yesterday()->format( 'Y-m-d' );
			$dates['today']          = Carbon::today()->format( 'Y-m-d' );
			$dates['pre_week_start'] = date( "Y-m-d",
				strtotime( "last week monday" ) );
			$dates['pre_week_end']   = date( "Y-m-d",
				strtotime( "last week sunday" ) );
			$dates['cur_week_start'] = Carbon::today()->startOfWeek()
				->format( 'Y-m-d' );
			$dates['cur_week_end']   = Carbon::today()->endOfWeek()
				->format( 'Y-m-d' );
			$dates['pre_month_start']
			                         =
				Carbon::parse( 'first day of last month' )
					->format( 'Y-m-d' );
			$dates['pre_month_end']
			                         = Carbon::parse( 'last day of last month' )
				->format( 'Y-m-d' );
			$dates['cur_month_start']
			                         =
				Carbon::parse( 'first day of this month' )
					->format( 'Y-m-d' );
			$dates['cur_month_end']
			                         = Carbon::parse( 'last day of this month' )
				->format( 'Y-m-d' );
			$dates['pre_year_start'] = date( "Y-m-d",
				strtotime( "last year January 1st" ) );
			$dates['pre_year_end']   = date( "Y-m-d",
				strtotime( "last year December 31st" ) );
			$dates['cur_year_start'] = Carbon::parse( 'first day of January' )
				->format( 'Y-m-d' );
			$dates['cur_year_end']   = Carbon::parse( 'last day of December' )
				->format( 'Y-m-d' );
			$dates['nextWeek']       = Carbon::today()->addWeek()
				->format( 'Y-m-d' );

			$wallet_balance = AdminWallet::sum( 'amount' );

			return view( 'admin.wallet.wallet_transation',
				compact( 'wallet_transation',
					'wallet_balance',
					'from_date',
					'to_date',
					'dates',
					'type' ) );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', $e->getMessage() );
		}
	}

	public function transferlist( Request $request ) {

		$croute = Route::currentRouteName();

		if ( $croute == 'admin.fleettransfer' ) {
			$utype = 'fleet';
		} else {
			$utype = 'provider';
		}

		$pendinglist = WalletRequests::where( 'request_from', $utype )
			->where( 'status', 0 );
		if ( $croute == 'admin.fleettransfer' ) {
			$pendinglist = $pendinglist->with( 'fleet' );
		} else {
			$pendinglist = $pendinglist->with( 'provider' );
		}


		$from_date = $request->input( 'from_date' );
		$to_date   = $request->input( 'to_date' );
		$type      = $request->input( 'date_filter' );

		if ( $from_date && $to_date && $type ) {
			switch ( $type ) {
				case 'tday':
				case 'yday':
					$pendinglist = $pendinglist->whereDate( 'created_at',
						date( 'Y-m-d', strtotime( $from_date ) ) );
					break;
				default:
					$pendinglist = $pendinglist->whereBetween( 'created_at',
						[
							Carbon::createFromFormat( 'Y-m-d', $from_date ),
							Carbon::createFromFormat( 'Y-m-d', $to_date ),
						] );
					break;
			}
		}

		$pendinglist = $pendinglist->get();

		$dates['yesterday']       = Carbon::yesterday()->format( 'Y-m-d' );
		$dates['today']           = Carbon::today()->format( 'Y-m-d' );
		$dates['pre_week_start']  = date( "Y-m-d",
			strtotime( "last week monday" ) );
		$dates['pre_week_end']    = date( "Y-m-d",
			strtotime( "last week sunday" ) );
		$dates['cur_week_start']  = Carbon::today()->startOfWeek()
			->format( 'Y-m-d' );
		$dates['cur_week_end']    = Carbon::today()->endOfWeek()
			->format( 'Y-m-d' );
		$dates['pre_month_start'] = Carbon::parse( 'first day of last month' )
			->format( 'Y-m-d' );
		$dates['pre_month_end']   = Carbon::parse( 'last day of last month' )
			->format( 'Y-m-d' );
		$dates['cur_month_start'] = Carbon::parse( 'first day of this month' )
			->format( 'Y-m-d' );
		$dates['cur_month_end']   = Carbon::parse( 'last day of this month' )
			->format( 'Y-m-d' );
		$dates['pre_year_start']  = date( "Y-m-d",
			strtotime( "last year January 1st" ) );
		$dates['pre_year_end']    = date( "Y-m-d",
			strtotime( "last year December 31st" ) );
		$dates['cur_year_start']  = Carbon::parse( 'first day of January' )
			->format( 'Y-m-d' );
		$dates['cur_year_end']    = Carbon::parse( 'last day of December' )
			->format( 'Y-m-d' );
		$dates['nextWeek']        = Carbon::today()->addWeek()
			->format( 'Y-m-d' );

		return view( 'admin.wallet.transfer',
			compact( 'pendinglist',
				'utype',
				'type',
				'dates',
				'from_date',
				'to_date' ) );
	}

	public function approve( Request $request, $id ) {

		if ( $request->send_by == "online" ) {
			$response = ( new PaymentController )->send_money( $request, $id );
		} else {
			( new TripController )->settlements( $id );
			$response['success'] = 'Amount successfully send';
		}

		if ( ! empty( $response['error'] ) ) {
			$result['flash_error'] = $response['error'];
		}
		if ( ! empty( $response['success'] ) ) {
			$result['flash_success'] = $response['success'];
		}

		return redirect()->back()->with( $result );
	}

	public function requestcancel( Request $request ) {

		$cancel   = ( new TripController() )->requestcancel( $request );
		$response = json_decode( $cancel->getContent(), true );

		if ( ! empty( $response['error'] ) ) {
			$result['flash_error'] = $response['error'];
		}
		if ( ! empty( $response['success'] ) ) {
			$result['flash_success'] = $response['success'];
		}

		return redirect()->back()->with( $result );
	}

	public function transfercreate( Request $request, $id ) {
		$type = $id;

		return view( 'admin.wallet.create', compact( 'type' ) );
	}

	public function search( Request $request ) {

		$results = array();

		$term  = $request->input( 'stext' );
		$sflag = $request->input( 'sflag' );

		if ( $sflag == 1 ) {
			$queries = Provider::where( 'first_name', 'LIKE', $term . '%' )
				->take( 5 )->get();
		} else {
			$queries = Fleet::where( 'name', 'LIKE', $term . '%' )->take( 5 )
				->get();
		}

		foreach ( $queries as $query ) {
			$results[] = $query;
		}

		return response()->json( array(
			'success' => true,
			'data'    => $results,
		) );
	}

	public function search_user( Request $request ) {

		$results = array();

		$term = $request->input( 'stext' );

		$queries = User::where( 'first_name', 'LIKE', $term . '%' )->take( 5 )
			->get();

		foreach ( $queries as $query ) {
			$results[] = $query;
		}

		return response()->json( array(
			'success' => true,
			'data'    => $results,
		) );
	}

	public function search_provider( Request $request ) {

		$results = array();

		$term = $request->input( 'stext' );

		$queries = Provider::where( 'first_name', 'LIKE', $term . '%' )
			->take( 5 )->get();

		foreach ( $queries as $query ) {
			$results[] = $query;
		}

		return response()->json( array(
			'success' => true,
			'data'    => $results,
		) );
	}

	public function search_ride( Request $request ) {

		$results = array();

		$term = $request->input( 'stext' );

		if ( $request->input( 'sflag' ) == 1 ) {

			$queries = UserRequests::where( 'provider_id', $request->id )
				->orderby( 'id', 'desc' )->take( 10 )->get();
		} else {

			$queries = UserRequests::where( 'user_id', $request->id )
				->orderby( 'id', 'desc' )->take( 10 )->get();
		}

		foreach ( $queries as $query ) {
			$results[] = $query;
		}

		return response()->json( array(
			'success' => true,
			'data'    => $results,
		) );
	}

	public function transferstore( Request $request ) {

		try {
			if ( $request->stype == 1 ) {
				$type = 'provider';
			} else {
				$type = 'fleet';
			}

			$nextid = Helper::generate_request_id( $type );

			$amountRequest               = new WalletRequests;
			$amountRequest->alias_id     = $nextid;
			$amountRequest->request_from = $type;
			$amountRequest->from_id      = $request->from_id;
			$amountRequest->type         = $request->type;
			$amountRequest->send_by      = $request->by;
			$amountRequest->amount       = $request->amount;

			$amountRequest->save();

			if ( $type == 'provider' && $request->type == 'C' ) {
				$provider = Provider::find( $request->from_id );
				if ( $provider->status == 'balance'
				     && ( ( $provider->wallet_balance + $request->amount )
				          > config( 'constants.minimum_negative_balance' ) )
				) {
					ProviderService::where( 'provider_id', $request->from_id )
						->update( [ 'status' => 'active' ] );
					Provider::where( 'id', $request->from_id )
						->update( [ 'status' => 'approved' ] );
				}
			}


			//create the settlement transactions
			( new TripController )->settlements( $amountRequest->id );

			return back()->with( 'flash_success',
				'Settlement processed successfully' );
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', $e->getMessage() );
		}
	}

	public function download( Request $request, $id ) {

		$documents = ProviderDocument::where( 'provider_id', $id )->get();

		if ( ! empty( $documents->toArray() ) ) {


			$Provider = Provider::findOrFail( $id );

			// Define Dir Folder
			$public_dir = public_path();

			// Zip File Name
			$zipFileName = $Provider->first_name . '.zip';

			// Create ZipArchive Obj
			$zip = new ZipArchive;

			if ( $zip->open( $public_dir . '/storage/' . $zipFileName,
					ZipArchive::CREATE ) === true
			) {
				// Add File in ZipArchive
				foreach ( $documents as $file ) {
					$zip->addFile( $public_dir . '/storage/' . $file->url );
				}

				// Close ZipArchive
				$zip->close();
			}
			// Set Header
			$headers = array(
				'Content-Type' => 'application/octet-stream',
			);

			$filetopath = $public_dir . '/storage/' . $zipFileName;

			// Create Download Response
			if ( file_exists( $filetopath ) ) {
				return response()
					->download( $filetopath, $zipFileName, $headers )
					->deleteFileAfterSend( true );
			}

			return redirect()
				->route( 'admin.provider.document.index', $id )
				->with( 'flash_success', 'documents downloaded successfully.' );
		}

		return redirect()
			->route( 'admin.provider.document.index', $id )
			->with( 'flash_error', 'failed to downloaded documents.' );
	}

	/* DataBase BackUp*/
	public function DBbackUp() {
		if ( config( 'constants.demo_mode', 0 ) == 1 ) {
			$host       = env( 'DB_HOST', '' );
			$username   = env( 'DB_USERNAME', '' );
			$password   = env( 'DB_PASSWORD', '' );
			$database   = env( 'DB_DATABASE', '' );
			$dateFormat = $database . "_"
			              . ( new DateTime() )->format( 'Y-m-d' );
			$fileName   = public_path( '/' ) . $dateFormat . ".sql";
			if ( ! empty( $password ) ) {
				$command = sprintf( 'mysqldump -h %s -u %s -p\'%s\' %s > %s',
					$host,
					$username,
					$password,
					$database,
					$fileName );
			} else {
				$command = sprintf( 'mysqldump -h %s -u %s %s > %s',
					$host,
					$username,
					$database,
					$fileName );
			}
			exec( $command );

			return response()->download( $fileName )
				->deleteFileAfterSend( true );
		} else {
			return back()->with( 'flash_error', 'Permission Denied.' );
		}
	}

	public function save_subscription( $id, Request $request ) {

		$user = Provider::findOrFail( $id );

		$user->updatePushSubscription( $request->input( 'endpoint' ),
			$request->input( 'keys.p256dh' ),
			$request->input( 'keys.auth' ),
			'web' );

		return response()->json( [ 'success' => true ] );
	}

	public function fare( Request $request ) {

		$this->validate( $request,
			[
				's_latitude'   => 'required|numeric',
				's_longitude'  => 'numeric',
				'd_latitude'   => 'required|numeric',
				'd_longitude'  => 'numeric',
				'service_type' => 'required|numeric|exists:service_types,id',
			] );

		try {
			$response     = new ServiceTypes();
			$responsedata = $response->calculateFare( $request->all(), 1 );

			if ( ! empty( $responsedata['errors'] ) ) {
				throw new Exception( $responsedata['errors'] );
			} else {
				return response()->json( $responsedata['data'] );
			}
		} catch ( Exception $e ) {
			return response()->json( [ 'error' => $e->getMessage() ], 500 );
		}
	}

	public function get_providers( $request_id ) {
		if ( empty( $request_id ) ) {
			return back()->with( 'flash_error', 'Request Wrong' );
		}
		$req = UserRequests::where( 'id', $request_id )
			->where( 'status', 'SCHEDULED' )->first();
		if ( empty( $req ) ) {
			return back()->with( 'flash_error', 'Request Wrong' );
		}

		$providers = Provider::where( "status", "approved" )->with( 'service' )
			->orderBy( 'id', 'asc' )->get();
		// $providers = Provider::where("status", "approved")->with('service')->orderBy('id', 'asc')->paginate($this->perpage);
		// $pagination = (new Helper)->formatPagination($providers);
		// return view('admin.assign.provider', compact('req', 'providers', 'pagination'));
		return view( 'admin.assign.provider', compact( 'req', 'providers' ) );
	}

	public function get_fleets( $request_id ) {
		if ( empty( $request_id ) ) {
			return back()->with( 'flash_error', 'Request Wrong' );
		}
		$req = UserRequests::where( 'id', $request_id )
			->where( 'status', 'SCHEDULED' )->first();
		if ( empty( $req ) ) {
			return redirect()->back()->with( 'flash_error', 'Request Wrong' );
		}

		// $fleets = Fleet::orderBy('id', 'asc')->paginate($this->perpage);
		// $pagination = (new Helper)->formatPagination($fleets);
		// return view('admin.assign.fleet', compact('req', 'fleets', 'pagination'));
		$fleets = Fleet::orderBy( 'id', 'asc' )->get();

		return view( 'admin.assign.fleet', compact( 'req', 'fleets' ) );
	}

	public function assign_provider( Request $request ) {

		$this->validate( $request,
			[
				'id'          => 'required|numeric',
				'provider_id' => 'required|numeric',
				'timeout'     => 'required|numeric',
			] );
		$req = UserRequests::where( 'id', $request->id )
			->where( 'status', 'SCHEDULED' )->first();
		if ( empty( $req ) ) {
			return redirect()->back()->with( 'flash_error', 'Failed' );
		}
		try {
			UserRequests::where( 'id', $request->id )->update( [
				'provider_id'         => $request->provider_id,
				'current_provider_id' => $request->provider_id,
				'fleet_id'            => 0,
				'timeout'             => $request->timeout,
				'manual_assigned_at'  => Carbon::now(),
			] );
			// Send Push notification
			( new SendPushNotification )->sendPushToProvider( $request->provider_id,
				'You are just assigned' );

			return redirect( 'admin/scheduled' )->with( 'flash_success',
				'Success' );
		} catch ( Exception $e ) {
			return redirect()->back()->with( 'flash_error', 'Failed' );
			// return response()->json(['error' => $e->getMessage()], 500);
		}
	}

	public function assign_force_provider( Request $request ) {

		$this->validate( $request,
			[
				'id'          => 'required|numeric',
				'provider_id' => 'required|numeric',
			] );
		$req = UserRequests::where( 'id', $request->id )
			->where( 'status', 'SCHEDULED' )->first();
		if ( empty( $req ) ) {
			return redirect()->back()->with( 'flash_error', 'Failed' );
		}
		try {
			UserRequests::where( 'id', $request->id )->update( [
				'provider_id'         => $request->provider_id,
				'current_provider_id' => $request->provider_id,
				'fleet_id'            => 0,
				'timeout'             => 0,
				'manual_assigned_at'  => null,
			] );
			// Send Push notification
			( new SendPushNotification )->sendPushToProvider( $request->provider_id,
				'You are just force assigned' );

			return redirect( 'admin/scheduled' )->with( 'flash_success',
				'Success' );
		} catch ( Exception $e ) {
			return redirect()->back()->with( 'flash_error', 'Failed' );
			// return response()->json(['error' => $e->getMessage()], 500);
		}
	}

	public function assign_fleet( Request $request ) {
		$this->validate( $request,
			[
				'id'       => 'required|numeric',
				'fleet_id' => 'required|numeric',
				'timeout'  => 'required|numeric',
			] );
		try {
			UserRequests::where( 'id', $request->id )->update( [
				'fleet_id'            => $request->fleet_id,
				'provider_id'         => 0,
				'current_provider_id' => 0,
				'timeout'             => $request->timeout,
				'manual_assigned_at'  => Carbon::now(),
			] );
			// Send email
			Helper::emailToFleetWhenApproved( $request->id );
			// Send SMS
			Helper::smsToFleetWhenApproved( $request->id );

			return redirect( 'admin/scheduled' )->with( 'flash_success',
				'Success' );
		} catch ( Exception $e ) {
			return redirect()->back()->with( 'flash_error', 'Failed' );
			// return response()->json(['error' => $e->getMessage()], 500);
		}
	}

	public function cancel_assign( Request $request, $requestID ) {
		try {
			$userReq = UserRequests::where( 'id', $requestID )
				->where( 'status', 'SCHEDULED' )->first();
			// $userReq = UserRequests::where('id', $requestID)->where('status' , 'SCHEDULED')->whereNotNull('manual_assigned_at')->first();
			if ( $userReq ) {
				UserRequests::where( 'id', $requestID )->update( [
					'fleet_id'            => 0,
					'provider_id'         => 0,
					'current_provider_id' => 0,
					'manual_assigned_at'  => null,
					'timeout'             => 0,
				] );
			}

			return redirect( 'admin/scheduled' )->with( 'flash_success',
				'Canceled Successfully' );
		} catch ( Exception $e ) {
			return redirect()->back()->with( 'flash_error', 'Failed' );
			// return response()->json(['error' => $e->getMessage()], 500);
		}
	}

	// User Payment Request
	public function payment_request( Request $request ) {
		$pendinglist = UserWalletRequest::where( 'status', 'PENDING' )
			->with( 'user' )
			->orderBy( 'created_at', 'desc' );


		$from_date = $request->input( 'from_date' );
		$to_date   = $request->input( 'to_date' );
		$type      = $request->input( 'date_filter' );

		if ( $from_date && $to_date && $type ) {
			switch ( $type ) {
				case 'tday':
				case 'yday':
					$pendinglist = $pendinglist->whereDate( 'created_at',
						date( 'Y-m-d', strtotime( $from_date ) ) );
					break;
				default:
					$pendinglist = $pendinglist->whereBetween( 'created_at',
						[
							Carbon::createFromFormat( 'Y-m-d', $from_date ),
							Carbon::createFromFormat( 'Y-m-d', $to_date ),
						] );
					break;
			}
		}

		$pendinglist = $pendinglist->get();

		$dates['yesterday']       = Carbon::yesterday()->format( 'Y-m-d' );
		$dates['today']           = Carbon::today()->format( 'Y-m-d' );
		$dates['pre_week_start']  = date( "Y-m-d",
			strtotime( "last week monday" ) );
		$dates['pre_week_end']    = date( "Y-m-d",
			strtotime( "last week sunday" ) );
		$dates['cur_week_start']  = Carbon::today()->startOfWeek()
			->format( 'Y-m-d' );
		$dates['cur_week_end']    = Carbon::today()->endOfWeek()
			->format( 'Y-m-d' );
		$dates['pre_month_start'] = Carbon::parse( 'first day of last month' )
			->format( 'Y-m-d' );
		$dates['pre_month_end']   = Carbon::parse( 'last day of last month' )
			->format( 'Y-m-d' );
		$dates['cur_month_start'] = Carbon::parse( 'first day of this month' )
			->format( 'Y-m-d' );
		$dates['cur_month_end']   = Carbon::parse( 'last day of this month' )
			->format( 'Y-m-d' );
		$dates['pre_year_start']  = date( "Y-m-d",
			strtotime( "last year January 1st" ) );
		$dates['pre_year_end']    = date( "Y-m-d",
			strtotime( "last year December 31st" ) );
		$dates['cur_year_start']  = Carbon::parse( 'first day of January' )
			->format( 'Y-m-d' );
		$dates['cur_year_end']    = Carbon::parse( 'last day of December' )
			->format( 'Y-m-d' );
		$dates['nextWeek']        = Carbon::today()->addWeek()
			->format( 'Y-m-d' );

		return view( 'admin.payment-request.list',
			compact( 'pendinglist', 'from_date', 'to_date', 'type', 'dates' ) );
	}

	// User Payment Transactions
	public function payment_transactions( Request $request ) {
		$transactions = UserWalletRequest::where( 'status',
			'<>',
			'PENDING----' )
			->with( 'user' )
			->orderBy( 'created_at', 'desc' );

		$from_date = $request->input( 'from_date' );
		$to_date   = $request->input( 'to_date' );
		$type      = $request->input( 'date_filter' );

		if ( $from_date && $to_date && $type ) {
			switch ( $type ) {
				case 'tday':
				case 'yday':
					$transactions = $transactions->whereDate( 'created_at',
						date( 'Y-m-d', strtotime( $from_date ) ) );
					break;
				default:
					$transactions = $transactions->whereBetween( 'created_at',
						[
							Carbon::createFromFormat( 'Y-m-d', $from_date ),
							Carbon::createFromFormat( 'Y-m-d', $to_date ),
						] );
					break;
			}
		}

		$transactions = $transactions->get();

		$dates['yesterday']       = Carbon::yesterday()->format( 'Y-m-d' );
		$dates['today']           = Carbon::today()->format( 'Y-m-d' );
		$dates['pre_week_start']  = date( "Y-m-d",
			strtotime( "last week monday" ) );
		$dates['pre_week_end']    = date( "Y-m-d",
			strtotime( "last week sunday" ) );
		$dates['cur_week_start']  = Carbon::today()->startOfWeek()
			->format( 'Y-m-d' );
		$dates['cur_week_end']    = Carbon::today()->endOfWeek()
			->format( 'Y-m-d' );
		$dates['pre_month_start'] = Carbon::parse( 'first day of last month' )
			->format( 'Y-m-d' );
		$dates['pre_month_end']   = Carbon::parse( 'last day of last month' )
			->format( 'Y-m-d' );
		$dates['cur_month_start'] = Carbon::parse( 'first day of this month' )
			->format( 'Y-m-d' );
		$dates['cur_month_end']   = Carbon::parse( 'last day of this month' )
			->format( 'Y-m-d' );
		$dates['pre_year_start']  = date( "Y-m-d",
			strtotime( "last year January 1st" ) );
		$dates['pre_year_end']    = date( "Y-m-d",
			strtotime( "last year December 31st" ) );
		$dates['cur_year_start']  = Carbon::parse( 'first day of January' )
			->format( 'Y-m-d' );
		$dates['cur_year_end']    = Carbon::parse( 'last day of December' )
			->format( 'Y-m-d' );
		$dates['nextWeek']        = Carbon::today()->addWeek()
			->format( 'Y-m-d' );

		return view( 'admin.payment-request.transaction',
			compact( 'transactions',
				'from_date',
				'to_date',
				'type',
				'dates' ) );
	}

	public function payment_approve( Request $request, $id ) {
		$walletReq = UserWalletRequest::where( 'id', $id )
			->with( 'user' )
			->first();
		try {
			if ( $walletReq ) {
				$userRequests = UserRequests::where( 'user_id',
					$walletReq->user->id )
					->where( 'paid', 0 )
					->where( 'status', 'COMPLETED' )
					->orderBy( 'created_at', 'ASC' )
					->with( 'payment' )
					->get();

				$amount = $walletReq->amount;
				foreach ( $userRequests as $user_req ) {
					if ( $user_req->payment->payable > 0
					     && $amount >= $user_req->payment->payable
					) {
						$amount         -= $user_req->payment->payable;
						$user_req->paid = 1;
						$user_req->save();
					}
				}

				$walletReq->status = 'Accepted';
				$walletReq->save();

				$userWallet                    = new UserWallet;
				$userWallet->user_id           = $walletReq->user->id;
				$userWallet->transaction_id    = 0;
				$userWallet->transaction_alias = $walletReq->alias_id;
				$userWallet->wallet_request_id = $walletReq->id;
				$userWallet->transaction_desc  = 'Payment Request';
				$userWallet->type              = $walletReq->type;
				$userWallet->amount            = $walletReq->amount;
				$userWallet->open_balance
				                               =
					$walletReq->user->wallet_balance;
				$userWallet->close_balance
				                               =
					$walletReq->user->wallet_balance
					+ $walletReq->amount;
				$userWallet->save();

				$walletReq->user->wallet_balance += $walletReq->amount;
				$walletReq->user->save();

				return back()->with( 'flash_success', 'Sucessfully' );
			} else {
				return back()->with( 'flash_success', 'Nothing happened' );
			}
		} catch ( Exception $e ) {
			return back()->with( 'flash_error', 'Something went wrong' );
		}
	}

	public function payment_cancel( Request $request, $id ) {
		$walletReq         = UserWalletRequest::where( 'id', $id )->first();
		$walletReq->status = 'Refused';
		$walletReq->save();

		return back()->with( 'flash_success', 'Canceled Succesfully' );
	}

	public function user_invoice_info( Request $request, $id ) {
		if ( ! $id || $id <= 0 ) {
			return response()->json( [ 'error' => true ] );
		}
		$userReqs   = UserRequests::where( 'user_id', $id )
			->where( 'status', 'COMPLETED' )
			->with( 'user' )
			->with( 'payment' );
		$total      = 0;
		$total_paid = 0;
		$unpaid     = 0;
		$user       = User::where( 'id', $id )->first();
		foreach ( $userReqs as $req ) {
			$total += $req->payment->total;
			if ( $req->paid == 1 ) {
				$total_paid += $req->payment->total;
			} elseif ( $req->use_wallet == 1 && $req->payment->payable > 0 ) {
				$total_paid += $req->payment->total - $req->payment->payable;
			}
		}
		$unpaid = $total_paid - $total;

		return response()->json( [
			'total'      => currency( $total ),
			'total_paid' => currency( $total_paid ),
			'unpaid'     => currency( $unpaid ),
			'user'       => $user,
		] );
	}

	public function downloadPDF( Request $request ) {
		// return view('admin.invoice.download-invoice');
		$user = User::where( 'id', $request->user_id )->first();
		$pdf  = PDF::loadView( 'admin.invoice.download-invoice',
			[ 'request' => $request, 'user' => $user ] );

		return $pdf->download( 'invoice.pdf' );
	}

	public function downloadTripInvoicePDF( Request $request ) {
		// return view('admin.invoice.trip-invoicepdf');
		$trip  = UserRequests::UserTrips( $request->user_id )
			->where( 'id', $request->trip_id )->with( 'user' )->first();
		$admin = Admin::where( 'id', 1 )->select( [
			'name',
			'address',
			'zip_code',
			'city',
			'country',
			'note',
		] )->first();

		$pdf = PDF::loadView( 'admin.invoice.trip-invoicepdf',
			[ 'trip' => $trip, 'admin' => $admin ] );

		return $pdf->download( $trip->booking_id . '.pdf' );
	}

	public function downloadStatement( Request $request )
	{
		set_time_limit( 0 );
		$type     = $request->input( 'type' );
		$user     = null;
		$Provider = null;
		$fleet    = null;
		if ( ( isset( $request->provider_id ) && $request->provider_id != null )
		     || ( isset( $request->user_id ) && $request->user_id != null )
		     || ( isset( $request->fleet_id ) && $request->fleet_id != null )
		) {
			$pages    = trans( 'admin.include.overall_ride_statments' );
			$listname = trans( 'admin.include.overall_ride_earnings' );
			if ( $type == 'individual' ) {
				$pages    = trans( 'admin.include.provider_statement' );
				$listname = trans( 'admin.include.provider_earnings' );
			} elseif ( $type == 'today' ) {
				$pages    = trans( 'admin.include.today_statement' ) . ' - '
				            . date( 'd M Y' );
				$listname = trans( 'admin.include.today_earnings' );
			} elseif ( $type == 'monthly' ) {
				$pages    = trans( 'admin.include.monthly_statement' ) . ' - '
				            . date( 'F' );
				$listname = trans( 'admin.include.monthly_earnings' );
			} elseif ( $type == 'yearly' ) {
				$pages    = trans( 'admin.include.yearly_statement' ) . ' - '
				            . date( 'Y' );
				$listname = trans( 'admin.include.yearly_earnings' );
			} elseif ( $type == 'range' ) {
				$pages = trans( 'admin.include.statement_from' ) . ' '
				         . Carbon::createFromFormat( 'Y-m-d',
						$request->from_date )->format( 'd M Y' ) . '  '
				         . trans( 'admin.include.statement_to' ) . ' '
				         . Carbon::createFromFormat( 'Y-m-d',
						$request->to_date )->format( 'd M Y' );
			}

			if ( isset( $request->provider_id )
			     && $request->provider_id != null
			) {
				$id            = $request->provider_id;
				$statement_for = "provider";
				$rides         = UserRequests::where( 'provider_id', $id )
					->with( 'payment' )->orderBy( 'id', 'desc' );
				$cancel_rides  = UserRequests::where( 'status', 'CANCELLED' )
					->where( 'provider_id', $id );
				$Provider      = Provider::find( $id );
				$revenue       = UserRequestPayment::whereHas( 'request',
					function ( $query ) use ( $id ) {
						$query->where( 'provider_id', $id );
					} )->select( DB::raw(
					'SUM((provider_pay)) as overall,  SUM(commision + peak_comm_amount + waiting_comm_amount) as commission'
				) );
				$page          = $Provider->first_name . "'s " . $pages;
			} elseif ( isset( $request->user_id )
			           && $request->user_id != null
			) {
				$id            = $request->user_id;
				$statement_for = "user";
				$rides         = UserRequests::where( 'user_id', $id )
					->with( 'payment' )->orderBy( 'id', 'desc' );
				$cancel_rides  = UserRequests::where( 'status', 'CANCELLED' )
					->where( 'user_id', $id );
				$user          = User::find( $id );
				$revenue       = UserRequestPayment::whereHas( 'request',
					function ( $query ) use ( $id ) {
						$query->where( 'user_id', $id );
					} )->select( DB::raw(
					'SUM((total)) as overall'
				) );
				$page          = $user->first_name . "'s " . $pages;
			} else {
				$id            = $request->fleet_id;
				$statement_for = "fleet";
				$rides         = UserRequestPayment::where( 'fleet_id', $id )
					->whereHas( 'request',
						function ( $query ) use ( $id ) {
							$query->with( 'payment' )->orderBy( 'id', 'desc' );
						} );
				$cancel_rides  = UserRequestPayment::where( 'fleet_id', $id )
					->whereHas( 'request',
						function ( $query ) use ( $id ) {
							$query->where( 'status', 'CANCELLED' );
						} );
				$fleet         = Fleet::find( $id );
				$revenue       = UserRequestPayment::where( 'fleet_id', $id )
					->select( DB::raw(
						'SUM((fleet)) as overall'
					) );
				$page          = $fleet->name . "'s " . $pages;
			}
		} else {
			$id            = '';
			$statement_for = "";
			$page          = trans( 'admin.include.overall_ride_statments' );
			$listname      = trans( 'admin.include.overall_ride_earnings' );
			if ( $type == 'individual' ) {
				$page     = trans( 'admin.include.provider_statement' );
				$listname = trans( 'admin.include.provider_earnings' );
			} elseif ( $type == 'today' ) {
				$page     = trans( 'admin.include.today_statement' ) . ' - '
				            . date( 'd M Y' );
				$listname = trans( 'admin.include.today_earnings' );
			} elseif ( $type == 'monthly' ) {
				$page     = trans( 'admin.include.monthly_statement' ) . ' - '
				            . date( 'F' );
				$listname = trans( 'admin.include.monthly_earnings' );
			} elseif ( $type == 'yearly' ) {
				$page     = trans( 'admin.include.yearly_statement' ) . ' - '
				            . date( 'Y' );
				$listname = trans( 'admin.include.yearly_earnings' );
			} elseif ( $type == 'range' ) {
				$page = trans( 'admin.include.statement_from' ) . ' '
				        . Carbon::createFromFormat( 'Y-m-d',
						$request->from_date )->format( 'd M Y' ) . '  '
				        . trans( 'admin.include.statement_to' ) . ' '
				        . Carbon::createFromFormat( 'Y-m-d', $request->to_date )
					        ->format( 'd M Y' );
			}

			$rides = UserRequests::with( 'payment' )->orderBy( 'id', 'desc' );

			$cancel_rides = UserRequests::where( 'status', 'CANCELLED' );
			$revenue      = UserRequestPayment::select( DB::raw(
				'SUM((fixed) + (distance)) as overall,  SUM(commision + peak_comm_amount + waiting_comm_amount) as commission'
			) );
		}

		if ( $type == 'today' ) {

			$rides->where( 'created_at', '>=', Carbon::today() );
			$cancel_rides->where( 'created_at', '>=', Carbon::today() );
			$revenue->where( 'created_at', '>=', Carbon::today() );
		} elseif ( $type == 'monthly' ) {

			$rides->where( 'created_at', '>=', Carbon::now()->month );
			$cancel_rides->where( 'created_at', '>=', Carbon::now()->month );
			$revenue->where( 'created_at', '>=', Carbon::now()->month );
		} elseif ( $type == 'yearly' ) {

			$rides->where( 'created_at', '>=', Carbon::now()->year );
			$cancel_rides->where( 'created_at', '>=', Carbon::now()->year );
			$revenue->where( 'created_at', '>=', Carbon::now()->year );
		} elseif ( $type == 'range' ) {
			if ( $request->from_date == $request->to_date ) {
				$rides->whereDate( 'created_at',
					date( 'Y-m-d', strtotime( $request->from_date ) ) );
				$cancel_rides->whereDate( 'created_at',
					date( 'Y-m-d', strtotime( $request->from_date ) ) );
				$revenue->whereDate( 'created_at',
					date( 'Y-m-d', strtotime( $request->from_date ) ) );
			} else {
				$rides->whereBetween( 'created_at',
					[
						Carbon::createFromFormat( 'Y-m-d',
							$request->from_date ),
						Carbon::createFromFormat( 'Y-m-d', $request->to_date ),
					] );
				$cancel_rides->whereBetween( 'created_at',
					[
						Carbon::createFromFormat( 'Y-m-d',
							$request->from_date ),
						Carbon::createFromFormat( 'Y-m-d', $request->to_date ),
					] );
				$revenue->whereBetween( 'created_at',
					[
						Carbon::createFromFormat( 'Y-m-d',
							$request->from_date ),
						Carbon::createFromFormat( 'Y-m-d', $request->to_date ),
					] );
			}
		}

		$rides        = $rides->get();
		$total_count  = count( $rides );
		$cancel_rides = $cancel_rides->count();
		$revenue      = $revenue->get();
		$date_label   = ( $request->from_date && $request->to_date )
			? AppDate( $request->from_date ) . '  ~  '
			  . AppDate( $request->to_date ) : "";

		$admin = Admin::where( 'id', 1 )->first();
		// echo json_encode($user);
		// exit;
		$pdf = PDF2::loadView(
			'admin.providers.pdfs.StatementsVTCPro',
			[
				'user'          => $user,
				// user,
				'provider'      => $Provider,
				// provider,
				'fleet'         => $fleet,
				// fleet,
				'admin'         => $admin,
				// admin
				'date_label'    => $date_label,
				// admin selected date
				'total_count'   => $total_count,
				// total rides
				'revenue'       => currency( $revenue[0]->overall ),
				// revenue
				'commission'    => currency( $revenue[0]->commission ),
				// commission
				'gain'          => currency( $revenue[0]->overall
				                             - $revenue[0]->commission ),
				// gain
				'rides'         => $rides,
				// total rides detail table
				'statement_for' => $statement_for,
				'cancel_rides'  => $cancel_rides,
			]
		);

		return $pdf->download( 'statement.pdf' );
	}

	public function downloadExcel(Request $request)
	{
		$searchVal = $request->input('searchVal');
		if($searchVal == '')
			Session::forget( 'searchval' );
		else
			Session::put( 'searchval', $request->input('searchVal') );

		return Excel::download(new StatementExport,'statement.csv');
	}


}
