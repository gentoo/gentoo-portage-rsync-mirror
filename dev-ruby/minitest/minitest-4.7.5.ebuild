# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/minitest/minitest-4.7.5.ebuild,v 1.6 2014/06/08 16:48:37 hattya Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt Manifest.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="minitest/unit is a small and fast replacement for ruby's huge and slow test/unit."
HOMEPAGE="https://github.com/seattlerb/minitest"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc test"

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# Remove failing tests. Upstream claims that these are all
			# bugs in jruby. By removing the failing tests we can at
			# least run the remainder. See bug 321055 for details.
			rm -f test/minitest/test_minitest_unit.rb || die
			# Also add minitest_mock since there are jruby-specific failures.
			rm -f test/minitest/test_minitest_mock.rb || die

			# Our jruby throws a slightly different error
			sed -i -e 's/not :xxx/not \\"xxx\\"/' test/minitest/test_minitest_spec.rb || die
				;;
		*)
				;;
	esac
}

each_ruby_test() {
	case ${RUBY} in
		*jruby)
			# JRuby 1.6.x has threading bugs that are triggered by
			# minitests 4's new parallel test support. Should be fixed
			# in JRuby 1.7.
			N=1 ${RUBY} -Ilib:bin:test:. -S testrb test || die
				;;
		*)
			${RUBY} -Ilib:bin:test:. -S testrb test || die
				;;
	esac
}
