@extends('fleet.layout.base')

@section('title')

@section('content')

<div class="add-client">
	<form class="form-horizontal" action="{{route('fleet.profile.update')}}" method="POST" enctype="multipart/form-data" role="form">
    {{csrf_field()}}

        <div class="row">
            <div class="col-md-4 upload-profile-pic">
                <div class="upload-pro-pic">
                    <div class="img-uploadwrap">
                        <img src="{{img(Auth::guard('fleet')->user()->logo)}}" class="img-fluid" id="blah" />
                    </div>
                    <div class="input-btn">
                        +
                        <input type="file" name="logo" data-clientid="1" class="pro-pic" id="imgInp" />
                    </div>
                    <h4>@lang('admin.custom.fleet_image')</h4>
                    <div style="display:none;" class="imageupates col-md-12">
                        <p class='alert alert-success'><i class='fa fa-check'></i> @lang('admin.custom.fleet_picture')</p>
                    </div>
                    <div style="display:none;" class="imageupatesfail col-md-12">
                        <p class='alert alert-danger'><i class='fa fa-close'></i> @lang('admin.account.Protoo')</p>
                    </div>
                </div>
            </div>

            <div class="col-md-8 user-info">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group row">
                            <div class="col-md-12">
                                <div class="field-label"><label for="firstName">@lang('admin.name')</label></div>
								<input class="form-control" style="height:35px !important; border-radius:5px" type="text" value="{{ Auth::guard('fleet')->user()->name }}" name="name" required id="name" placeholder="@lang('admin.name')">
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-12">
                                <div class="field-label"><label for="">@lang('admin.company')</label></div>
								<input class="form-control" style="height:35px !important; border-radius:5px"  type="text" required name="company" value="{{ isset(Auth::guard('fleet')->user()->company) ? Auth::guard('fleet')->user()->company : '' }}" id="company" placeholder="@lang('admin.company')">
                            </div>
                        </div>

                    </div>

                    <div class="col-md-6">
						<div class="form-group row">
							<div class="col-md-12">
                                <div class="field-label"><label for="">@lang('admin.email')</label></div>
								<input class="form-control" style="height:35px !important; border-radius:5px"  type="email" required name="email" value="{{ isset(Auth::guard('fleet')->user()->email) ? Auth::guard('fleet')->user()->email : '' }}" id="email" placeholder="@lang('admin.email')" readonly>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-md-12">
                                <div class="field-label"><label for="">@lang('admin.mobile')</label></div>
								<input class="form-control" style="height:35px !important; border-radius:5px"  type="text" required name="mobile" value="{{ isset(Auth::guard('fleet')->user()->mobile) ? Auth::guard('fleet')->user()->mobile : '' }}" id="mobile" placeholder="@lang('admin.mobile')">
                            </div>
                        </div>

					</div>
					<div class="col-md-12">
					<div class="form-group row">
                            <div class="col-md-12">
                                <div class="field-label"><label for="website">@lang('user.profile.language')</label></div>
								@php($language=get_all_language())
								<select class="form-control" name="language" id="language" style="height:35px !important; border-radius:5px; padding:0 !important;" >
									@foreach($language as $lkey=>$lang)
										<option value="{{$lkey}}" @if(Auth::user()->language==$lkey) selected @endif>{{$lang}}</option>
									@endforeach
								</select>
                            </div>
                        </div>
					</div>
                    <div class="col-md-12 submit-btnal">
                        <div class="form-group row">
                            <input class="bigbutton" value="@lang('admin.account.update_profile')" name="add-client" type="submit" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </form>
</div>


@endsection
