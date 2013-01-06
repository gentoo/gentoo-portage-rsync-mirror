# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/fantasdic/fantasdic-1.0_beta7-r2.ebuild,v 1.1 2010/05/27 15:37:53 matsuu Exp $

EAPI="2"
#USE_RUBY="ruby18 ree18 jruby"
USE_RUBY="ruby18"
inherit eutils ruby-ng

MY_P="${P/_/-}"
DESCRIPTION="Fantasdic is a client for the DICT protocol"
HOMEPAGE="http://www.gnome.org/projects/fantasdic/"
SRC_URI="http://www.mblondel.org/files/fantasdic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome nls"

S="${WORKDIR}/${MY_P}"

ruby_add_rdepend ">=dev-ruby/ruby-libglade2-0.14.1"
ruby_add_rdepend gnome ">=dev-ruby/ruby-gnome2-0.14.1
	>=dev-ruby/ruby-gconf2-0.14.1"
ruby_add_rdepend nls ">=dev-ruby/ruby-gettext-0.6.1"

each_ruby_configure() {
	${RUBY} setup.rb config || die
}
each_ruby_compile() {
	${RUBY} setup.rb setup || die
}

each_ruby_install() {
	${RUBY} setup.rb install --prefix="${D}" || die
}

all_ruby_install() {
	domenu fantasdic.desktop || die

	# bug #298866
	rm -r "${D}usr/share/doc/fantasdic" || die
}
