use utf8;
package Blog::Schema::Result::Comment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Blog::Schema::Result::Comment

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<comments>

=cut

__PACKAGE__->table("comments");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 pid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 uid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 content

  data_type: 'longtext'
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=head2 updated_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "pid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "uid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "content",
  { data_type => "longtext", is_nullable => 1 },
  "created_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
  "updated_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 pid

Type: belongs_to

Related object: L<Blog::Schema::Result::Post>

=cut

__PACKAGE__->belongs_to(
  "post",
  "Blog::Schema::Result::Post",
  { id => "pid" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 uid

Type: belongs_to

Related object: L<Blog::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Blog::Schema::Result::User",
  { id => "uid" },
  { is_deferrable => 1, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-03-14 10:52:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sd3H4gcSvCm8jqVewyTEcg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
