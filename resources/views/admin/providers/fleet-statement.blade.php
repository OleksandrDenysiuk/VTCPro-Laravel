	@extends('admin.layout.base')

@section('title')

@section('content')

    <div class="content-area py-1">
        <div class="container-fluid">
            <div class="box box-block bg-white">
            	<h3>@lang('admin.include.fleet_ride_histroy')</h3>

            	<div class="row">

						<div class="row row-md mb-2" style="padding: 15px;">
							<div class="col-md-12">
									<div class="box bg-white">
										<div class="box-block clearfix">
											<div class="float-xs-right">
											</div>
										</div>

										@if(count($Fleets) != 0)
								            <table class="table table-striped table-bordered dataTable" id="table-6">
								                <thead>
								                   <tr>
													   <td>@lang('admin.users.name')</td>
													   <td>@lang('admin.country_code')</td>
													   <td>@lang('admin.mobile')</td>
													   <td>@lang('admin.users.Total_Rides')</td>
													   <td>@lang('admin.fleets.Total_Earnings')</td>
													   <td>@lang('admin.users.Joined_at')</td>
													   <td>@lang('admin.users.Details')</td>
													</tr>
								                </thead>
								                <tbody>
								                <?php $diff = ['-success','-info','-warning','-danger']; ?>
														@foreach($Fleets as $index => $fleet)
															<tr>
																<td>
																	{{$fleet->name}}
																</td>
																<td>
																	{{$fleet->country_code}}
																</td>
																<td>
																	{{$fleet->mobile}}
																</td>

																<td>
																	@if($fleet->rides_count)
																		{{$fleet->rides_count}}
																	@else
																	 	-
																	@endif
																</td>
																<td>
																	@if($fleet->payment)
																		{{currency($fleet->payment[0]->overall)}}
																	@else
																	 	-
																	@endif
																</td>
																<td>
																	@if($fleet->created_at)
																		<span class="text-muted">{{appDate($fleet->created_at)}}</span>
																	@else
																	 	-
																	@endif
																</td>
																<td>
																	<a href="{{route('admin.statement_fleet', $fleet->id)}}">@lang('admin.custom.ride_history')</a>
																</td>
															</tr>
														@endforeach

								                <tfoot>
								                    <tr>
														<td>@lang('admin.users.name')</td>
														<td>@lang('admin.country_code')</td>
														<td>@lang('admin.mobile')</td>
														<td>@lang('admin.users.Total_Rides')</td>
														<td>@lang('admin.fleets.Total_Earnings')</td>
														<td>@lang('admin.users.Joined_at')</td>
														<td>@lang('admin.users.Details')</td>
													</tr>
								                </tfoot>
								            </table>
								            @else
								            <h6 class="no-result">@lang('admin.custom.no_results')</h6>
								            @endif

									</div>
								</div>

							</div>

            	</div>

            </div>
        </div>
    </div>

@endsection
