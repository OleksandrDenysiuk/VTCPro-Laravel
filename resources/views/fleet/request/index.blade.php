@extends('fleet.layout.base')

@section('title')
@section('styles')
    <style>
        #idx{
            display: none;
        }
    </style>
@stop
@section('content')
    <!-- Invoice Modal -->

    @foreach($requests as $trip)
        @if($trip->status === 'COMPLETED')
            @include('fleet.invoice.trip-invoice', ['trip' => $trip, 'fleet' => $fleet])
        @endif
    @endforeach
    <!-- Invoice Modal -->
<div class="content-area py-1">
    <div class="container-fluid">
        @include('common.date_filter', ['action' => 'fleet.requests.index'])
        <div class="box box-block bg-white">
            <h5 class="mb-1">@lang('admin.provides.bhis')</h5>
            @if(count($requests) != 0)
            <table class="table table-striped table-bordered dataTable" id="table-6" style="width: 100%;">
                <col width="3%">
                <col width="10%">
                <col width="10%">
                <col width="10%">
                <col width="16%">
                <col width="7%">
                <col width="7%">
                <col width="8%">
                <col width="8%">
                <col width="21%">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>@lang('admin.request.Booking_ID')</th>
                        <th>@lang('admin.request.User_Name')</th>
                        <th>@lang('admin.request.Provider_Name')</th>
                        <th id="dates">@lang('admin.request.Date_Time')</th>
                        <th>@lang('admin.status')</th>
                        <th>@lang('admin.amount')</th>
                        <th>@lang('admin.request.Payment_Mode')</th>
                        <th>@lang('admin.request.Payment_Status')</th>
                        <th>@lang('admin.action')</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($requests as $index => $request)
                    <tr>
                        <td>{{$request->ids}}</td>
                        <td>{{ $request->booking_id }}</td>
                        <td>
                            @if($request->user_type ==='FLEET_COMPANY' || $request->user_type === 'FLEET_PASSENGER')
                                {{$request->company_name}}
                            @else
                                {{$request->first_name}} {{$request->last_name}}
                            @endif
                        </td>
                        <td>
                            @if($request->provider_first !== "")
                            {{ $request->provider_first }} {{ $request->provider_last }}
                            @else
                            N/A
                            @endif
                        </td>
                        <td>{{ $request->created_at }}</td>
                        <td>{{ $request->status }}</td>
                        <td>
                            @if($request->total != "")
                            {{ currency($request->total) }}
                            @else
                            N/A
                            @endif
                        </td>
                        <td>{{ $request->payment_mode }}</td>
                        <td>
                            @if($request->paid)
                            @lang('admin.custom.Paid')
                            @else
                            @lang('admin.custom.Unpaid')
                            @endif
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-primary waves-effect dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                    Action
                                </button>
                                <div class="dropdown-menu">
                                    <a href="{{ route('fleet.requests.show', $request->ids) }}" class="dropdown-item">
                                        <i class="fa fa-search"></i> @lang('admin.payment.moredsq')
                                    </a>
                                    @if( Setting::get('demo_mode', 0) == 0)
                                    <form action="{{ route('fleet.requests.destroy', $request->ids) }}" method="POST">
                                        {{ csrf_field() }}
                                        {{ method_field('DELETE') }}
                                        <button type="submit" class="dropdown-item">
                                            <i class="fa fa-trash"></i> @lang('admin.custom.delete')
                                        </button>
                                    </form>
                                    @endif
                                </div>
                                @if($request->status == 'COMPLETED')
                                    <div class="input-group-btn" style="left:5px; display:inline-block">
                                    </div>
                                @endif
                            </div>
                        </td>
                    </tr>
                    @endforeach
                </tbody>
                <tfoot>
                    <tr>
                        <th>Id</th>
                        <th>@lang('admin.request.Booking_ID')</th>
                        <th>@lang('admin.request.User_Name')</th>
                        <th>@lang('admin.request.Provider_Name')</th>
                        <th>@lang('admin.request.Date_Time')</th>
                        <th>@lang('admin.status')</th>
                        <th>@lang('admin.amount')</th>
                        <th>@lang('admin.request.Payment_Mode')</th>
                        <th>@lang('admin.request.Payment_Status')</th>
                        <th>@lang('admin.action')</th>
                    </tr>
                </tfoot>
            </table>
            @else
            <h6 class="no-result">@lang('admin.custom.reds')</h6>
            @endif
        </div>
    </div>
</div>
@endsection
@section('scripts')
<script type="text/javascript">
    $('documents').ready(function () {

    });

    $('#table-6').on('click', '.downloadpdf', function(e) {
        var id = $(this).attr('idx');
        console.log(id);
        $('#view-invoice' + id).modal('show');
        $("#view-invoice" + id).css('top', 0);
        $("#view-invoice" + id).css('margin-top', 0);
        $("#view-invoice" + id).scrollTop(0);
        e.returnValue = false;
        return false;
    });

    $(".showdate").on('click', function() {
        var ddattr = $(this).attr('id');
        if (ddattr == 'tday') {
            $("#from_date").val('{{$dates["today"]}}');
            $("#to_date").val('{{$dates["today"]}}');
            $('#date_filter').val('tday');
        } else if (ddattr == 'yday') {
            $("#from_date").val('{{$dates["yesterday"]}}');
            $("#to_date").val('{{$dates["yesterday"]}}');
            $('#date_filter').val('yday');
        } else if (ddattr == 'cweek') {
            $("#from_date").val('{{$dates["cur_week_start"]}}');
            $("#to_date").val('{{$dates["cur_week_end"]}}');
            $('#date_filter').val('cweek');
        } else if (ddattr == 'pweek') {
            $("#from_date").val('{{$dates["pre_week_start"]}}');
            $("#to_date").val('{{$dates["pre_week_end"]}}');
            $('#date_filter').val('pweek');
        } else if (ddattr == 'cmonth') {
            $("#from_date").val('{{$dates["cur_month_start"]}}');
            $("#to_date").val('{{$dates["cur_month_end"]}}');
            $('#date_filter').val('cmonth');
        } else if (ddattr == 'pmonth') {
            $("#from_date").val('{{$dates["pre_month_start"]}}');
            $("#to_date").val('{{$dates["pre_month_end"]}}');
            $('#date_filter').val('pmonth');
        } else if (ddattr == 'pyear') {
            $("#from_date").val('{{$dates["pre_year_start"]}}');
            $("#to_date").val('{{$dates["pre_year_end"]}}');
            $('#date_filter').val('pyear');
        } else if (ddattr == 'cyear') {
            $("#from_date").val('{{$dates["cur_year_start"]}}');
            $("#to_date").val('{{$dates["cur_year_end"]}}');
            $('#date_filter').val('cyear');
        } else {
            alert('invalid dates');
            $('#date_filter').val('');
        }
    });
</script>
@endsection
