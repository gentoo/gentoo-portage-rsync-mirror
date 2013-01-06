# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gringotts/gringotts-1.2.10.ebuild,v 1.7 2012/05/03 18:16:38 jdhore Exp $

EAPI="2"

inherit eutils fdo-mime

DESCRIPTION="Utility that allows you to jot down sensitive data"
HOMEPAGE="http://gringotts.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="suid"

RDEPEND=">=dev-libs/libgringotts-1.2
	>=x11-libs/gtk+-2.12:2
	dev-libs/popt"

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	# Drop DEPRECATION flags, bug #387831
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		src/Makefile.am src/Makefile.in || die

	# Patch up to install desktop entry correctly
	epatch "${FILESDIR}/${PN}-1.2.10-desktop.patch"
	epatch "${FILESDIR}/${PN}-1.2.8-desktop-entry.patch"

	# Prevent prestripping
	epatch "${FILESDIR}/${PN}-1.2.10-no-strip.patch"
}

src_configure() {
	econf --docdir=/usr/share/doc/${PF}
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	# The FAQ and README documents shouldn't be gzip'd, as they need to be
	# available in plain format when they are called from the `Help' menu.
	#
	# dodoc FAQ README
	rm "${D}"/usr/share/doc/${PF}/{AUTHORS,COPYING,BUGS,ChangeLog,TODO,NEWS} \
		|| die "rm failed"
	dodoc AUTHORS BUGS ChangeLog NEWS TODO || die "dodoc failed"
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	if use suid; then
		ewarn "You have installed a suid binary for the \`gringotts' program."
		ewarn "Be aware that this setup may break with some glibc installations"
		ewarn "For more information, see bug #69458 in Gentoo's bugzilla at:"
		ewarn "  http://bugs.gentoo.org/"
	else
		einfo "Changing permissions for the gringotts binary."
		chmod u-s "${ROOT}"/usr/bin/gringotts
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
