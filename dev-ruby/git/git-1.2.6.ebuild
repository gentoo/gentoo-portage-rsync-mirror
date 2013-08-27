# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/git/git-1.2.6.ebuild,v 1.1 2013/08/27 18:15:33 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="History.txt README.md TODO"

inherit ruby-fakegem

DESCRIPTION="Library for using Git in Ruby"
HOMEPAGE="http://github.com/schacon/ruby-git"
SRC_URI="https://github.com/schacon/ruby-git/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RUBY_S="ruby-git-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND+="test? ( >=dev-vcs/git-1.6.0.0 app-arch/tar )"
RDEPEND+=">=dev-vcs/git-1.6.0.0"

ruby_add_bdepend "test? ( dev-ruby/test-unit:2 )"

all_ruby_prepare() {
	# Needs test-unit, the test-unit version distributed with ruby19 is
	# not good enough.
	sed -i -e '3igem "test-unit"' Rakefile || die

	# Don't use hardcoded /tmp directory.
	sed -i -e "s:/tmp:${TMPDIR}:" tests/units/test_archive.rb tests/test_helper.rb || die
}
