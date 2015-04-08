# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hprofile/hprofile-3.0.5.ebuild,v 1.1 2014/10/19 05:28:00 vapier Exp $

EAPI=5

DESCRIPTION="Utility to manage hardware, network, power or other profiles (fork)"
HOMEPAGE="https://github.com/tokiclover/hprofile"
SRC_URI="https://github.com/tokiclover/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	sed -i '1s:.*:#!/sbin/runscript:' hprofile.initd || die
	sed -i "/^prefix/s:=.*:=${EPREFIX}/usr:" Makefile || die
}
