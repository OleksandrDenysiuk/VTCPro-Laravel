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
            @can('service-types-create')
            <a href="{{ route('admin.service.create') }}" style="margin-left: 1em;" class="btn btn-primary pull-right"><i class="fa fa-plus"></i> @lang('admin.custom.add_service')</a>
            @endcan
            <table class="table table-striped table-bordered dataTable" id="table-2">
                <thead>
                    <tr>
                        <th>@lang('admin.id')</th>
                        <th>@lang('admin.service.Service_Name')</th>
                        <!-- <th>Provider Name</th> -->
                        <th>@lang('admin.custom.service_capacity')</th>
                        <th>@lang('admin.custom.service_basepr')</th>
                        <th>@lang('admin.custom.service_distance')</th>
                        <th>@lang('admin.custom.service_price')</th>
                        <th>@lang('admin.custom.service_time')</th>
                        <th>@lang('admin.custom.service_hour')</th>
                        <th>@lang('admin.custom.service_calc')</th>
                        <th>@lang('admin.custom.service_image')</th>
                        <th>@lang('admin.custom.service_marker')</th>
                        <th>@lang('admin.action')</th>
                    </tr>
                </thead>
                <tbody>
                @foreach($services as $index => $service)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $service->name }}</td>
                        <!-- <td>{{ $service->provider_name }}</td> -->
                        <td>{{ $service->capacity }}</td>
                        <td>{{ currency($service->fixed) }}</td>
                        <td>{{ distance($service->distance) }}</td>
                        <td>{{ currency($service->price) }}</td>
                        <td>{{ currency($service->minute) }}</td>
                        @if($service->calculator == 'DISTANCEHOUR' || $service->calculator == 'HOUR') 
                        <td>{{ currency($service->hour) }}</td>
                        @else
                        <td>@lang('admin.custom.service_hour')</td>
                        @endif
                        <td>@lang('servicetypes.'.$service->calculator)</td>
                        <td>
                            @if($service->image) 
                                <img src="{{$service->image}}" style="height: 50px" >
                            @else
                                N/A
                            @endif
                        </td>
                        <td>
                            @if($service->marker) 
                                <img src="{{$service->marker}}" style="height: 50px" >
                            @else
                                N/A
                            @endif
                        </td>
                        <td>
                            <form action="{{ route('admin.service.destroy', $service->id) }}" method="POST">
                                {{ csrf_field() }}
                                {{ method_field('DELETE') }}
                                @if( Setting::get('demo_mode', 0) == 0)
                                @can('service-types-edit')
                                <a href="{{ route('admin.service.edit', $service->id) }}" class="btn btn-info btn-block">
                                    <i class="fa fa-pencil"></i> @lang('admin.custom.edit')
                                </a>
                                @endcan
                                @can('service-types-delete')
                                <button class="btn btn-danger btn-block" onclick="return confirm('Are you sure?')">
                                    <i class="fa fa-trash"></i> @lang('admin.custom.delete')
                                </button>
                                @endcan
                                @endif
                            </form>
                        </td>
                    </tr>
                @endforeach
                </tbody>
                <tfoot>
                    <tr>
                        <th>@lang('admin.id')</th>
                        <th>@lang('admin.custom.service_name')</th>
                        <!-- <th>Provider Name</th> -->
                        <th>@lang('admin.custom.service_capacity')</th>
                        <th>@lang('admin.custom.service_basepr')</th>
                        <th>@lang('admin.custom.service_distance')</th>
                        <th>@lang('admin.custom.service_price')</th>
                        <th>@lang('admin.custom.service_time')</th>
                        <th>@lang('admin.custom.service_hour')</th>
                        <th>@lang('admin.custom.service_calc')</th>
                        <th>@lang('admin.custom.service_image')</th>
                        <th>@lang('admin.custom.service_marker')</th>
                        <th>@lang('admin.action')</th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
@endsection