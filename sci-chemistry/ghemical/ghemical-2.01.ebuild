# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ghemical/ghemical-2.01.ebuild,v 1.8 2012/05/04 07:02:33 jdhore Exp $

EAPI="1"

inherit eutils

DESCRIPTION="Chemical quantum mechanics and molecular mechanics"
HOMEPAGE="http://bioinformatics.org/ghemical/"
SRC_URI="http://bioinformatics.org/ghemical/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="threads openbabel toolbar"
RDEPEND="media-libs/freeglut
	virtual/glu
	virtual/opengl
	x11-libs/gtk+:2
	>=x11-libs/gtkglext-1.0.5
	gnome-base/libglade:2.0
	>=sci-libs/libghemical-2
	openbabel? ( >=sci-chemistry/openbabel-2 )
	threads? ( dev-libs/glib:2 )
	x11-libs/libXmu"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	# Only works with xorg-x11 GL implementation
	GL_IMPLEM=$(eselect opengl show)
	eselect opengl set xorg-x11
}

src_compile() {
	econf \
		$(use_enable toolbar shortcuts) \
		$(use_enable openbabel) \
		$(use_enable threads) \
		--enable-gamess \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	# sed -e "s:^prefix=.*:prefix=${D}/usr:" -i Makefile
	make DESTDIR="${D}" install || die "install failed"
}

pkg_postinst() {
	eselect opengl set ${GL_IMPLEM}
}
