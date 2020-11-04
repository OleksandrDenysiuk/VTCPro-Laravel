<?php

/*
|--------------------------------------------------------------------------
| Fleet Routes
|--------------------------------------------------------------------------
*/

use Carbon\Carbon;

Route::get('/', 'FleetController@dashboard')->name('index');
Route::get('/dashboard', 'FleetController@dashboard')->name('dashboard');

Route::resource('provider', 'Resource\ProviderFleetResource');

Route::group(['as' => 'provider.'], function () {
    Route::get('review/provider', 'FleetController@provider_review')->name('review');
    Route::get('provider/{id}/approve', 'Resource\ProviderFleetResource@approve')->name('approve');
    Route::get('provider/{id}/disapprove', 'Resource\ProviderFleetResource@disapprove')->name('disapprove');
    Route::get('provider/{id}/request', 'Resource\ProviderFleetResource@request')->name('request');
    Route::resource('provider/{provider}/document', 'Resource\ProviderFleetDocumentResource');
    Route::delete('provider/{provider}/service/{document}', 'Resource\ProviderFleetDocumentResource@service_destroy')->name('document.service');
});

Route::group(['as' => 'dispatcher.', 'prefix' => 'dispatcher'], function () {
	Route::get('/', 'DispatcherController@index')->name('index');
	Route::post('/', 'DispatcherController@store')->name('store');
	Route::get('/trips', 'DispatcherController@trips')->name('trips');
	Route::get('/incoming', 'DispatcherController@incoming')->name('incoming');
	Route::get('/cancelled', 'DispatcherController@cancelled')->name('cancelled');
	Route::get('/cancel', 'DispatcherController@cancel')->name('cancel');
	Route::get('/trips/{trip}/{provider}', 'DispatcherController@assign')->name('assign');
	Route::get('/users', 'DispatcherController@users')->name('users');
	Route::get('/providers', 'DispatcherController@providers')->name('providers');
});

Route::get('/fare' , 'FleetController@fare');
Route::get('/godseye', 'FleetController@godseye')->name('godseye');
Route::get('/godseye/list', 'FleetController@godseye_list')->name('godseye_list');

Route::resource('user', 'Resource\FleetUserResource');
Route::resource('user-pro', 'Resource\FleetUserProResource');
Route::resource('dispatch-manager', 'Resource\FleetDispatcherResource');
Route::resource('account-manager', 'Resource\FleetAccountResource');

Route:: post('/revenue/monthly', 'FleetController@revenue_monthly');
Route::get('/statement', 'FleetController@statement')->name('ride.statement');
Route::get('/statement/provider', 'FleetController@statement_provider')->name('ride.statement.provider');
Route::get('/statement/user', 'FleetController@statement_user')->name('ride.statement.user');
Route::get('/statement/range', 'FleetController@statement_range')->name('ride.statement.range');
Route::get('/pdf/download', 'FleetController@downloadStatement')->name('statement.pdf');

Route::get('statement_user/{id}/statement_user', 'Resource\ProviderResource@fleetStatementUser')->name('statement_user');
Route::get('statement/{id}/statement', 'Resource\ProviderResource@fleetStatement')->name('fleetStatement');
Route:: get('/statement/downloadExcel', 'FleetController@downloadExcel')->name('downloadExcel');

Route:: get('transfer/provider', 'FleetController@transferlist')->name('providertransfer');
Route::get('transfer/fleet', 'FleetController@transferlist')->name('fleettransfer');
Route::get('/transactions', 'FleetController@transactions')->name('transactions');
Route:: get('transfer/{id}/create', 'FleetController@transfercreate')->name('transfercreate');
Route:: get('transfer/fleet', 'FleetController@transferlist')->name('fleettransfer');
Route:: post('transfer/store', 'FleetController@transferstore')->name('transferstore');
Route:: get('transfer/search', 'FleetController@search')->name('transfersearch');
//Payment Request
Route::get('payment_request', 'FleetController@payment_request')->name('payment_request');
Route::get('/payment_request/transactions', 'FleetController@payment_transactions')->name('payment.transactions');
Route:: get('/payment_request/{id}/approve', 'FleetController@payment_approve')->name('payment.approve');
Route:: get('/payment_request/{id}/cancel', 'FleetController@payment_cancel')->name('payment.cancel');
Route::get('/transfer/{id}/approve', 'FleetController@approve')->name('approve');
Route::get('/transfer/cancel', 'FleetController@requestcancel')->name('cancel');

