# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tex-guy/tex-guy-1.3.2.ebuild,v 1.1 2007/11/04 11:13:56 drac Exp $

MY_P=TeX-Guy-${PV}

DESCRIPTION="Set of TeX DVI previewers and printer drivers."
HOMEPAGE="http://www-masu.ist.osaka-u.ac.jp/~kakugawa/TeX-Guy"
SRC_URI="http://www-masu.ist.osaka-u.ac.jp/~kakugawa/download/TypeHack/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="gtk"

RDEPEND=">=media-libs/vflib-3.6.14
	media-libs/aalib
	x11-libs/libX11
	gtk? ( =x11-libs/gtk+-1.2* )"
DEPEND="${RDEPEND}
	x11-misc/imake"

S="${WORKDIR}"/${MY_P}

src_install() {
	einstall localedir="${D}"/usr/share/locale || die "installation failed."
	rm -rf "${D}"/usr/man
	doman man/*.gz
	dodoc 00_* CHANGES
}
