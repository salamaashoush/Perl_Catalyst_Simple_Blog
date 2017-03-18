package blog::Controller::Users;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }
__PACKAGE__->config(
    action => {
        '*' => {
            Path => '',
        }
    }
);
=head1 NAME

blog::Controller::Users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :GET Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(users => [$c->model('DB::User')->all]);
}

# Get info on a specific item
# GET /users/:user_id
sub show :GET Args(1) {
    my ( $self, $c, $user_id ) = @_;
    my $user = $c->model('DB::User')->find($user_id);
    # In case of an error, call error action and abort
    $c->detach('error', [404, "No such User: $user_id"]) if ! $user;

    # If we're here all went well, so fill the stash with our item
    $c->stash->{user} = $user;
}

sub create :GET :Path('create'){
    my ( $self, $c ) = @_;
    if (!$c->user_exists)
    {
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));

    }else{
        if(!$c->user->role=='admin'){
            $c->flash->{error_msg} = "you are not allowed to do this";
            $c->response->redirect($c->uri_for('/users'));
        }
    }
}
# Create a new item
# POST /users
sub store :POST Args(0) {
    my ( $self, $c ) = @_;
    if ($c->user_exists)
    {
        if(!$c->user->role=='admin'){
            $c->flash->{error_msg} = "you are not allowed to do this";
            $c->response->redirect($c->uri_for('/users'));
        }
        my $user_data = $c->req->body_data;
        my $user = $c->model('DB::User')->create($user_data);
        $c->detach('error', [400, "Invalid user data"]) if ! $user;
        # Location header is the route to the new item
        $c->flash->{status_msg} = "user Created";
        $c->response->redirect($c->uri_for('/users/'.$user->id));
    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }

}

sub edit :GET Args(1) :Path('edit'){
    my ( $self, $c, $user_id ) = @_;
    if ($c->user_exists)
    {
        if($c->user->role=='admin'||$c->user->id==$user_id){
            my $user = $c->model('DB::User')->find($user_id);
            # In case of an error, call error action and abort
            $c->detach('error', [404, "No such user: $user_id"]) if ! $user;

            # If we're here all went well, so fill the stash with our item
            $c->stash->{user} = $user;

        }else{
            $c->flash->{error_msg} = "you are not allowed to do this";
            $c->response->redirect($c->uri_for('/users'));
        }

    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }

}

# Update an existing item
# POST /users/:user_id
sub update :PUT Args(1) {
    my ( $self, $c, $user_id ) = @_;
    if ($c->user_exists)
    {
        if(!$c->user->role=='admin'||!$c->user->id==$user_id){
            $c->flash->{error_msg} = "you are not allowed to do this";
            $c->response->redirect($c->uri_for('/users'));
        }
        my $user_data = $c->req->body_data;
        my $user=$c->model('DB::User')->find($user_id);
        my $ok = $user->update($user_data);
        $c->detach('error', [400, "Fail to update user: $user_id"]) if ! $ok;
        $c->flash->{status_msg} = "User Updated";
        $c->response->redirect($c->uri_for('/users/'.$user_id));
    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }
}

# Delete an item
# DELETE /users/:user_id
sub delete :DELETE Args(1) {

    my ( $self, $c, $user_id ) = @_;
    if ($c->user_exists)
    {
        if(!$c->user->role=='admin'){
            $c->flash->{error_msg} = "you are not allowed to do this";
            $c->response->redirect($c->uri_for('/users'));
        }
        my $user = $c->model('DB::User')->find($user_id);
        my $ok = $user->delete();
        $c->detach('error', [400, "Invalid user id: $user_id"]) if ! $ok;
        $c->flash->{status_msg} = "User Deleted";
        $c->response->redirect($c->uri_for('/users'));
    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }
}

sub error :Private{
    my ( $self, $c,$error) = @_;
    $c->stash('template'=>'error.tt2');
    $c->stash('error'=>$error);

}


=encoding utf8

=head1 AUTHOR

salamaashoush,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
