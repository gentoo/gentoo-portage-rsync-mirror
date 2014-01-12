# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/klavaro/klavaro-1.9.7.ebuild,v 1.2 2014/01/12 20:03:19 pacho Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils

DESCRIPTION="Another free touch typing tutor program"
HOMEPAGE="http://klavaro.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
	x11-libs/gtk+:2
	x11-libs/gtkdatabox"

DEPEND="${RDEPEND}
	sys-devel/gettext
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )"

PATCHES=( "${FILESDIR}"/${PN}-1.9.5-gold.patch )
