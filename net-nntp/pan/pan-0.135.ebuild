# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-0.135.ebuild,v 1.10 2012/05/03 04:32:51 jdhore Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A newsreader for GNOME"
HOMEPAGE="http://pan.rebelbase.com/"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="spell"

RDEPEND=">=dev-libs/glib-2.14:2
	>=x11-libs/gtk+-2.16:2
	dev-libs/gmime:2.6
	spell? ( >=app-text/gtkspell-2.0.7:2 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	# XXX: disable the only failing test
	#sed '293 s:^\(.*\)$:/*\1*/:' \
	#	-i pan/usenet-utils/text-massager-test.cc || die "sed failed"
	epatch "${FILESDIR}/pan-0.135-glib-2.31.patch" # 401437
}

src_configure() {
	econf --without-gtk3 $(use_with spell gtkspell)
}