Route::get('review/user', 'FleetController@user_review')->name('user.review');

//Route::resource('document', 'Resource\DocumentResource');
Route::resource('service', 'Resource\FleetServiceResource');

//peakhours
Route::resource('peakhour', 'Resource\FleetPeakHourResource');

Route::resource('poiCategory', 'Resource\FleetPoiCategoryResource');
Route::resource('pointInterest', 'Resource\FleetPointInterestResource');
Route::get('getShape','Resource\FleetPointInterestResource@getShape')->name('getShape');
Route::post('saveShape','Resource\FleetPointInterestResource@saveShape')->name('saveShape');
Route::get('getShapeData','Resource\FleetPointInterestResource@getShapeData')->name('getShapeData');
Route::resource('polygonShape', 'Resource\FleetPolygonShapeResource');


Route::get('payment', 'FleetController@payment')->name('payment');
Route::get('settings/payment', 'FleetController@settings_payment')->name('settings.payment');
Route::post('settings/payment', 'FleetController@settings_payment_store')->name('settings.payment.store');


Route::get('user/{id}/request', 'Resource\FleetUserResource@request')->name('user.request');
Route::get('users/{id}/request', 'Resource\FleetUserProResource@request')->name('userPro.request');

Route::get('map', 'FleetController@map_index')->name('map.index');
Route::get('map/ajax', 'FleetController@map_ajax')->name('map.ajax');

Route::get('profile', 'FleetController@profile')->name('profile');
Route::post('profile', 'FleetController@profile_update')->name('profile.update');

Route::get('/wallet', 'FleetController@wallet')->name('wallet');
Route::get('/transfer', 'FleetController@transfer')->name('transfer');
Route::post('/transfer/send', 'FleetController@requestamount')->name('requestamount');
Route::get('/transfer/cancel', 'FleetController@cancel')->name('cancel');

Route::get('password', 'FleetController@password')->name('password');
Route::post('password', 'FleetController@password_update')->name('password.update');

//notifications
Route:: resource('notification', 'Resource\FleetNotificationResource');
Route:: get('/send/push', 'FleetController@push')->name('push');
Route:: post('/send/push', 'FleetController@send_push')->name('send.push');

// get user paid and unpaid invoice info
Route:: post('/download-pdf','FleetController@downloadPDF');
Route:: post('/trip-invoice-pdf','FleetController@downloadTripInvoicePDF');

// Static Pages - Post updates to pages.update when adding new static pages.
Route::get('requests', 'Resource\TripResource@Fleetindex')->name('requests.index');
Route::delete('requests/{id}', 'Resource\TripResource@Fleetdestroy')->name('requests.destroy');
Route::get('requests/{id}', 'Resource\TripResource@Fleetshow')->name('requests.show');
Route::get('requests/cancel/{id}', 'Resource\TripResource@cancel_assign')->name('requests.cancel');
Route::get('scheduled', 'Resource\TripResource@Fleetscheduled')->name('requests.scheduled');
Route::get('cards', 'FleetController@cards')->name('cards');
Route::post('card/store', 'Resource\FleetCardResource@store');
Route::post('card/set', 'Resource\FleetCardResource@set_default');
Route::delete('card/destroy', 'Resource\FleetCardResource@destroy');

// assign provider
Route::post('/assign/provider', 'FleetController@assign_provider');
Route::post('/assign/provider/force', 'FleetController@assign_provider_force')->name('assign.provider.force');
Route::get('/assign/provider/{id}', 'Resource\TripResource@fleet_assign_provider_list')->name('scheduled.provider.list');

Route::get('/test',function (){
	echo Carbon::now()->addMinutes(20);
});
