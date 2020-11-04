@extends('fleet.layout.base')

@section('title','test')
@section('styles-in')
<style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0, 0, 0);
        background-color: rgba(0, 0, 0, 0.2);
    }

    /* Modal Content */
    .modal-content {
        background-color: #fefefe;
        min-width: 500px;
        padding: 20px;
        border: 1px solid #888;
        width: 50%;
        margin-top: 50px;
        height: calc(100vh - 100px);
        overflow-y: auto;
    }

    /* .provider_lists {
        overflow-y: auto;
    } */

    /* The Close Button */
    .close {
        color: #aaaaaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

    .modal-icon-box {
        border: 2px solid #ccc;
        padding: 5px 10px;
        border-radius: 5px;
        background: 0 0;
    }

    .ui.dimmer {
        background-color: rgba(0, 0, 0, 0.4);
    }

    .column {
        float: left;
        width: 25%;
        padding: 10px;
    }

    /* Clear floats after the columns */
    .gd-row:after {
        content: "";
        display: table;
        clear: both;
    }

    .gd-row {
        border-bottom: 1px solid gray;
    }

    .gd-row .column.bg1{
        background-color: #bbb;
    }
    .gd-row .column.bg2{
        background-color: #ccc;
    }
    .gd-row .column.bg3{
        background-color: #ddd;
    }
    .gd-row .column.bg0{
        background-color: #aaa;
    }

    .limited_line1 {
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        line-height: 36px;     /* fallback */
        max-height: 30px;      /* fallback */
        -webkit-line-clamp: 1; /* number of lines to show */
        -webkit-box-orient: vertical;
    }
    .limited_line2 {
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        line-height: 16px;     /* fallback */
        max-height: 22px;      /* fallback */
        -webkit-line-clamp: 1; /* number of lines to show */
        -webkit-box-orient: vertical;
    }
    .timeDownSperator, .item-counter-down  {
        color: red;
        font-size: 20px;
        font-weight: 800;
    }
    
</style>
@endsection
@section('content')

    <div class="content-area py-1">
        <div class="container-fluid">
        @include('common.notify')
            <div id="myModal" class="modal">
                <div class="modal-content text-center">
                    <span class="close">&times;</span>
                    <span class="modal_title" style="font-weight:800; font-size:20px;">@lang('admin.custom.assign_provider')</span>
                    <br><br><br>
                    <div class="provider_lists">
                    </div>
                </div>
            </div>        

            <div class="box box-block bg-white">
                <h5 class="mb-1">@lang('admin.custom.scheduled_rides')</h5>
                @if(count($requests) != 0)
                <table class="table table-striped table-bordered dataTable" id="table-2">
                    <thead>
                        <tr>
                            <th>@lang('admin.id')</th>
                            <th>@lang('admin.request.Request_Id')</th>
                            <th>@lang('admin.request.User_Name')</th>
                            <th>@lang('admin.request.Provider_Name')</th>
                            <th>@lang('admin.request.Scheduled_Date_Time')</th>
                            <th>@lang('admin.status')</th>
                            <th>@lang('admin.request.Payment_Mode')</th>
                            <th>@lang('admin.request.Payment_Status')</th>
                            <th>@lang('admin.custom.temps_accor')</th>
                            <th>@lang('admin.action')</th>
                        </tr>
                    </thead>
                    <tbody>
                    @foreach($requests as $index => $request)
                        <tr>
    						                        <td>{{$index + 1}}</td>

    						                        <td>{{$request->booking_id}}</td>
    						                        <td>{{$request->user->first_name}} {{$request->user->last_name}}</td>
    						                        <td>
                                @if($request->provider_id)
                                    {{$request->provider->first_name}} {{$request->provider->last_name}}
                                @else
                                    N/A
                                @endif
                            </td>
    						                        <td>{{$request->schedule_at}}</td>
    						                        <td>
                                {{$request->status}}
                            </td>

    						                        <td>{{$request->payment_mode}}</td>
    						                        <td>
                                @if($request->paid)
                                    @lang('admin.payment.paidds')
                                @else
                                    @lang('admin.payment.nopaids')
                                @endif
                            </td>
    						                        <td>
                                <span id='timer-{{$index}}'>@if($request->manual_assigned_at == null) N/A @endif</span>
                                @if($request->manual_assigned_at && $request->provider)
                                <button type="button" class="btn btn-info force-assigned" style="margin-left:15px; background-color:red!important; border-color:red!important;" rid="{{$request->id}}">@lang('admin.custom.force_assign')</button>
                                @endif

                                @if($request->manual_assigned_at && $request->provider)
                                <form action="{{route('fleet.assign.provider.force')}}" method="POST" class="force-assign{{$request->id}}">
                                    @csrf
                                    <input type="hidden" name="id" value="{{$request->id}}">
                                    <input type="hidden" name="provider_id" value="{{$request->provider->id}}">
                                </form>
                                @endif

    						                        <td>
                                <div class="input-group-btn">
                                  <button type="button" class="btn btn-info dropdown-toggle" data-toggle="dropdown">Action
                                    <span class="caret"></span>
                                  </button>
                                  <ul class="dropdown-menu">
                                    <li>
                                        <a href="{{ route('fleet.requests.show', $request->id) }}" class="btn btn-default"><i class="fa fa-search"></i> @lang('admin.payment.moredsq')</a><br>
                                        <a href="{{ route('fleet.requests.cancel', $request->id) }}" class="btn btn-default assign_fleet" class="btn btn-default" req-id="{{$request->id}}"><i class="fa fa-times"></i> @lang('admin.custom.cancel_assign')</a><br>
                                        <a href="{{ route('fleet.scheduled.provider.list', $request->id) }}" class="btn btn-default assign_provider" req-id="{{$request->id}}"><i class="fa fa-taxi"></i> @lang('admin.custom.assign_provider')</a><br>
                                    </li>
                                  </ul>
                                </div>
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                    <tfoot>
                        <tr>
                            <th>@lang('admin.id')</th>
                            <th>@lang('admin.request.Request_Id')</th>
                            <th>@lang('admin.request.User_Name')</th>
                            <th>@lang('admin.request.Provider_Name')</th>
                            <th>@lang('admin.request.Scheduled_Date_Time')</th>
                            <th>@lang('admin.status')</th>
                            <th>@lang('admin.request.Payment_Mode')</th>
                            <th>@lang('admin.request.Payment_Status')</th>
                            <th>@lang('admin.custom.temps_accor')</th>
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
<script type="text/javascript" src="{{asset('asset/js/countdowntimer/timeDownCounter.js')}}"></script>
<script type="text/javascript" src="https://momentjs.com/downloads/moment-timezone-with-data.min.js"></script>

<script type="text/javascript">

    function clickProvider(req_id) {
        var idd = {{Auth::user()->id}};
        $('.modal_title').html("Assign Provider");
        $('.provider_lists').html("...");
        $('#myModal').modal('show');
        var url = "{{url('/flt/myprovs')}}";
        $.ajax({
            url: url,
            type: "POST",
            data: {id: idd},
            headers: {'X-CSRF-TOKEN': window.Laravel.csrfToken, 'X-Requested-With' : 'XMLHttpRequest' },
            beforeSend: function() {
            },
            success: function(responseJSON) {
                // console.log(responseJSON);
                var data = JSON.parse(responseJSON);
                var provs = data.data;
                var html = "";
                for(i = 0 ; i < provs.length ; i++) {
                    if (i % 4 == 0)
                    html += '<div class="gd-row">'
                    // <img src="{{url("/")}}/'+provs[i]['avatar']+'" width=50 height=50 class="img-fluid rounded-circle">\
                    html += '<div onclick="javascript:onClickProvider('+provs[i]['id']+', \''+provs[i]['first_name']+" "+provs[i]['last_name']+'\')" data-prov-id="'+provs[i]['id']+'" class="provider column bg'+(i % 4)+'">\
                                <img src="{{url("/")}}/main/avatar.jpg" width=50 height=50 class="img-fluid rounded-circle">\
                                <h2 class="limited_line1">'+provs[i]['first_name']+" "+provs[i]['last_name']+'</h2>\
                                <p class="limited_line2">'+provs[i]['email']+'</p>\
                                <p style="color:#b531ba;font-weight:bold">Click to Assign</p>\
                            </div>';
                    if (i % 4 == 3 || i == provs.length - 1)
                        html += '</div>'
                }
                var form = '<form id="assign_provider_form"  action="{{url("/fleet/assign/provider")}}" method="POST">\
                            <input type="hidden" name="_token" value="{{csrf_token()}}">\
                            <input type="hidden" id="p_i_d" name="provider_id" value="">\
                            <input type="hidden" name="req_id" value="'+req_id+'">\
                            '+html+'\
                            </form>';
                $('.provider_lists').html(form);
            },
            error: function(){
                $('.provider_lists').html("There are no providers.");
            }
        });
    }
    function onClickProvider(pid, name) {
        if (confirm("Are you sure to assign with <"+name+">?") == true) {
            $("#p_i_d").val(pid);
            $("#assign_provider_form").submit();
        }
    }
    @foreach($requests as $index => $request)
        @if($request->manual_assigned_at)
            try {
                var timezone = '{{config('constants.timezone', 'UTC')}}';
                // console.log('{{$request->manual_assigned_at}} '+ timezone);
                var serverDate = moment.tz('{{$request->manual_assigned_at}}', timezone);
                var dd = serverDate.clone().tz(moment.tz.guess());
                var date = new Date(dd.format('DD-MM-YYYY - HH:mm:ss'));
                // console.log(date);
                date.setHours(date.getHours() + {{$request->timeout}});
                timeDownCounter({
                    'countDownDate': date.getTime(), // Direct Use like: new Date("Sep 5, 2018 15:37:25").getTime();
                    'addSpanForResult': true,
                    'countDownIdSelector': 'timer-{{$index}}',
                    'contDownOver': 'N/A',
                    'countDownReturnData': 'from-hours'
                }).startCountDown();
            } catch (error) {
                console.log(error);
            }
        @endif
    @endforeach

    $('#table-2').on('click', '.force-assigned', function(){
        var id = $(this).attr('rid');
        if (confirm('Are you sure to force assign?')) {
            $('#table-2 .force-assign' + id).submit();
        }
    })

</script>
@endsection