# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-libraries/em8300-libraries-0.18.0_p20120124.ebuild,v 1.4 2012/05/21 09:49:46 phajdan.jr Exp $

EAPI=2
inherit autotools

MY_P=${P/-libraries}

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card libraries"
HOMEPAGE="http://dxr3.sourceforge.net"
SRC_URI="http://vdr.websitec.de/download/${MY_P}.tar.gz
	mirror://gentoo/em8300-gtk-2.0.m4.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="gtk modules"

COMMON_DEPEND="gtk? ( x11-libs/gtk+:2 )"
RDEPEND="${COMMON_DEPEND}
	modules? ( ~media-video/em8300-modules-${PV} )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Separate kernel modules and fix Makefile bug.
	sed -i \
		-e 's:modules/\ ::g' \
		-e "s:test -z \"\$(firmwaredir)\":test -z\"\$(DESTDIR)(firmwaredir)\":g" \
		Makefile.am || die

	# Fix asneeded linking.
	sed -i \
		-e "s:AM_LDFLAGS:LDADD:" \
		{dhc,overlay}/Makefile.am || die

	AT_M4DIR=${WORKDIR} eautoreconf
}

src_configure()	{
	econf \
		$(use_enable gtk gtktest)
}

src_install() {
	dodir /lib/firmware
	emake DESTDIR="${D}" em8300incdir=/usr/include/linux install || die
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	elog "The em8300 libraries and modules have now been installed,"
	elog "you will probably want to add /usr/bin/em8300setup to your"
	elog "/etc/conf.d/local.start so that your em8300 card is "
	elog "properly initialized on boot."
	elog
	elog "If you still need a microcode other than the one included"
	elog "with the package, you can simply use em8300setup <microcode.ux>"
}
