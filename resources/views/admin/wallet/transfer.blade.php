@extends('admin.layout.base')

@section('title')

@section('content')

<div class="content-area py-1">
    <div class="container-fluid">
        @if($utype=='provider') @php($flag=1) @else @php($flag=2) @endif
        <div class="box box-block bg-white">
            @if(Setting::get('demo_mode', 0) == 1)
            <div class="col-md-12" style="hSetting::get('demo_mode', 0) == 0eight:50px;color:red;">
                ** Demo Mode : No Permission to create or send settlements.
            </div>
            @endif
            @php($action = $utype=='provider' ? 'admin.providertransfer' : 'admin.fleettransfer')
            @include('common.date_filter', ['action' => $action])

            @if(Setting::get('demo_mode', 0) == 0)
            <a href="{{route('admin.transfercreate', $flag)}}" style="margin-left: 1em;" class="btn btn-primary pull-right"><i class="fa fa-plus"></i> @lang('admin.addsettle')</a>
            @endif
            <table class="table table-striped table-bordered dataTable" id="table-6">
                <thead>
                    <tr>
                        <th>@lang('admin.sno')</th>
                        <th>@lang('admin.transaction_ref')</th>
                        <th>@lang('admin.datetime')</th>
                        @if($utype=='provider')
                        <th>@lang('admin.provides.provider_name')</th>
                        @else
                        <th>@lang('admin.fleet.fleet_name')</th>
                        @endif
                        <th>@lang('admin.amount')</th>
                        <th>@lang('admin.action')</th>
                    </tr>
                </thead>
                <tbody>
                    @php($total=0)
                    @foreach($pendinglist as $index=>$pending)
                    @php($total+=$pending->amount)
                    <tr>
						                        <td>{{$index+1}}</td>
						                        <td>{{$pending->alias_id}}</td>
						                        <td>{{appDate($pending->created_at)}}</td>
                        @if($utype=='provider')
						                        <td>{{$pending->provider->first_name." ".$pending->provider->last_name}} </td>
                        @endif
                        @if($utype=='fleet')
						                        <td>{{$pending->fleet->name}} </td>
                        @endif
						                        <td>{{currency($pending->amount)}}</td>
						                        <td>
                            @if( Setting::get('demo_mode', 0) == 0)
                            <!-- <a class="btn btn-success btn-block" href="{{ route('admin.approve', $pending->id) }}">@lang('admin.approve')</a> -->
                            <button type="button" class="btn btn-success btn-block transferClass" data-toggle="modal" data-target="#transferModal" data-id="send" data-href="{{route('admin.approve', $pending->id) }}" data-rid="{{$pending->id}}">@lang('admin.approve')</button>
                            <!-- <a class="btn btn-danger btn-block" href="{{ route('admin.cancel') }}?id={{$pending->id}}">@lang('admin.cancel')</a> -->

                            <button type="button" class="btn btn-danger btn-block transferClass" data-toggle="modal" data-target="#transferModal" data-id="cancel" data-href="{{ route('admin.cancel') }}?id={{$pending->id}}" data-rid="{{$pending->id}}">@lang('admin.cancel')</button>
                            @endif
                        </td>

                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

    </div>
</div>

<!-- Modal -->
<div id="transferModal" class="modal fade" role="dialog" data-backdrop="static" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->
                <h4 class="modal-title" id="settitle"></h4>
            </div>
            <form action="" method="Get" id="transurl">
                <div class="modal-body">
                    <div id="sendbody" style="display:none">
                        <div class="form-group row">
                            <label for="send_by" class="col-xs-3 col-form-label" required>@lang('admin.payment.carments')</label>
                            <div class="col-xs-5">
                                <select class="form-control" name="send_by" id="send_by">
                                    @if(config("constants.card")==1)
                                    <option value="online">Stripe</option>
                                    @endif
                                    @if(config("constants.cash")==1)
                                    <option value="offline">@lang('admin.custom.cash')</option>
                                    @endif
                                </select>
                            </div>
                        </div>
                        <div id="show_alert_text" class="alert alert-warning alert-dismissible" style="display:none">
                            <strong>@lang('admin.payment.wwhhs')</strong> <span id="setbody">@lang('admin.payment.caswsh')</span>
                        </div>
                    </div>
                    <div id="cancelbody" style="display:none">
                        <input type="hidden" value="" name="id" id="transfer_id">
                        <div class="alert alert-warning alert-dismissible">
                            <strong>@lang('admin.payment.wwhhs')</strong> <span id="setbody">@lang('admin.payment.gfddd')</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    @if(config("constants.card")==1 || config("constants.cash")==1)
                    <!-- <a class="btn btn-success" href="#" id="transurl">@lang('admin.payment.coor')</a> -->
                    <button type="submit" class="btn btn-success">@lang('admin.payment.coor')</button>
                    @endif
                    <button type="button" class="btn btn-danger" data-dismiss="modal">@lang('admin.payment.closs')</button>
                </div>
            </form>
        </div>

    </div>
</div>
@endsection

@section('scripts')
<script type="text/javascript">
    var card = '{{config("constants.card")}}';
    @if(config("constants.card") == 0)
    $("#show_alert_text").show();
    @endif
    $(function() {
        $(".transferClass").click(function() {
            var curl = $(this).attr('data-href');
            var page = $(this).attr('data-id');
            $("#transurl").attr('action', curl);
            if (page == 'send') {
                $("#settitle").text('Confirm Settlement');
                $("#cancelbody").hide();
                $("#sendbody").show();
                $("#send_by").on('change', function() {
                    var ddval = $("#send_by").val();
                    if (ddval == "offline") {
                        $("#show_alert_text").show();
                    } else {
                        $("#show_alert_text").hide();
                    }
                })

            } else {
                $("#transfer_id").val($(this).attr('data-rid'));
                $("#settitle").text('Cancel Settlement');
                $("#sendbody").hide();
                $("#cancelbody").show();
            }

        })
    });

    $(".showdate").on('click', function() {
        var ddattr = $(this).attr('id');
        // console.log(ddattr);
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