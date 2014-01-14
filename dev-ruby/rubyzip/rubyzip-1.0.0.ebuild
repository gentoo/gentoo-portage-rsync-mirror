# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubyzip/rubyzip-1.0.0.ebuild,v 1.4 2014/01/14 08:57:11 graaff Exp $

EAPI=5

# jruby → adding zip files to the load path fails, badly
USE_RUBY="ruby18 ruby19 ruby20 ruby21"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md TODO NEWS"

inherit ruby-fakegem

DESCRIPTION="A ruby library for reading and writing zip files"
HOMEPAGE="https://github.com/rubyzip/rubyzip"
# Tests are not included in the gem.
SRC_URI="https://github.com/rubyzip/rubyzip/archive/v${PV}.tar.gz -> ${P}-git.tgz"

LICENSE="Ruby"
SLOT="1"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${DEPEND} test? ( app-arch/zip )"

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc samples/*
}

all_ruby_prepare() {
	# Avoid dependencies on simplecov and coveralls
	sed -i -e '/simplecov/,/^end/ s:^:#:' test/alltests.rb || die

	# Avoid dependency on bundler
	sed -i -e '/bundler/ s:^:#:' Rakefile || die
}
