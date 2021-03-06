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
            @can('dispute-manager-create')
            <a href="{{ route('admin.dispute-manager.create') }}" style="margin-left: 1em;" class="btn btn-primary pull-right"><i class="fa fa-plus"></i> @lang('admin.dispute-manager.add_new_dispute_manager')</a>
            @endcan
            <table class="table table-striped table-bordered dataTable" id="table-2">
                <thead>
                    <tr>
                        <th>@lang('admin.id')</th>
                        <th>@lang('admin.account-manager.full_name')</th>
                        <th>@lang('admin.email')</th>
                        <th>@lang('admin.custom.code_pays')</th>
                        <th>@lang('admin.mobile')</th>
                        <th>@lang('admin.action')</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($accounts as $index => $account)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $account->name }}</td>
                        @if(Setting::get('demo_mode', 0) == 1)
                        <td>{{ substr($account->email, 0, 3).'****'.substr($account->email, strpos($account->email, "@")) }}</td>
                        @else
                        <td>{{ $account->email }}</td>
                        <td>{{ $account->country_code }}</td>
                        @endif
                        @if(Setting::get('demo_mode', 0) == 1)
						                        <td>+33612345678</td>
                        @else
                        <td>{{ $account->country_code }}{{ $account->mobile }}</td>
                        @endif
                        <td>
                            <form action="{{ route('admin.dispute-manager.destroy', $account->id) }}" method="POST">
                                {{ csrf_field() }}
                                <input type="hidden" name="_method" value="DELETE">
                                @if( Setting::get('demo_mode', 0) == 0 && $index !=0)
                                <a href="{{ route('admin.dispute-manager.edit', $account->id) }}" class="btn btn-info"><i class="fa fa-pencil"></i> @lang('admin.edit')</a>
                                <button class="btn btn-danger" onclick="return confirm('@lang('admin.custom.are_you_sure')')"><i class="fa fa-trash"></i> @lang('admin.delete')</button>
                                @endif
                            </form>
                        </td>
                    </tr>
                    @endforeach
                </tbody>
                <tfoot>
                    <tr>
                        <th>@lang('admin.id')</th>
                        <th>@lang('admin.account-manager.full_name')</th>
                        <th>@lang('admin.email')</th>
                        <th>@lang('admin.custom.code_pays')</th>
                        <th>@lang('admin.mobile')</th>
                        <th>@lang('admin.action')</th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
@endsection
