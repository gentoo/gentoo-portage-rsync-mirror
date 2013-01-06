# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libgnomecups/libgnomecups-0.2.3.ebuild,v 1.10 2012/05/03 07:22:29 jdhore Exp $

inherit eutils gnome2

DESCRIPTION="GNOME cups library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=net-print/cups-1.3.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog NEWS"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/enablenet.patch
}
