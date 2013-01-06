# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/chemtool/chemtool-1.6.12-r1.ebuild,v 1.3 2012/05/04 07:02:32 jdhore Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="A GTK program for drawing organic molecules"
HOMEPAGE="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/"
SRC_URI="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="emf gnome nls"

RDEPEND="
	dev-libs/glib:2
	media-gfx/transfig
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/pango
	emf? ( media-libs/libemf )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-no-underlinking.patch
	eautoreconf
}

src_configure() {
	local mycppflags

	if use emf; then
		mycppflags="${mycppflags} -I /usr/include/libEMF"
	fi

	sed -e "s:\(^CPPFLAGS.*\):\1 ${mycppflags}:" -i Makefile.in || \
		die "could not append cppflags"

	econf \
		--without-kdedir \
		$(use_with gnome gnomedir /usr) \
		$(use_enable emf) \
		--enable-menu
}

src_install() {
	default
	insinto /usr/share/${PN}/examples
	doins "${S}"/examples/*
	if ! use nls; then rm -rf "${ED}"/usr/share/locale; fi

	insinto /usr/share/pixmaps
	doins chemtool.xpm
	make_desktop_entry ${PN} Chemtool ${PN} "Education;Science;Chemistry"
}
