# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/nvidiabl/nvidiabl-0.79.ebuild,v 1.1 2012/09/16 11:47:32 angelos Exp $

EAPI=4
inherit linux-mod

DESCRIPTION="Linux driver for setting the backlight brightness on laptops using
NVIDIA GPU"
HOMEPAGE="https://github.com/guillaumezin/nvidiabl"
SRC_URI="mirror://github/guillaumezin/${PN}/${P}-source-only.dkms.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

BUILD_TARGETS="modules"
MODULE_NAMES="nvidiabl()"

S=${WORKDIR}/dkms_source_tree

pkg_pretend() {
	CONFIG_CHECK="FB_BACKLIGHT"
	ERROR_FB_BACKLIGHT="Your kernel does not support FB_BACKLIGHT. To enable you
it you can enable any frame buffer with backlight control or nouveau.
Note that you cannot use FB_NVIDIA with nvidia's proprietary driver"
	linux-mod_pkg_setup
}

src_compile() {
	BUILD_PARAMS="KVER=${KV_FULL}"
	linux-mod_src_compile
}
