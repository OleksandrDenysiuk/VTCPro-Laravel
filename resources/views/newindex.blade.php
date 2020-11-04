@extends('user.layout.app')

@section('content')
<!-- <div class="banner row no-margin" style="background-image: url('{{ asset('asset/img/banner-bg.jpg') }}');">
    <div class="banner-overlay"></div>
    <div class="container">
        <div class="col-md-8">
            <h2 class="banner-head"><span class="strong">Get there</span><br>Your day belongs to you</h2>
        </div>
        <div class="col-md-4">
            <div class="banner-form">
                <div class="row no-margin fields">
                    <div class="left">
                        <img src="{{ asset('asset/img/ride-form-icon.png') }}">
                    </div>
                    <div class="right">
                        <a href="{{url('login')}}">
                            <h3>Sign up to Ride</h3>
                            <h5>SIGN UP <i class="fa fa-chevron-right"></i></h5>
                        </a>
                    </div>
                </div>
                <div class="row no-margin fields">
                    <div class="left">
                        <img src="{{ asset('asset/img/ride-form-icon.png') }}">
                    </div>
                    <div class="right">
                        <a href="{{ url('/provider/register') }}">
                            <h3>Sign up to Drive</h3>
                            <h5>SIGN UP <i class="fa fa-chevron-right"></i></h5>
                        </a>
                    </div>
                </div>
                <p class="note-or">Or <a href="{{ url('/provider/login') }}">sign in</a> with your rider account.</p>
            </div>
        </div>
    </div>
</div> -->
<div class="banner row no-margin" style="background-position: center; background-image: url('{{ asset('asset/img/slider-bg-1.jpg') }}');">
    <div class="banner-overlay"></div>
    <div class="container slider pad-60">
        <div class="row">
        <div class="col-md-12 center ">

            <h2 class="banner-head">Allons-y <br>La route est à vous</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-md-3 col-md-offset-3">
             <div class="row no-margin fields banner-ride-drive">
                    <div class="btn-icon">
                        <img src="{{ asset('asset/img/destination.png') }}">
                    </div>
                    <div class="btn-txt">
                        <a href="{{url('login')}}">
                            <h3 class="btn-title">Réservez</h3>
                            <!-- <h5>SIGN UP <i class="fa fa-chevron-right"></i></h5> -->
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
             <div class="row no-margin fields banner-ride-drive">
                    <div class="left">
                        <img src="{{ asset('asset/img/taxi-car.png') }}">
                    </div>
                    <div class="right">
                        <a href="{{ url('/provider/login') }}">
                            <h3 class="btn-title">Conduire</h3>
                            <!-- <h5>SIGN UP <i class="fa fa-chevron-right"></i></h5> -->
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- <div class="col-md-4">
            <div class="banner-form">
                <div class="row no-margin fields">
                    <div class="left">
                        <img src="{{ asset('asset/img/ride-form-icon.png') }}">
                    </div>
                    <div class="right">
                        <a href="{{url('login')}}">
                            <h3>Sign up to Ride</h3>
                            <h5>SIGN UP <i class="fa fa-chevron-right"></i></h5>
                        </a>
                    </div>
                </div>
                <div class="row no-margin fields">
                    <div class="left">
                        <img src="{{ asset('asset/img/ride-form-icon.png') }}">
                    </div>
                    <div class="right">
                        <a href="{{ url('/provider/register') }}">
                            <h3>Sign up to Drive</h3>
                            <h5>SIGN UP <i class="fa fa-chevron-right"></i></h5>
                        </a>
                    </div>
                </div>
                <p class="note-or">Or <a href="{{ url('/provider/login') }}">sign in</a> with your rider account.</p>
            </div>
        </div> -->
    </div>
</div>
<div class="row white-section pad-60">
    <div class="container">
        <div class="col-md-6 img-box text-center"> 
            <img src="{{ asset('asset/img/screen-bg.png') }}">
        </div>
        <div class="col-md-6">
             <div class="content-block">
              <div class="icon"><img src="{{ asset('asset/img/taxi-app.png') }}"></div>
            <h2>Commandez votre VTC d'un geste</h2>
            <div class="title-divider"></div>
            <p>{{ config('constants.site_title', 'Tranxit')  }} ONLY VTC est le moyen le plus intelligent de se déplacer. En un geste, une voiture vient directement à vous. Votre chauffeur sait exactement où aller. Et vous pouvez payer en espèces ou par carte.</p>
            <a class="content-more more-btn" href="{{url('/ride')}}">EN SAVOIR PLUS <i class="fa fa-chevron-right"></i></a>
        </div>
    </div>
    </div>
</div>

<div class="row gray-section pad-60">
    <div class="container">                
        <div class="col-md-6">
            <div class="content-block">
            <div class="icon"><img src="{{ asset('asset/img/destination.png') }}"></div>
            <h2>Partout, tout le temps</h2>
            <div class="title-divider"></div>
            <p>Des déplacements quotidiens, une visite de la ville, un vol tôt le matin, un verre tard la nuit. Où que vous alliez, comptez sur {{ config('constants.site_title', 'Tranxit') }} pour vous accompagner.</p>
            <a class="content-more more-btn" href="{{url('/ride')}}">EN SAVOIR PLUS <i class="fa fa-chevron-right"></i></a>
        </div>
    </div>
        <div class="col-md-6 img-box text-center"> 
            <img src="{{ asset('asset/img/screen-bg-3.png') }}">
        </div>
    </div>
</div>

