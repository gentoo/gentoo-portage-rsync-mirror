# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-libraries/em8300-libraries-0.17.4.ebuild,v 1.7 2012/05/05 08:58:55 jdhore Exp $

EAPI=1
inherit flag-o-matic autotools

MY_P="${P/-libraries/}"

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card libraries"
HOMEPAGE="http://dxr3.sourceforge.net"
SRC_URI="mirror://sourceforge/dxr3/${MY_P}.tar.gz"

COMMON_DEPEND="gtk? ( x11-libs/gtk+:2 )"
RDEPEND="${COMMON_DEPEND}
	~media-video/em8300-modules-${PV}"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"
IUSE="gtk"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Separate kernel modules.
	sed -i -e 's:modules/\ ::g' Makefile.am

	# Fix Makefile bug.
	sed -i -e "s:test -z \"\$(firmwaredir)\":test -z\"\$(DESTDIR)(firmwaredir)\":g" Makefile.am

	# Fix asneeded linking.
	sed -i -e "s:AM_LDFLAGS:LDADD:" {dhc,overlay}/Makefile.am || die

	eautoreconf
}

src_compile ()	{
	use amd64 && append-flags -fPIC

	econf \
		$(use_enable gtk gtktest) || die "econf failed."

	emake || die "emake failed."
}

src_install () {
	dodir /lib/firmware
	emake DESTDIR="${D}" em8300incdir=/usr/include/linux install \
		|| die "emake install failed."

	dodoc AUTHORS ChangeLog NEWS README
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
