@extends('fleet.layout.base')

@section('title')

@section('styles')
<link rel="stylesheet" href="{{asset('main/vendor/jvectormap/jquery-jvectormap-2.0.3.css')}}">
@endsection

@section('content')

<div class="col-md-12 margin-top-10 clients">
	<div class="client-dashboard client-dashnew">
		<div class="row">
			<div class="col-md-7">
				<div class="cliproject-box">

					<div class="db-box-wrap db-box-wrapadmin" style="min-height:560px" tabindex="2" style="overflow: hidden; outline: none;">
						<div class="db-boxh">
							<div class="db-hlft">@lang('admin.dashboard.Recent_Rides')</div>
							<div class="db-hrt"><a href="#">@lang('admin.dashboard.Viewall')</a></div>
						</div>
						<div class="dashbord-pro">

							<div class="table-responsive">
								<table class="table table-new projectspage indexpage" data-pagination="true" data-page-size="5">
									<tbody id="projects-tbl">
										<?php $diff = ['-success', '-info', '-warning', '-danger']; ?>
										@foreach($rides as $index => $ride)
										<tr>
											<th scope="row">{{$index + 1}}</th>
											<td>{{$ride->user->first_name}} {{$ride->user->last_name}}</td>
											<td>
												@if($ride->status != "CANCELLED")
												<a style="background:none" class="text-primary" href="{{route('fleet.requests.show',$ride->id)}}"><span class="underline">@lang('admin.dashboard.View_Ride_Details')</span></a>
												@else
												<span>@lang('admin.dashboard.No_Details_Found') </span>
												@endif
											</td>
											<td>
												<span class="text-muted">{{$ride->created_at->toDateString()}}</span>
											</td>
											<td>
												@if($ride->status == "COMPLETED")
												<span class="tag tag-success">{{$ride->status}}</span>
												@elseif($ride->status == "CANCELLED")
												<span class="tag tag-danger">{{$ride->status}}</span>
												@else
												<span class="tag tag-info">{{$ride->status}}</span>
												@endif
											</td>
										</tr>
										@php if($index==10) break; @endphp
										@endforeach
									</tbody>
								</table>
								@if(count($rides) == 0)
								<span>@lang('admin.custom.fleet_norides')</span>
								@endif
							</div>

						</div>
					</div>


				</div>
			</div>
			<div class="col-md-5">
				<div class="clidashright">
					<div class="clidashr-pi">
						<div class="clidash-pihead" style="color:white">Info</div>
						<div class="clidash-pibod">
							<div class="row">
								<div class="col-md-4 clidash-pibodcont">
									<div class="clidash-pibodconth" style="color:white">@lang('admin.dashboard.Rides')</div>
									<div class="clidash-pibodconn" style="color:white">{{$rides->count()}}</div>
								</div>
								<div class="col-md-4 clidash-pibodcont">
									<div class="clidash-pibodconth" style="color:white">@lang('admin.dashboard.scheduled')</div>
									<div class="clidash-pibodconn" style="color:white">{{$scheduled_count}}</div>
								</div>
								<div class="col-md-4 clidash-pibodcont">
									<div class="clidash-pibodconth" style="color:white">@lang('admin.dashboard.providers')</div>
									<div class="clidash-pibodconn" style="color:white">{{count($providers)}}</div>
								</div>
							</div>
						</div>
					</div>
					<div class="clidashr-ac">
						<div class="clidashr-achead">@lang('admin.custom.Accounting')</div>
						<div class="clidash-acmile">
							<div class="row">
								<div class="col-md-6 clidash-acmiletm">
									<div class="clidash-acmiletmhead">@lang('admin.dashboard.Revenue')</div>
									<div class="clidash-acmilebody">{{number_format($revenue, 2, '.', '').config('constants.currency')}}</div>
								</div>
								<div class="col-md-6 clidash-acmilepm">
									<div class="clidash-acmiletmhead">@lang('admin.include.wallet')</div>
									<div class="clidash-acmilebody">{{number_format(Auth::user()->wallet_balance, 2, '.', '').config('constants.currency')}}</div>
								</div>
							</div>
						</div>
						<div class="clidash-acmileb">
							<div class="row">
								<div class="col-md-12 clidash-acmiletmb">
									<div class="clidash-acmiletmheadb">@lang('provider.current_balance')</div>
									<div class="clidash-acmilebodyb">{{number_format($wallet_balance, 2, '.', '').config('constants.currency')}}</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection
@section('scripts')
@endsection