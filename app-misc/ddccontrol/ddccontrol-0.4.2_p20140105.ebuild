# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ddccontrol/ddccontrol-0.4.2_p20140105.ebuild,v 1.2 2014/03/08 08:10:00 pacho Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="DDCControl allows control of monitor parameters via DDC"
HOMEPAGE="http://ddccontrol.sourceforge.net/"
COMMIT_ID="9d89d8c0b959a4da62ecc50fb2aeb23142d4bfb4"
SRC_URI="https://github.com/ddccontrol/ddccontrol/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE="+ddcpci doc gnome gtk nls static-libs video_cards_fglrx"
S=${WORKDIR}/${PN}-${COMMIT_ID}

RDEPEND="app-misc/ddccontrol-db
	dev-libs/libxml2:2
	sys-apps/pciutils
	gtk? ( x11-libs/gtk+:2 )
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
	sed -i 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die #467574
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
	touch config.rpath ABOUT-NLS
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
