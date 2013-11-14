# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rkflashtool/rkflashtool-5.0.ebuild,v 1.1 2013/11/14 01:47:27 mrueg Exp $

EAPI=5

DESCRIPTION="Tool for flashing Rockchip devices"
HOMEPAGE="http://sourceforge.net/projects/rkflashtool/"
SRC_URI="mirror://sourceforge/project/${PN}/${P}/${P}-src.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}/${P}-src

RDEPEND="virtual/libusb:1"
DEPEND="${RDEPEND}"

src_install(){
	dodoc README
	dobin ${PN}
}
