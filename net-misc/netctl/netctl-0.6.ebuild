# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netctl/netctl-0.6.ebuild,v 1.1 2013/03/10 22:56:40 floppym Exp $

EAPI=5

inherit eutils

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://projects.archlinux.org/netctl.git"
	inherit git-2
else
	SRC_URI="ftp://ftp.archlinux.org/other/packages/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Profile based network connection tool from Arch Linux"
HOMEPAGE="https://www.archlinux.org/netctl/"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
	>=app-shells/bash-4.0
	>=net-dns/openresolv-3.5.4[systemd]
	sys-apps/iproute2
	sys-apps/systemd
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-util-paths.patch"
}

src_compile() {
	return 0
}

src_install() {
	emake DESTDIR="${D%/}" SHELL=bash install
	dodoc AUTHORS NEWS README
}
