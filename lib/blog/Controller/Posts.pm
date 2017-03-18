package blog::Controller::Posts;
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

blog::Controller::Posts - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;
#
#    $c->response->body('Matched blog::Controller::Posts in Posts.');
#}

sub index :GET Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(posts => [$c->model('DB::Post')->all]);
}

# Get info on a specific item
# GET /posts/:post_id
sub show :GET Args(1) {
    my ( $self, $c, $post_id ) = @_;
    my $post = $c->model('DB::Post')->find($post_id);
    # In case of an error, call error action and abort
    $c->detach('error', [404, "No such gift: $post_id"]) if ! $post;

    # If we're here all went well, so fill the stash with our item
    $c->stash->{post} = $post;
}

sub create :GET :Path('create'){
    my ( $self, $c ) = @_;
    if ($c->user_exists)
    {

    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }
}
# Create a new item
# POST /posts
sub store :POST Args(0) {
    my ( $self, $c ) = @_;
    if ($c->user_exists)
    {
        my $post_data = $c->req->body_data;
        my $post = $c->model('DB::Post')->create($post_data);
        $c->detach('error', [400, "Invalid post data"]) if ! $post;
        # Location header is the route to the new item
        $c->flash->{status_msg} = "Post Created";
        $c->response->redirect($c->uri_for('/posts/'.$post->id));
    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }

}

sub edit :GET Args(1) :Path('edit'){
    my ( $self, $c, $post_id ) = @_;
    if ($c->user_exists)
    {
    my $post = $c->model('DB::Post')->find($post_id);
    # In case of an error, call error action and abort
    $c->detach('error', [404, "No such post: $post_id"]) if ! $post;

    # If we're here all went well, so fill the stash with our item
    $c->stash->{post} = $post;
    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }

}

# Update an existing item
# POST /posts/:post_id
sub update :PUT Args(1) {
    my ( $self, $c, $post_id ) = @_;
    if ($c->user_exists)
    {
        my $post_data = $c->req->body_data;
        my $post=$c->model('DB::Post')->find($post_id);
        my $ok = $post->update($post_data);
        $c->detach('error', [400, "Fail to update post: $post_id"]) if ! $ok;
        $c->flash->{status_msg} = "Post Updated";
        $c->response->redirect($c->uri_for('/posts/'.$post_id));
    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }
}

# Delete an item
# DELETE /posts/:post_id
sub delete :DELETE Args(1) {

    my ( $self, $c, $post_id ) = @_;
    if ($c->user_exists)
    {
        my $post = $c->model('DB::Post')->find($post_id);
        my $ok = $post->delete();
        $c->detach('error', [400, "Invalid post id: $post_id"]) if ! $ok;
        $c->flash->{status_msg} = "Post Deleted";
        $c->response->redirect($c->uri_for('/posts'));
    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }
}
sub comment :POST :Path('comment') Args(0) {
    my ( $self, $c ) = @_;
    if ($c->user_exists)
    {
        my $comment_data= $c->req->body_data;
        my $comment = $c->model('DB::Comment')->create($comment_data);
        $c->detach('error', [400, "Invalid comment data"]) if ! $comment;
        # Location header is the route to the new item
        $c->flash->{status_msg} = "Comment Created";
        $c->response->redirect($c->uri_for('/posts/'.$comment->post->id));
    }else{
        $c->flash->{error_msg} = "Please Login first";
        $c->response->redirect($c->uri_for('/login'));
    }

}
sub rmcomment :DELETE :Path('comment') Args(1) {
    my ( $self, $c, $comment_id ) = @_;
    if ($c->user_exists)
    {
        my $comment = $c->model('DB::Comment')->find($comment_id);
        my $post_id=$comment->pid;
        my $ok = $comment->delete();
        $c->detach('error', [400, "Invalid comment id: $comment_id"]) if ! $ok;
        $c->flash->{status_msg} = "Comment Deleted";
        $c->response->redirect($c->uri_for('/posts/'.$post_id));
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
