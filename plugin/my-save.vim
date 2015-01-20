if !has('perl')
	finish
endif
perl << EOF
use File::Basename;
use File::Path qw/make_path/;

sub my_save {
	$path = VIM::Eval('expand("%:p")');
	$path =~ s/\\/\//g;
	$cache_dir = VIM::Eval('g:my_save_cache_dir');
	$bak_dir = VIM::Eval('g:my_save_bak_dir');
	if ($path =~ /$cache_dir/) {
		$path =~ s/$cache_dir/$bak_dir/;
		$dir = dirname($path);
		make_path($dir);
		VIM::DoCommand(':w! ' . $path . '');
	}
}
EOF
function! MySave()
	perl my_save
endfunction

" vim: ts=4 sw=4 sts=0 noet
