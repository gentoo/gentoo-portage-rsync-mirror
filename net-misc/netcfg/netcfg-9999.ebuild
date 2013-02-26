# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netcfg/netcfg-9999.ebuild,v 1.1 2013/02/26 21:25:06 williamh Exp $

EAPI=5

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://projects.archlinux.org/netcfg.git"
	inherit git-2
else
	SRC_URI="ftp://ftp.archlinux.org/other/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Profile based network connection tool from Arch Linux"
HOMEPAGE="https://www.archlinux.org/netcfg/"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=">=app-shells/bash-4.0
	sys-apps/iproute2"

src_compile() {
	:
}

src_install() {
	emake DESTDIR="${D%/}" SHELL=bash install
	rm -r "${D}"etc/rc.d || die
	mv "${D}"usr/share/doc/{${PN},${PF}} || die
	dodoc AUTHORS NEWS README
}
