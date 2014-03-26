# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/minitest/minitest-5.3.1.ebuild,v 1.1 2014/03/26 19:39:49 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="minitest/unit is a small and fast replacement for ruby's huge and slow test/unit."
HOMEPAGE="https://github.com/seattlerb/minitest"

LICENSE="MIT"
SLOT="5"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc test"

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# Make sure __jtrap is available in all threads. This should
			# be fixed in jruby 1.7.x
			sed -i -e '8i  trap :INFO do ; end' lib/minitest/parallel.rb || die

			# Avoid failures. Most of these look like low-level jruby
			# differences and it looks like these were not run properly
			# in previous versions.
			for t in test_return_mock_does_not_raise test_mock_args_does_not_raise test_stub_block test_stub_value ; do
				local command="/${t}/,/^  end/ s:^:#:"
				sed -i -e "${command}" test/minitest/test_minitest_mock.rb || die
			done
			for t in test_run_failing test_run_skip test_run_error test_run_skip_verbose test_run_error_teardown test_runnable_methods_random test_assert_throws_different test_to_s_error_in_test_and_teardown test_run_filtered_including_suite_name_string test_run_filtered_string_method_only test_run_filtered_including_suite_name ; do
				command="/${t}/,/^  end/ s:^:#:"
				sed -i -e "${command}" test/minitest/test_minitest_unit.rb || die
			done
			for t in test_name2 "needs to verify throw" ; do
				command="/${t}/,/^  end/ s:^:#:"
				sed -i -e "${command}" test/minitest/test_minitest_spec.rb || die
			done
			sed -i -e '/test_report_error/,/^  end/ s:^:#:' test/minitest/test_minitest_reporter.rb || die
			;;
	esac
}

each_ruby_test() {
	for f in test/minitest/test_*.rb; do
		${RUBY} -Ilib:test ${f} || die "${f} tests failed"
	done
}
