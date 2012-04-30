package Homyaki::Task_Manager::Task::Auto_Rename;

use strict;

use File::stat;

use Homyaki::Task_Manager::DB::Task;
use Homyaki::Task_Manager::DB::Constants;

use Homyaki::Gallery::Group_Processing;

use Homyaki::Logger;

use constant BASE_IMAGE_PATH  => '/home/alex/Share/Photo/';

sub start {
	my $class = shift;
	my %h = @_;
	
	my $params = $h{params};
	my $task   = $h{task};

	my $result = {};

	my $update_date = stat(&BASE_IMAGE_PATH)->mtime();
	
	if ($params->{update_date} != $update_date) {

		Homyaki::Gallery::Group_Processing->process(
			handler => 'Homyaki::Processor::Gallery_Unic_Name',
			params  => {
				images_path   => &BASE_IMAGE_PATH,
			},
		);

		$params->{update_date} = $update_date;
	}

	$result->{task} = {
		retry => {
			minutes => 1,
		},
		params => $params,
	};

	return $result;
}

1;

