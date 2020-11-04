 <div class="row">
    <div class="col-md-6 page_info">
        @lang('admin.custom.Showing') {{($pagination->currentPage-1)*$pagination->perPage+1}} @lang('admin.custom.Showing_to') {{$pagination->currentPage*$pagination->perPage}}
        @lang('admin.custom.Showing_of')  {{$pagination->total}} @lang('admin.custom.Showing_entries')                    
    </div>
    <div class="col-md-6 pagination_cover">
        {{ $pagination->links}}
    </div>
</div>