@extends('admin.layout.base')

@section('title')

@section('content')

    <div class="content-area py-1">
        <div class="container-fluid">

            <div class="box box-block bg-white">
                @if(Setting::get('demo_mode', 0) == 1)
                    <div class="col-md-12" style="height:50px;color:red;">
                        ** Demo Mode : @lang('admin.demomode')
                    </div>
                @endif
                <h5 class="mb-1">@lang('admin.lostitem.title')</h5>
                @can('lost-item-create')
               <a href="{{ route('admin.lostitem.create') }}" style="margin-left: 1em;" class="btn btn-primary pull-right"><i class="fa fa-plus"></i> @lang('admin.lostitem.add')</a>
               @endcan

                <table class="table table-striped table-bordered dataTable" id="table-2">
                    <thead>
                        <tr>
                            <th>@lang('admin.id')</th>
                            <th>@lang('admin.lostitem.lost_id') </th>
                            <th>@lang('admin.request.Booking_ID') </th>
                            <th>@lang('admin.lostitem.lost_user') </th>
                            <th>@lang('admin.lostitem.lost_item') </th>
                            <th>@lang('admin.lostitem.lost_comments') </th>
                            <th>@lang('admin.lostitem.lost_status') </th>
                            <th>@lang('admin.action')</th>
                        </tr>
                    </thead>
                    <tbody>
                    @foreach($lostitem as $index => $lost)
                        <tr>
                            <td>{{ $index + 1 }}</td>
                            <td>{{ $lost->request_id }}</td>
                            <td>{{ getBookingID($lost->request_id)  }}</td>
                            <td>{{ getUserName($lost->user_id)  }}</td>
                            <td>{{ $lost->lost_item_name }}</td>
                            <td>{{ $lost->comments }}</td>
                            <td>
                                @if($lost->status=='open')
                                    <span class="tag tag-success">@lang('admin.custom.open')</span>
                                @else
                                    <span class="tag tag-danger">@lang('admin.custom.closed')</span>
                                @endif
                            </td>
                            <td>
                                @if( Setting::get('demo_mode', 0) == 0)
                                @can('lost-item-edit')
                                    @if($lost->status=='open')
                                        <a href="{{ route('admin.lostitem.edit', $lost->id) }}" href="#" class="btn btn-info"><i class="fa fa-pencil"></i> @lang('admin.custom.edit')
</a>
                                    @endif
                                @endcan
                                @endif
                            </td>
                        </tr>
                    @endforeach
                    </tbody>
                    <tfoot>
                        <tr>
                            <th>@lang('admin.id')</th>
                            <th>@lang('admin.lostitem.lost_id') </th>
                            <th>@lang('admin.request.Booking_ID') </th>
                            <th>@lang('admin.lostitem.lost_user') </th>
                            <th>@lang('admin.lostitem.lost_item') </th>
                            <th>@lang('admin.lostitem.lost_comments') </th>
                            <th>@lang('admin.lostitem.lost_status') </th>
                            <th>@lang('admin.action')</th>
                        </tr>
                    </tfoot>
                </table>
            </div>

        </div>
    </div>
@endsection
