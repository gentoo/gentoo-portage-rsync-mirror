# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ddccontrol/ddccontrol-0.4.2-r1.ebuild,v 1.4 2012/08/08 22:32:18 blueness Exp $

EAPI="4"

inherit eutils autotools

DESCRIPTION="DDCControl allows control of monitor parameters via DDC"
HOMEPAGE="http://ddccontrol.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="+ddcpci doc gnome gtk nls static-libs"

RDEPEND="dev-libs/libxml2:2
	gtk? ( >=x11-libs/gtk+-2.4:2 )
	gnome? ( >=gnome-base/gnome-panel-2.10 )
	sys-apps/pciutils
	nls? ( sys-devel/gettext )
	>=app-misc/ddccontrol-db-20060730"
DEPEND="${RDEPEND}
	dev-perl/XML-Parser
	dev-util/intltool
	doc? ( >=app-text/docbook-xsl-stylesheets-1.65.1
		   >=dev-libs/libxslt-1.1.6
	       app-text/htmltidy )
	sys-kernel/linux-headers"

src_prepare() {
	epatch "${FILESDIR}"/${P}-pciutils-libz.patch
	epatch "${FILESDIR}"/${P}-automake.patch
	epatch "${FILESDIR}"/${P}-no-ddcpci.patch
	sed -i '/^htmldir/d' doc/Makefile.am || die

	# ppc/ppc64 do not have inb/outb/ioperm
	# they also do not have (sys|asm)/io.h
	if ! use amd64 && ! use x86 ; then
		local card
		for card in sis intel810 ; do
			sed -r -i \
				-e "/${card}.Po/d" \
				-e "s~${card}[^[:space:]]*~ ~g" \
				src/ddcpci/Makefile.{am,in}
		done
		sed -i \
			-e '/sis_/d' \
			-e '/i810_/d' \
			src/ddcpci/main.c
	fi

	## Save for a rainy day or future patching
	eautoreconf
	intltoolize --force || die "intltoolize failed"
}

src_configure() {
	econf \
		--htmldir='$(datarootdir)'/doc/${PF}/html \
		$(use_enable ddcpci) \
		$(use_enable doc) \
		$(use_enable gnome gnome-applet) \
		$(use_enable gtk gnome) \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.la' -delete
}
