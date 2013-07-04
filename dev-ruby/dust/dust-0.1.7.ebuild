# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/dust/dust-0.1.7.ebuild,v 1.3 2013/07/04 09:13:32 ago Exp $

EAPI="4"
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem

DESCRIPTION="Descriptive block syntax definition for Test::Unit."
HOMEPAGE="http://dust.rubyforge.org/"
LICENSE="MIT"
SRC_URI="mirror://rubyforge/dust/${P}.gem"

KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

# Remove a long-obsolete rubygems method.
all_ruby_prepare() {
	sed -i '/manage_gems/d' rakefile.rb || die "Unable to update rakefile.rb"
}

each_ruby_prepare() {
	sed -i '/manage_gems/d' rakefile.rb || die "Unable to update rakefile.rb"
}

each_ruby_test() {
	${RUBY} -I. test/all_tests.rb || die
}
