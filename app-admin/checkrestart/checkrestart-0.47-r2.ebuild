# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/checkrestart/checkrestart-0.47-r2.ebuild,v 1.1 2011/12/12 22:54:44 jer Exp $

EAPI="4"

inherit eutils

DESCRIPTION="the sysadmin's rolling upgrade tool"
HOMEPAGE="http://arcdraco.net/checkrestart"
SRC_URI="http://arcdraco.net/~dragon/${P}-sep.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	=dev-lang/python-2*
	sys-apps/lsb-release
	app-portage/portage-utils
	sys-process/lsof
"

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${P}-list-comprehension-fix.patch
	sed -i ${PN} -e '1{s|python|&2|g}' || die
}

src_install() {
	dosbin ${PN}
}
