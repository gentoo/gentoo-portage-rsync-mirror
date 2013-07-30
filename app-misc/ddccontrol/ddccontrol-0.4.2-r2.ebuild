# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ddccontrol/ddccontrol-0.4.2-r2.ebuild,v 1.2 2013/07/30 15:07:51 vapier Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="DDCControl allows control of monitor parameters via DDC"
HOMEPAGE="http://ddccontrol.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+ddcpci doc gnome gtk nls static-libs video_cards_fglrx"

RDEPEND=">=app-misc/ddccontrol-db-20060730
	dev-libs/libxml2:2
	sys-apps/pciutils
	gtk? ( >=x11-libs/gtk+-2.4:2 )
	gnome? ( >=gnome-base/gnome-panel-2.10 )
	nls? ( sys-devel/gettext )
	video_cards_fglrx? ( x11-libs/amd-adl-sdk )"
DEPEND="${RDEPEND}
	dev-perl/XML-Parser
	dev-util/intltool
	sys-kernel/linux-headers
	doc? ( >=app-text/docbook-xsl-stylesheets-1.65.1
		   >=dev-libs/libxslt-1.1.6
	       app-text/htmltidy )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-pciutils-libz.patch \
		"${FILESDIR}"/${P}-automake.patch \
		"${FILESDIR}"/${P}-no-ddcpci.patch \
		"${FILESDIR}"/${P}-support-fglrx.patch
	sed -i 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die #467574

	sed -i '/^htmldir/d' doc/Makefile.am || die

	sed -i '/;Application/d' src/gddccontrol/gddccontrol.desktop.in || die

	# ppc/ppc64 do not have inb/outb/ioperm
	# they also do not have (sys|asm)/io.h
	if ! use amd64 && ! use x86 ; then
		local card
		for card in sis intel810 ; do
			sed -r -i \
				-e "/${card}.Po/d" \
				-e "s~${card}[^[:space:]]*~ ~g" \
				src/ddcpci/Makefile.{am,ini} || die
		done
		sed -i \
			-e '/sis_/d' \
			-e '/i810_/d' \
			src/ddcpci/main.c || die
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
		$(use_enable static-libs static) \
		$(use_enable video_cards_fglrx amdadl)
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.la' -delete
}
