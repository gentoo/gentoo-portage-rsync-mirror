# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-prof/ruby-prof-0.15.1.ebuild,v 1.1 2014/05/10 06:38:42 graaff Exp $

EAPI=5

# jruby → not compatible, since it uses an extension, but there is a bug
# open for it: https://github.com/rdp/ruby-prof/issues/36

USE_RUBY="ruby19 ruby20 ruby21"

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

ruby_add_bdepend "test? ( dev-ruby/test-unit:2 dev-ruby/minitest )"

all_ruby_prepare() {
	# Avoid bundler
	sed -i -e '/bundler/I s:^:#:' -e '/:build/ s:^:#:' Rakefile || die

	sed -i -e '2igem "test-unit"' test/test_helper.rb || die

	# Fix a timing-dependant spec since its thresholds for success are
	# too tight.
	sed -i -e '/test_class_methods/,/^  end/ s:^:#:' test/measure_cpu_time_test.rb || die

	# We install the shared object in lib, not ext.
	sed -i -e 's#../ext/ruby_prof#../lib/ruby_prof#' lib/ruby-prof.rb

	# Create directory required for the test suite to pass
	mkdir tmp || die
}

each_ruby_configure() {
	${RUBY} -Cext/ruby_prof extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake V=1 -Cext/ruby_prof || die "build failed"

	mkdir lib/ruby_prof || die "unable to create directory for shared object"
	cp ext/ruby_prof/*$(get_modname) lib/ruby_prof || die "copy of extension failed"
}

all_ruby_install() {
	all_fakegem_install

	for dir in examples ; do
		docinto "$dir"
		dodoc -r "$dir"/*
	done
}