<div class="row white-section pad-60">
    <div class="container">
        <div class="col-md-6 img-box text-center"> 
            <img src="{{ asset('asset/img/screen-bg-4.png') }}">
        </div>
        <div class="col-md-6 content-block">
              <div class="icon"><img src="{{ asset('asset/img/budget.png') }}"></div>
            <h2>Du standard au Premium</h2>
            <div class="title-divider"></div>
            <p>ONLY VTC propose plusieurs gammes de véhicules. Vous voulez un tarif économique ? La gamme standard est faite pour vous. Mais parfois, vous avez besoin d'un peu plus d'espace. Choisissez dans ce cas la gamme Van. Vous serez aussi émerveillés avec notre gamme Premium avec les voitures les plus incroyables qui soient. Vous l'aurez compris, avec {{ config('constants.site_title', 'Tranxit') }}, vous avez le choix.</p>
            <a class="content-more more-btn" href="{{url('/ride')}}">EN SAVOIR PLUS <i class="fa fa-chevron-right"></i></a>
        </div>
    </div>
</div>

<div class="row gray-section pad-60 full-section">
    <div class="container">                
        <div class="col-md-6 content-block">
              <div class="icon"><img src="{{ asset('asset/img/car-wheel.png') }}"></div>
            <h5>Au volant</h5>
            <h2>Ce sont des personnes comme vous qui font votre chemin</h2>
            <div class="title-divider"></div>
            <p>Ce qui rend l'expérience {{ config('constants.site_title', 'Tranxit') }} vraiment exceptionnelle, ce sont les personnes au volant. Ils sont mères et pères. Etudiants et professeurs. Voisins. Copains. Nos partenaires conduisent leurs propres voitures, à leur propre rythme, dans les grandes et les petites villes. C’est pourquoi les moments passés avec eux sont d'aussi belles rencontres.</p>
            <a class="content-more more-btn" href="{{ url('/drive') }}">{{ config('constants.site_title', 'Tranxit')  }} <i class="fa fa-chevron-right"></i></a>
        </div>
        <div class="col-md-6 full-img text-center" style="background-image: url({{ asset('asset/img/behind-the-wheel.jpg') }});"> 
            <!-- <img src="img/anywhere.png"> -->
        </div>
    </div>
</div>

<div class="row white-section pad-60 ">
    <div class="container">
        <div class="col-md-6 img-box text-center"> 
            <img src="{{ asset('asset/img/cost-cities.png') }}">
        </div>
        <div class="col-md-6 content-block">
              <div class="icon"><img src="{{ asset('asset/img/taxi-location.png') }}"></div>
            <h2>Aider les villes pour le bien de tous</h2>
            <div class="title-divider"></div>
            <p>Une ville avec  {{ config('constants.site_title', 'Tranxit') }} offre plus de possibilités économiques aux résidents, moins de conducteurs en état d'ébriété dans les rues et un meilleur accès au transport pour ceux qui n'en ont pas.</p>
            <a class="content-more more-btn" href="{{ url('/login') }}">NOTRE IMPACT LOCAL <i class="fa fa-chevron-right"></i></a>
        </div>
    </div>
</div>

<div class="row gray-section pad-60 full-section">
    <div class="container">
        <div class="col-md-6 content-block">
              <div class="icon"><img src="{{ asset('asset/img/seat-belt.png') }}"></div>
            <h2>La sécurité avant tout</h2>
            <div class="title-divider"></div>
            <p>Que ce soit à l'arrière ou à l'avant, chaque élément de l'expérience {{ config('constants.site_title', 'Tranxit') }} a été conçu autour de votre sécurité..</p>
            <a class="content-more more-btn" href="{{ url('/login') }}">COMMENT NOUS GARANTISSONS VOTRE SÉCURITÉ <i class="fa fa-chevron-right"></i></a>
        </div>
        <!-- <div class="col-md-6 img-box text-center"> 
            <img src="{{ asset('asset/img/seat-belt.jpg') }}">
        </div> -->
        <div class="col-md-6 full-img text-center" style="background-image: url({{ asset('asset/img/safty-bg.jpg') }});"> 
            <!-- <img src="img/anywhere.png"> -->
        </div>
    </div>
</div>
<div class="row find-city">
    <div class="container pad-60 content-block center">
        <h2>{{ config('constants.site_title','Tranxit') }} est dans votre ville</h2>
        <div class="row">
            <div class="col-md-8 col-md-offset-2">
        <form>
            <div class="input-group find-form">
                <input type="text" class="form-control" placeholder="Recherche" id="origin-input">
                <div id="map" style="display: none;"></div>
                <span class="input-group-addon">
                    <button type="button" data-toggle="modal" data-target="#myModal">
                        <i class="fa fa-2x fa-arrow-right"></i>
                    </button>  
                </span>
            </div>           
        </form>
    </div>
</div>
    </div>
</div>
<!-- <div class="row app-dwon pad-60">
    <div class="container pad-60"">
        <div class="row center">
            <h2>Get App on</h2>
            <div class="col-md-3 col-md-offset-3">
                 
             <a href="{{config('constants.store_link_ios','#')}}">
            <img src="{{asset('asset/img/appstore.png')}}">
                                        </a>
            </div>
            <div class="col-md-3">
             <a href="{{config('constants.store_link_android','#')}}">
                                            <img src="{{asset('asset/img/playstore.png')}}">
                                        </a>
                                    </div>
        </div>
    </div>
</div>

    <div class="container footer-social content-block pad-60"">
        <div class="row center">
            <h2>Get Connect with Scoical Media</h2>
            <div class="col-md-6 col-md-offset-3">
                 <div class="socil-media">
                   <ul>
                                    <li><a href="#"><i class="fa fa-2x fa-facebook"></i></a></li>
                                    <li><a href="#"><i class="fa fa-2x fa-twitter"></i></a></li>
                                </ul>
                 </div>
             </div>
    </div>
</div> -->



<!-- <div class="footer-city row no-margin" style="background-image: url({{ asset('asset/img/footer-city.png') }});"></div> -->
@endsection