<div class="sidebar-admin col-lg-3 col-md-3 col-sm-12">
    <div class="logo-admin-area">
        <div class="cross-mobile"><i class="fa fa-times" aria-hidden="true"></i></div>
        <div class="mobile-welcome">
            <div class="msr-wrapc">
                <div class="msg-img">
                    <img src="{{ config('constants.site_logo', asset('logo-black.png')) }}" class="img-fluid rounded-circle" />
                </div>
                <div class="msg-welcome"><span>@lang('admin.dashboard.Wlc')</span><br></div>
            </div>
        </div>
        <img style="margin-top:30px; margin-bottom:30px;" src="{{ config('constants.site_logo', asset('logo-black.png')) }}" class="img-fluid" />

    </div><!-- logo-admin-area -->
    <div class="admin-nav-area">
        <ul class="list-unstyled" style="outline: none;" tabindex="0">
            <li class="menu-title">@lang('admin.include.fleet_dashboard')</li>
            <li>
                <a href="{{ route('fleet.dashboard') }}">
                    <span class="s-icon"><i class="ti-anchor" aria-hidden="true"></i></span>
                    @lang('admin.include.dashboard')<i class="fa fa-chevron-right"></i>
                </a>
            </li>

			<li class="menu-title">@lang('admin.include.members')</li>
            <li class="">
                <a href="#" data-toggle="collapse" data-target="#member-list11">
                    <span class="s-icon"><i class="ti-car" aria-hidden="true"></i></span>
                    @lang('admin.include.members')<i class="fa fa-plus" aria-hidden="true"></i>
                </a>
                <ul id="member-list11" class="collapse">
                    <li><a href="{{ route('fleet.provider.index') }}">@lang('admin.include.list_providers')<i class="fa fa-chevron-right"></i></a></li>
                    <li><a href="{{ route('fleet.provider.create') }}">@lang('admin.include.add_new_provider')<i class="fa fa-chevron-right"></i></a></li>
                </ul>
            </li>

            <li class="menu-title">@lang('admin.include.details')</li>
            <li>
                <a href="{{ route('fleet.map.index') }}">
                    <span class="s-icon"><i class="ti-map-alt" aria-hidden="true"></i></span>
                    @lang('admin.include.map')<i class="fa fa-chevron-right"></i>
                </a>
            </li>
            <li class="">
                <a href="#" data-toggle="collapse" data-target="#rating-reviews-list11">
                    <span class="s-icon"><i class="ti-view-grid" aria-hidden="true"></i></span>
                    @lang('admin.include.ratings') &amp; @lang('admin.include.reviews')<i class="fa fa-plus" aria-hidden="true"></i>
                </a>
                <ul id="rating-reviews-list11" class="collapse">
                    <li><a href="{{ route('fleet.provider.review') }}">@lang('admin.include.provider_ratings')<i class="fa fa-chevron-right"></i></a></li>
                </ul>
            </li>
			<li class="menu-title">@lang('admin.include.requests')</li>
            <li>
                <a href="{{ route('fleet.requests.index') }}">
                    <span class="s-icon"><i class="ti-infinite" aria-hidden="true"></i></span>
                    @lang('admin.include.request_history')<i class="fa fa-chevron-right"></i>
                </a>
            </li>
            <li>
                <a href="{{ route('fleet.requests.scheduled') }}">
                    <span class="s-icon"><i class="ti-palette" aria-hidden="true"></i></span>
                    @lang('admin.include.scheduled_rides')<i class="fa fa-chevron-right"></i>
                </a>
            </li>
			<li class="menu-title">@lang('admin.include.transaction')</li>
            <li>

                <a href="{{ route('fleet.ride.statement') }}">
                    <span class="s-icon"><i class="ti-money" aria-hidden="true"></i></span>
                    @lang('admin.Statements')<i class="fa fa-chevron-right"></i>
                </a>
            </li>
            <li>
                <a href="{{ route('fleet.wallet') }}">
                    <span class="s-icon"><i class="ti-money" aria-hidden="true"></i></span>
                    @lang('admin.include.wallet')<i class="fa fa-chevron-right"></i>
                </a>
            </li>
			@if(config('constants.card')==1)
            <li>
                <a href="{{ route('fleet.cards') }}">
                    <span class="s-icon"><i class="ti-exchange-vertical" aria-hidden="true"></i></span>
                    @lang('admin.include.debit_card')<i class="fa fa-chevron-right"></i>
                </a>
            </li>
            @endif
            <li>
                <a href="{{ route('fleet.transfer') }}">
                    <span class="s-icon"><i class="ti-exchange-vertical" aria-hidden="true"></i></span>
                    @lang('admin.include.transfer')<i class="fa fa-chevron-right"></i>
                </a>
            </li>

			<li class="menu-title">@lang('admin.include.account')</li>
            <li>
                <a href="{{ route('fleet.profile') }}">
                    <span class="s-icon"><i class="ti-user" aria-hidden="true"></i></span>
                    @lang('admin.include.account_settings')<i class="fa fa-chevron-right"></i>
                </a>
            </li>
            <li>
                <a href="{{ route('fleet.password') }}">
                    <span class="s-icon"><i class="ti-exchange-vertical" aria-hidden="true"></i></span>
                    @lang('admin.include.change_password')<i class="fa fa-chevron-right"></i>
                </a>
            </li>
            <li>
                <a href="{{ url('/logout') }}" onclick="event.preventDefault();document.getElementById('logout-form').submit();">
                    <span class="s-icon"><i class="ti-power-off" aria-hidden="true"></i></span>
                    @lang('admin.include.logout')<i class="fa fa-chevron-right"></i>
                </a>
            </li>

            <form id="logout-form" action="{{ url('/logout') }}" method="POST" style="display: none;">
                {{ csrf_field() }}
            </form>

        </ul>

        <p class="copyright">{{ config('constants.site_copyright', '&copy; '.date('Y').' Appoets') }}</p>

    </div>
</div>
