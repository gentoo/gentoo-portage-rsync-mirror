# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/slimlock/slimlock-0.11.ebuild,v 1.2 2012/06/27 15:29:10 ssuominen Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Screen locker borrowing the interface of the SLiM login-manager"
HOMEPAGE="http://joelburget.com/slimlock/"
SRC_URI="http://github.com/joelburget/slimlock/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=media-libs/freetype-2
		 media-libs/imlib2[png,jpeg]
		 virtual/pam
		 x11-libs/libX11
		 x11-libs/libXext
		 x11-libs/libXft
		 x11-misc/slim[pam]
"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}

	# GitHub tarballs the package under a randomly named TLD.
	mv * ${P}
}

src_compile() {
	emake CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		CFGDIR="${EPREFIX%/}/etc" \
		MANDIR="${EPREFIX%/}/usr/share/man"
		PREFIX="${EPREFIX%/}/usr"
}
