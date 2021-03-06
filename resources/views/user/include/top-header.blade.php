<div class="row message-tbar">
    <div class="col-lg-9 col-md-8 msg-lft">
        <div class="mobile-menu"><i class="fa fa-bars" aria-hidden="true"></i>
            <img src="{{ config('constants.site_logo', asset('logo-black.png')) }}" class="img-fluid">
        </div>
        <div class="msg-date">@php date_default_timezone_set('Europe/paris'); $date = date('l j F, Y', time()); echo $date; @endphp</div>
{{--        <div class="msg-date">@php $dt = new DateTime(); echo $dt->format('l j F, Y');@endphp</div>--}}
        <div class="msg-icons">
            <div class="msg-icon-img">
                <i class="fa fa-envelope-o" aria-hidden="true"></i>
                @php
                $notifications = App\Notifications::where([['notify_type','!=','provider'],['status','active']])
                        ->orderBy('created_at' , 'desc')
                        ->get();
                $wallet = Auth::user()->wallet_balance;
                @endphp
                <span>{{count($notifications)}}</span>
                <div class="msg-menu">
                    <div class="msg-menuww">
                        <i class="fa fa-caret-up"></i>
                        <h4>notifications</h4>
                        <div class="unread-scroll" style="overflow: hidden; outline: none;" tabindex="1">
                            <ul>
                                @foreach($notifications as $index => $notify)
                                <li>  <img src="{{$notify->image}}" style="margin-left:5px;"width="40" height="40">  {{ str_limit($notify->description, $limit = 50, $end = '...') }}</li>
                                @endforeach
                            </ul>
                        </div>
                    </div>
                    <div id="ascrail2001" class="nicescroll-rails nicescroll-rails-vr" style="width: 7px; z-index: 100; position: absolute; top: 0px; left: -7px; height: 0px; opacity: 0.6; touch-action: none; cursor: default; display: none;">
                        <div class="nicescroll-cursors" style="position: relative; top: 0px; float: right; width: 5px; height: 0px; background-color: rgb(47, 46, 46); border: 1px solid rgb(255, 255, 255); background-clip: padding-box; border-radius: 5px; touch-action: none;"></div>
                    </div>
                    <div id="ascrail2001-hr" class="nicescroll-rails nicescroll-rails-hr" style="height: 7px; z-index: 100; top: -7px; left: 0px; position: absolute; opacity: 0.6; cursor: default; display: none;">
                        <div class="nicescroll-cursors" style="position: absolute; top: 0px; height: 5px; width: 0px; background-color: rgb(47, 46, 46); border: 1px solid rgb(255, 255, 255); background-clip: padding-box; border-radius: 5px;"></div>
                    </div>
                </div>
            </div>
            <div class="msg-icon-price" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Total Earnings" style="@if($wallet <= 0) color:red; @endif" >@if($wallet == 0)-@endif{{number_format($wallet, 2, '.', '').config('constants.currency')}}</div>
        </div>
    </div>
    <div class="mobile-mils"  style="@if($wallet <= 0) color:red; @endif">Dues Payable: @if($wallet == 0)-@endif{{number_format($wallet, 2, '.', '').config('constants.currency')}}</div>
    <div class="col-lg-3 col-md-4 msg-rt">
        <div class="msr-wrapc">
            <div class="msg-welcome"><span>WELCOME</span><br>{{Auth::user()->first_name}} {{Auth::user()->last_name}}</div>
            <div class="msg-img">
                <?php $profile_image = img(Auth::user()->picture); ?>
                <img src="{{$profile_image}}" class="img-fluid rounded-circle">
                <i class="fa fa-caret-down"></i></div>
            <div class="logout-menu">
                <div class="logout-menuwrap">
                    <i class="fa fa-caret-up"></i>
                    <ul>
                        <li><a href="{{ url('profile') }}"><i class="fa fa-user" aria-hidden="true"></i>@lang('admin.include.profile')</a></li>
                        <li><a href="{{ url('/logout') }}" onclick="event.preventDefault(); document.getElementById('logout-form').submit();"><i class="fa fa-sign-out" aria-hidden="true"></i>@lang('admin.include.sign_out')</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
