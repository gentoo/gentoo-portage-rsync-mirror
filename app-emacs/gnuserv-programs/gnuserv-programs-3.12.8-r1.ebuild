# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnuserv-programs/gnuserv-programs-3.12.8-r1.ebuild,v 1.3 2010/08/12 02:38:12 phajdan.jr Exp $

EAPI="3"

inherit multilib

DESCRIPTION="Binary programs for app-emacs/gnuserv"
HOMEPAGE="http://meltin.net/hacks/emacs/"
SRC_URI="http://meltin.net/hacks/emacs/src/gnuserv-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-linux ~ppc-macos"
IUSE="X"

DEPEND="!app-editors/xemacs
	!<=app-emacs/gnuserv-3.12.7
	X? ( x11-libs/libXau )"
RDEPEND="${DEPEND}"
PDEPEND="~app-emacs/gnuserv-${PV}"

S="${WORKDIR}/gnuserv-${PV}"

src_configure() {
	# bug #83112
	unset LDFLAGS

	econf $(use_enable X xauth) \
		--x-includes="${EPREFIX}"/usr/include \
		--x-libraries="${EPREFIX}"/usr/$(get_libdir)
}

src_compile() {
	emake ELC="" || die "emake failed"
}

src_install() {
	emake -j1 ELC="" \
		prefix="${ED}"/usr \
		man1dir="${ED}"/usr/share/man/man1 \
		install || die "emake install failed"
}
