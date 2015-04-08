# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubyzip/rubyzip-1.1.6.ebuild,v 1.1 2014/10/28 18:10:09 graaff Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="Changelog.md README.md TODO"

inherit ruby-fakegem

DESCRIPTION="A ruby library for reading and writing zip files"
HOMEPAGE="https://github.com/rubyzip/rubyzip"
# Tests are not included in the gem.
SRC_URI="https://github.com/rubyzip/rubyzip/archive/v${PV}.tar.gz -> ${P}-git.tgz"

LICENSE="Ruby"
SLOT="1"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${DEPEND} test? ( app-arch/zip )"

ruby_add_bdepend "test? ( dev-ruby/minitest:0 )"

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc samples/*
}

all_ruby_prepare() {
	# Avoid dependencies on simplecov and coveralls
	sed -i -e '/simplecov/ s:^:#:' test/test_helper.rb || die

	# Avoid dependency on bundler
	sed -i -e '/bundler/ s:^:#:' Rakefile || die

	# rubyzip's tests will fail when run in random order, so require a
	# minitest version that still preserves ordering.
	sed -i -e '2igem "minitest", "~> 4.0"' test/test_helper.rb || die
}
