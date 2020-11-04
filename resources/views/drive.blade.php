@extends('user.layout.app')

@section('content')
<div class="banner row no-margin" style="background-image: url('{{ asset('asset/img/banner-bg.jpg') }}');">
    <div class="banner-overlay"></div>
    <div class="container pad-60">
        <div class="col-md-8">
            <h2 class="banner-head"><span class="strong">Un travail qui vous donne le droit de</span><br>conduire quand vous voulez, faites comme bon vous semble</h2>
        </div>
        <div class="col-md-4">
            <div class="banner-form">
                <div class="row no-margin fields">
                    <div class="left">
                    	<img src="{{asset('asset/img/taxi-app.png')}}">
                    </div>
                    <div class="right">
                        <a href="{{url('login')}}">
                            <h3>Réserver sur {{config('constants.site_title','Tranxit')}}</h3>
                            <h5>S'INSCRIRE <i class="fa fa-chevron-right"></i></h5>
                        </a>
                    </div>
                </div>

                <div class="row no-margin fields">
                    <div class="left">
                    	<img src="{{asset('asset/img/taxi-app.png')}}">
                    </div>
                    <div class="right">
                        <a href="{{url('provider/login')}}">
                            <h3>S'identifier pour conduire</h3>
                            <h5>S'INSCRIRE <i class="fa fa-chevron-right"></i></h5>
                        </a>
                    </div>
                </div>

                <!-- <p class="note-or">Or <a href="{{ url('login') }}">sign in</a> with your rider account.</p> -->
            </div>
        </div>
    </div>
</div>

<div class="row white-section pad-60 no-margin">
    <div class="container">
        
        <div class="col-md-4 content-block small">
             <div class="box-shadow">
                <div class="icon"><img src="{{asset('asset/img/driving-license.png')}}"></div>
            <h2>Définissez votre propre horaire</h2>
            <div class="title-divider"></div>
            <p>Vous pouvez conduire avec {{ config('constants.site_title', 'Tranxit') }}  à tout moment, jour et nuit, 365 jours par an. Lorsque vous conduisez, c'est toujours à vous de voir, cela n'interfère donc jamais avec les choses importantes de votre vie.</p>
        </div>
    </div>

        <div class="col-md-4 content-block small">
             <div class="box-shadow">
                <div class="icon"><img src="{{asset('asset/img/destination.png')}}"></div>
            <h2>Faire plus à chaque trajet</h2>
            <div class="title-divider"></div>
            <p>Les tarifs commencent par un montant de base, puis augmentent avec le temps et la distance. Et lorsque la demande est supérieure à la normale, les conducteurs gagnent plus.</p>
        </div>
    </div>

        <div class="col-md-4 content-block small">
             <div class="box-shadow">
                <div class="icon"><img src="{{asset('asset/img/taxi-app.png')}}"></div>
            <h2>Laissez l'application ouvrir la voie</h2>
            <div class="title-divider"></div>
            <p>Acceptez une course et roulez. Vous obtiendrez des instructions pas à pas, des outils pour vous aider à gagner plus, et une assistance 24 heures sur 24, 7 jours sur 7, le tout disponible directement dans l'application.</p>
        </div>
    </div>

    </div>
</div>

<div class="row gray-section no-margin full-section">
    <div class="container">                
        <div class="col-md-6 content-block">
            <div class="icon"><img src="{{asset('asset/img/taxi-car.png')}}"></div>
            <h3>À propos de l'application</h3>
            <h2>Conçue juste pour les chauffeurs</h2>
            <div class="title-divider"></div>
            <p>Lorsque vous voulez gagner de l'argent, ouvrez simplement l'application et vous commencerez à recevoir des demandes de transport. Vous obtiendrez des informations sur votre passagers et des indications sur son emplacement et sa destination. Une fois le trajet terminé, vous recevrez une autre demande à proximité. Et si vous êtes prêt à quitter la route, vous pouvez vous déconnecter à tout moment </p>
            <a class="content-more more-btn" href="{{url('login')}}">EN SAVOIR PLUS <i class="fa fa-chevron-right"></i></a>
        </div>
        <div class="col-md-6 full-img text-center" style="background-image: url({{ asset('asset/img/driver-car.jpg') }});"> 
            <!-- <img src="img/anywhere.png"> -->
        </div>
    </div>
</div>

<div class="row white-section pad-60 no-margin">
    <div class="container">
        
        <div class="col-md-4 content-block small">
            <div class="box-shadow">
                <div class="icon"><img src="{{asset('asset/img/budget.png')}}"></div>
            <h2>Récompenses</h2>
            <div class="title-divider"></div>
            <p>Vous êtes dans l'équipe ONLY VTC. Alors, nous vous aiderons avec des réductions sur le carburant, la maintenance du véhicule, les factures de téléphone portable, etc. Réduisez vos dépenses quotidiennes et rapportez plus d'argent à la maison. (Service à venir...)</p>
        </div></div>

        <div class="col-md-4 content-block small">
            <div class="box-shadow">
                <div class="icon"><img src="{{asset('asset/img/driving-license.png')}}"></div>
            <h2>Exigences</h2>
            <div class="title-divider"></div>
            <p>Vous devez être prêt à prendre la route. Que vous conduisiez votre propre voiture ou un véhicule de location, vous devez respecter les exigences minimales et remplir une enquête de sécurité en ligne.</p>
        </div></div>

        <div class="col-md-4 content-block small">
            <div class="box-shadow">
                <div class="icon"><img src="{{asset('asset/img/seat-belt.png')}}"></div>
            <h2>Sécurité</h2>
            <div class="title-divider"></div>
            <p>Lorsque vous conduisez avec {{ config('constants.site_title', 'Tranxit') }}, vous bénéficiez d'une assistance et d'une couverture d'assurance 24/7. Et tous les passagers sont vérifiés avec leurs informations personnelles et leur numéro de téléphone, vous saurez ainsi qui aller chercher.</p>
        </div></div>

    </div>
</div>
            
<div class="row find-city no-margin">
    <div class="container">
        <div class="col-md-12 center content-block">
            <div class="box-shadow">
                <div class="pad-60 ">
        <h2>Commencez à gagner de l'argent</h2>
        <p>Prêt à gagner de l'argent? La première étape consiste à s'inscrire en ligne.</p>
<a class="content-more more-btn" href="{{url('login')}}">COMMENCEZ MAINTENANT  <i class="fa fa-chevron-right"></i></a>
        <!-- <button type="submit" class="full-primary-btn drive-btn">START DRIVE NOW</button> -->
    </div>
</div>
</div>
    </div>
</div>

<!-- <div class="footer-city row no-margin" style="background-image: url({{ asset('asset/img/footer-city.png') }});"></div> -->
@endsection