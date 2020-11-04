@extends('fleet.layout.auth')

@section('content')
<div class="sign-form">
    <div class="row">
        <div class="col-md-4 offset-md-4 px-3">
            <div class="box b-a-0">
                <div class="p-2 text-xs-center">
                    <h5>@lang('admin.auth.reset_password')</h5>
                </div>
                <form class="form-material mb-1" role="form" method="POST" action="{{ url('/fleet/password/reset') }}" >
                
                {{ csrf_field() }}
                
                <input type="hidden" name="token" value="{{ $token }}">

                    <div class="form-group {{ $errors->has('email') ? ' has-error' : '' }}">
                        <input type="email" name="email" value="{{ $email or old('email') }}" autofocus required="true" class="form-control" id="email" placeholder="@lang('admin.email')">
                        @if ($errors->has('email'))
                            <span class="help-block">
                                <strong>{{ $errors->first('email') }}</strong>
                            </span>
                        @endif
                    </div>

                    <div class="form-group {{ $errors->has('password') ? ' has-error' : '' }}">
                        <input type="password" name="password" required="true" class="form-control" id="password" placeholder="@lang('admin.password')">
                        @if ($errors->has('password'))
                            <span class="help-block">
                                <strong>{{ $errors->first('password') }}</strong>
                            </span>
                        @endif
                    </div>

                    <div class="form-group {{ $errors->has('password_confirmation') ? ' has-error' : '' }}">
                        <input type="password" name="password_confirmation" required="true" class="form-control" id="password_confirmation" placeholder="@lang('admin.password')">
                        @if ($errors->has('password_confirmation'))
                            <span class="help-block">
                                <strong>{{ $errors->first('password_confirmation') }}</strong>
                            </span>
                        @endif
                    </div>

                    <div class="px-2 form-group mb-0">
                        <button type="submit" class="btn btn-purple btn-block text-uppercase">@lang('admin.auth.reset_password')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection