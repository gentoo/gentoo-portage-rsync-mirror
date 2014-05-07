# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-prof/ruby-prof-0.12.2.ebuild,v 1.2 2014/05/07 19:09:28 mrueg Exp $

EAPI=5

# jruby → not compatible, since it uses an extension, but there is a bug
# open for it: https://github.com/rdp/ruby-prof/issues/36

USE_RUBY="ruby19"

RUBY_FAKEGEM_EXTRADOC="README.rdoc CHANGES"
RUBY_FAKEGEM_DOCDIR="doc"

inherit multilib ruby-fakegem

DESCRIPTION="A module for profiling Ruby code"
HOMEPAGE="https://github.com/ruby-prof/ruby-prof"
SRC_URI="https://github.com/ruby-prof/${PN}/archive/v${PV}.tar.gz -> ${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

all_ruby_prepare() {
	# The thread testing in 0.8.1 and earlier versions is broken, it
	# has to be tested for the next versions, since upstream is
	# looking for a solution. The problem is that it's _very_
	# timing-dependent.
	rm "${S}"/test/thread_test.rb \
		|| die "unable to remove broken test unit"
	sed -i -e '/thread_test/d' \
		test/test_suite.rb || die "unable to remove broken test reference"

	# We install the shared object in lib, not ext.
	sed -i -e 's#../ext/ruby_prof#../lib/ruby_prof#' lib/ruby-prof.rb

	# Create directory required for the test suite to pass
	mkdir tmp || die
}

each_ruby_configure() {
	${RUBY} -Cext/ruby_prof extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -Cext/ruby_prof || die "build failed"

	mkdir lib/ruby_prof || die "unable to create directory for shared object"
	cp ext/ruby_prof/*$(get_modname) lib/ruby_prof || die "copy of extension failed"
}

each_ruby_test() {
	${RUBY} test/test_suite.rb || die
}

all_ruby_install() {
	all_fakegem_install

	for dir in examples ; do
		docinto "$dir"
		dodoc -r "$dir"/*
	done
}
