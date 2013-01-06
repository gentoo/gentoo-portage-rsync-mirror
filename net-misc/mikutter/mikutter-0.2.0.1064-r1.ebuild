# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mikutter/mikutter-0.2.0.1064-r1.ebuild,v 1.1 2012/12/05 12:33:55 naota Exp $

EAPI=3

USE_RUBY="ruby19"

inherit ruby-ng

if [ "${PV}" = "9999" ]; then
	ESVN_REPO_URI="svn://toshia.dip.jp/mikutter/trunk"
	inherit subversion
	KEYWORDS=""
else
	MY_P="${PN}.${PV}"
	SRC_URI="http://mikutter.hachune.net/bin/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="mikutter is simple, powerful and moeful twitter client"
HOMEPAGE="http://mikutter.hachune.net/"

LICENSE="GPL-3"
SLOT="0"
IUSE="+libnotify sound"

DEPEND=""
RDEPEND="libnotify? ( x11-libs/libnotify )
	sound? ( media-sound/alsa-utils )"

ruby_add_rdepend "dev-ruby/ruby-gtk2
	dev-ruby/rcairo
	dev-ruby/httpclient
	virtual/ruby-ssl"

S="${WORKDIR}/${PN}"

each_ruby_install() {
	exeinto /usr/share/mikutter
	doexe mikutter.rb
	insinto /usr/share/mikutter
	doins -r core plugin
	insinto /usr/share/mikutter/vendor
	doins vendor/escape.rb
	exeinto /usr/bin
	doexe "${FILESDIR}"/mikutter
	dodoc README
}
